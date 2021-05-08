#include "ICM20948_9DMP.h"

ICM20948_9DMP::ICM20948_9DMP(){}

ICM_20948_Status_e ICM20948_9DMP::begin(bool ad0val, uint8_t ad0pin){

#ifdef ICM20948_ENABLE_DEBUGGING
	enableDebugging();
#endif

	ICM_20948_I2C::begin(Wire, ad0val, ad0pin);
	if(status != ICM_20948_Stat_Ok){
		debugPrint(F("ICM_20948_I2C::begin: startupDefault returned: "));
		debugPrintStatus(status);
		debugPrintln(F(""));
		return status;
	};
	configureDMP();
	return status;
}

ICM_20948_Status_e ICM20948_9DMP::configureDMP(void){
	bool success = true; // Use success to show if the DMP configuration was successful

	// Initialize the DMP. initializeDMP is a weak function. In this example we overwrite it to change the sample rate (see below)
	success &= (initializeDMP() == ICM_20948_Stat_Ok);

	// DMP sensor options are defined in ICM_20948_DMP.h
	//    INV_ICM20948_SENSOR_ACCELEROMETER               (16-bit accel)
	//    INV_ICM20948_SENSOR_GYROSCOPE                   (16-bit gyro + 32-bit calibrated gyro)
	//    INV_ICM20948_SENSOR_RAW_ACCELEROMETER           (16-bit accel)
	//    INV_ICM20948_SENSOR_RAW_GYROSCOPE               (16-bit gyro + 32-bit calibrated gyro)
	//    INV_ICM20948_SENSOR_MAGNETIC_FIELD_UNCALIBRATED (16-bit compass)
	//    INV_ICM20948_SENSOR_GYROSCOPE_UNCALIBRATED      (16-bit gyro)
	//    INV_ICM20948_SENSOR_STEP_DETECTOR               (Pedometer Step Detector)
	//    INV_ICM20948_SENSOR_STEP_COUNTER                (Pedometer Step Detector)
	//    INV_ICM20948_SENSOR_GAME_ROTATION_VECTOR        (32-bit 6-axis quaternion)
	//    INV_ICM20948_SENSOR_ROTATION_VECTOR             (32-bit 9-axis quaternion + heading accuracy)
	//    INV_ICM20948_SENSOR_GEOMAGNETIC_ROTATION_VECTOR (32-bit Geomag RV + heading accuracy)
	//    INV_ICM20948_SENSOR_GEOMAGNETIC_FIELD           (32-bit calibrated compass)
	//    INV_ICM20948_SENSOR_GRAVITY                     (32-bit 6-axis quaternion)
	//    INV_ICM20948_SENSOR_LINEAR_ACCELERATION         (16-bit accel + 32-bit 6-axis quaternion)
	//    INV_ICM20948_SENSOR_ORIENTATION                 (32-bit 9-axis quaternion + heading accuracy)

	// Enable the DMP Game Rotation Vector sensor (Quat6)
	success &= (enableDMPSensor(INV_ICM20948_SENSOR_GAME_ROTATION_VECTOR) == ICM_20948_Stat_Ok);
	/* success &= (enableDMPSensor(INV_ICM20948_SENSOR_ROTATION_VECTOR) == ICM_20948_Stat_Ok); */

	// Enable additional sensors / features
	success &= (enableDMPSensor(INV_ICM20948_SENSOR_RAW_GYROSCOPE) == ICM_20948_Stat_Ok);
	/* success &= (enableDMPSensor(INV_ICM20948_SENSOR_RAW_ACCELEROMETER) == ICM_20948_Stat_Ok); */
	/* success &= (enableDMPSensor(INV_ICM20948_SENSOR_MAGNETIC_FIELD_UNCALIBRATED) == ICM_20948_Stat_Ok); */
	success &= (enableDMPSensor(INV_ICM20948_SENSOR_GEOMAGNETIC_FIELD) == ICM_20948_Stat_Ok);

	// Configuring DMP to output data at multiple ODRs:
	// DMP is capable of outputting multiple sensor data at different rates to FIFO.
	// Setting value can be calculated as follows:
	// Value = (DMP running rate / ODR ) - 1
	// E.g. For a 225Hz ODR rate when DMP is running at 225Hz, value = (225/225) - 1 = 0.
	success &= (setDMPODRrate(DMP_ODR_Reg_Quat6, 0) == ICM_20948_Stat_Ok); // Set to 225Hz
	success &= (setDMPODRrate(DMP_ODR_Reg_Accel, 0) == ICM_20948_Stat_Ok); // Set to 225Hz
	success &= (setDMPODRrate(DMP_ODR_Reg_Gyro, 0) == ICM_20948_Stat_Ok); // Set to 225Hz
	success &= (setDMPODRrate(DMP_ODR_Reg_Cpass, 0) == ICM_20948_Stat_Ok); // Set to 225Hz

	// Enable the FIFO
	success &= (enableFIFO() == ICM_20948_Stat_Ok);

	// Enable the DMP
	success &= (enableDMP() == ICM_20948_Stat_Ok);

	// Reset DMP
	success &= (resetDMP() == ICM_20948_Stat_Ok);

	// Reset FIFO
	success &= (resetFIFO() == ICM_20948_Stat_Ok);

	// Check success
	if (success)
	{
		debugPrintln(F("DMP enabled!"));
	}
	else
	{
		debugPrintln(F("Enable DMP failed!"));
		debugPrintln(F("Please check that you have uncommented line 29 (#define ICM_20948_USE_DMP) in ICM_20948_C.h..."));
		while (1)
			; // Do nothing more
	}

	return status;
}


unsigned short ICM20948_9DMP::fifoAvailable(void){
	uint16_t res;
	return getFIFOcount(&res)==ICM_20948_Stat_Ok ? res : 0;
};



ICM_20948_Status_e ICM20948_9DMP::dmpUpdateFifo(void){
	icm_20948_DMP_data_t data;
	readDMPdataFromFIFO(&data);
	while(status==ICM_20948_Stat_FIFOMoreDataAvail){
		readDMPdataFromFIFO(&data);
		delay(1);
	}

	if(status == ICM_20948_Stat_Ok ){
		if ((data.header & DMP_header_bitmap_Quat6) > 0 ){
			/* qw = data.Quat6.Data.Q0; */
			/* qx = data.Quat9.Data.Q1;// / 1073741824.0; // Convert to double. Divide by 2^30 */
			/* qy = data.Quat9.Data.Q2;// / 1073741824.0; // Convert to double. Divide by 2^30 */
			/* qz = data.Quat9.Data.Q3;// / 1073741824.0; // Convert to double. Divide by 2^30 */
			qx = data.Quat6.Data.Q1;// / 1073741824.0; // Convert to double. Divide by 2^30
			qy = data.Quat6.Data.Q2;// / 1073741824.0; // Convert to double. Divide by 2^30
			qz = data.Quat6.Data.Q3;// / 1073741824.0; // Convert to double. Divide by 2^30
			qw = sqrt( 1.0 - ((qx * qx) + (qy * qy) + (qz * qz)));
		};
		/* if ( (data.header & DMP_header_bitmap_Compass) > 0 ){ */
		if ( (data.header & DMP_header_bitmap_Compass_Calibr) > 0 ){
			/* debugPrint(F("my data: ")); */
			/* debugPrintf(data.Compass_Calibr.Data.Y); */
			/* debugPrintln(""); */
			mx = data.Compass_Calibr.Data.X; // Extract the compass data
			my = data.Compass_Calibr.Data.Y; 
			mz = data.Compass_Calibr.Data.Z; 
			/* debugPrint("data raw, mx:"); */
			/* Serial.print(data.Compass_Calibr.Data.X); */
			/* Serial.print(", "); */
			/* Serial.print(mx); */
			/* debugPrintln(""); */
			/* mx = data.Compass.Data.X; // Extract the compass data */
			/* my = data.Compass.Data.Y; */ 
			/* mz = data.Compass.Data.Z; */ 
		};
	}
	return ICM_20948_Stat_Ok; // status;
};


ICM_20948_Status_e ICM20948_9DMP::updateCompass(void){
	return dmpUpdateFifo();
}


ICM_20948_Status_e ICM20948_9DMP::updateTemperature(void){
	temperature = temp();
	status=ICM_20948_Stat_Ok;
	return status;
}


float ICM20948_9DMP::qToFloat(long number, unsigned char q){	
	// https://github.com/sparkfun/SparkFun_MPU-9250-DMP_Arduino_Library/issues/5
	return (float)((double)number / (double)(1 << q));
}


float ICM20948_9DMP::computeCompassHeading(void)
{
	if (my == 0)
		heading = (mx < 0) ? PI : 0;
	else
		heading = atan2(mx, my);
	
	if (heading > PI) heading -= (2 * PI);
	else if (heading < -PI) heading += (2 * PI);
  //bber 60
  //remove to rescale form -pi to pi
	//else if (heading < 0) heading += 2 * PI;
	//heading*= 180.0 / PI;
	
	return heading;
}


void ICM20948_9DMP::computeEulerAngles(bool degrees){

	float dqw = qToFloat(qw, 30);
	float dqx = qToFloat(qx, 30);
	float dqy = qToFloat(qy, 30);
	float dqz = qToFloat(qz, 30);

	float norm = sqrt(dqw*dqw + dqx*dqx + dqy*dqy + dqz*dqz);
	dqw = dqw/norm;
	dqx = dqx/norm;
	dqy = dqy/norm;
	dqz = dqz/norm;

	float ysqr = dqy * dqy;

	// roll (x-axis rotation)
	float t0 = +2.0 * (dqw * dqx + dqy * dqz);
	float t1 = +1.0 - 2.0 * (dqx * dqx + ysqr);
	roll = atan2(t0, t1);

	// pitch (y-axis rotation)
	float t2 = +2.0 * (dqw * dqy - dqz * dqx);
	t2 = t2 > 1.0 ? 1.0 : t2;
	t2 = t2 < -1.0 ? -1.0 : t2;
	pitch = asin(t2);

	// yaw (z-axis rotation)
	float t3 = +2.0 * (dqw * dqz + dqx * dqy);
	float t4 = +1.0 - 2.0 * (ysqr + dqz * dqz);  
	yaw = atan2(t3, t4);

	if (degrees){
		pitch *= (180.0 / PI);
		roll *= (180.0 / PI);
		yaw *= (180.0 / PI);
		if (pitch < 0) pitch = 360.0 + pitch;
		if (roll < 0) roll = 360.0 + roll;
		if (yaw < 0) yaw = 360.0 + yaw;	
	}
};

