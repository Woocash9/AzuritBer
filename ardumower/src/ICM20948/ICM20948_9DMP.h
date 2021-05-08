#include <Arduino.h> // Arduino support
#include "lib/ICM_20948.h"

#define ICM20948_ENABLE_DEBUGGING
#define INV_SUCCESS ICM_20948_Stat_Ok

class ICM20948_9DMP : public ICM_20948_I2C{
	private:
	protected:
		ICM_20948_Status_e configureDMP(void);
	public:
		int16_t mx, my, mz;
		long qw, qx, qy, qz;
		long temperature;
		unsigned long time;
		float pitch, roll, yaw;
		float heading;
		ICM20948_9DMP(); // Constructor
		ICM_20948_Status_e begin(bool ad0val=true, uint8_t ad0pin = ICM_20948_ARD_UNUSED_PIN);
		unsigned short fifoAvailable(void);
		ICM_20948_Status_e dmpUpdateFifo(void);
		ICM_20948_Status_e updateCompass(void);
		ICM_20948_Status_e updateTemperature(void);
		float qToFloat(long number, unsigned char q);	
		float computeCompassHeading(void);
		void computeEulerAngles(bool degrees);
};

