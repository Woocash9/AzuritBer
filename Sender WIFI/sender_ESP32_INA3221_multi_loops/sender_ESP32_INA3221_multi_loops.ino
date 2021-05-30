#include <Wire.h>
#include <WiFi.h>
/* #include "src/MemoryFree/MemoryFree.h" */
#include "config.h"


hw_timer_t * timer = NULL;
portMUX_TYPE timerMux = portMUX_INITIALIZER_UNLOCKED;



#define SIZEOF(x) ( sizeof x / sizeof x[0] ) //macro for array elements calculation

// code version
#define VER "ESP32 3.0"

volatile int step = 0;


//boolean WiffiRequestOn = true;

uint8_t signals[] = {LOW, HIGH};
LOOP *activeLoop = NULL;

int timeSeconds = 0;
unsigned long nextTimeControl = 0;
unsigned long nextTimeInfo = 0;
unsigned long nextTimeSec = 0;
unsigned long nextTimeCheckButton = 0;
int workTimeMins = 0;
boolean StartButtonProcess = false;

int Button_pressed = 0;


float PeriCurrent = 0;
float ChargeCurrent = 0;
float busvoltage1 = 0;

float shuntvoltage2 = 0;
float busvoltage2 = 0;
float loadvoltage2 = 0;
 
//*********************  Sigcode list *********************************************
// must be multiple of 2 !
// http://grauonline.de/alexwww/ardumower/filter/filter.html
// "pseudonoise4_pw" signal (sender)
//woocash - use 0 insted of -1 so it is possible to use signals array for signal generation
#if defined (SIGCODE_0)	
	uint8_t sigCode[] = { 1, 0 };  //simple square test code
#elif defined (SIGCODE_1)   
	uint8_t sigCode[] = { 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0 };  //ardumower signal code
#elif defined (SIGCODE_2)   
	uint8_t sigCode[] = { 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1,
		0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1 };
#elif defined (SIGCODE_3)   
	uint8_t sigCode[] = { 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1,
		0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1,
		0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0,
		1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1 }; // 128 Zahlen from Roland
#elif defined (SIGCODE_4)   
	uint8_t sigCode[] = { 1, 1, 1, 0, 0, 0};  //extend square test code
#endif

uint8_t sigCodeSize = SIZEOF(sigCode);

WiFiServer server(80);
SDL_Arduino_INA3221 ina3221;

void IRAM_ATTR onTimer() { // management of the signal
	portENTER_CRITICAL_ISR(&timerMux);
	if(activeLoop){
		if (step > sigCodeSize) {
			step = 0;
		}
		digitalWrite(activeLoop->pIN1, signals[!sigCode[step]]);
		digitalWrite(activeLoop->pIN2, signals[sigCode[step]]);
	}
	step ++;
	portEXIT_CRITICAL_ISR(&timerMux);
}

void setup(){
	Wire.begin(I2C_SDA, I2C_SCL);

	//------------------------  Signal parts  ----------------------------------------
	Serial.begin(115200);
	timer = timerBegin(0, 80, true);
	timerAttachInterrupt(timer, &onTimer, true);
	timerAlarmWrite(timer, 104, true);
	timerAlarmEnable(timer);

	//set OUT mode for all signal pins 
	for(int i=0; i<SIZEOF(loops);i++){
		pinMode(loops[i].pIN1,OUTPUT);
		pinMode(loops[i].pIN2,OUTPUT);
		pinMode(loops[i].pEnable,OUTPUT);
	}

	pinMode(pinPushButton, INPUT_PULLUP);
	pinMode(pinRainFlow, INPUT);

	Serial.println("START");
	Serial.print("Ardumower Sender ");
	Serial.println(VER);
	Serial.print("USE_PERI_CURRENT=");
	Serial.println(USE_PERI_CURRENT);

	//------------------------  WIFI parts  ----------------------------------------
	// Set WiFi to station mode and disconnect from an AP if it was previously connected
	if (WiFi.config(staticIP, gateway, subnet, dns, dns) == false) {
		Serial.println("WIFI Configuration failed.");
	}
	WiFi.mode(WIFI_STA);
	WiFi.disconnect();
	delay(100);
	//------------------------  SCREEN parts  ----------------------------------------
	oled.init();    // Initialze SSD1306 OLED display
	delay(500);
	oled.clearDisplay();              // Clear screen
	delay(500);
	oled.setTextXY(0, 0);             // Set cursor position, start of line 0
	oled.putLine("ARDUMOWER");
	oled.setTextXY(1, 0);             // Set cursor position, start of line 1
	oled.putLine("LK SENDER");
	oled.setTextXY(2, 0);             // Set cursor position, start of line 2
	oled.putLine(VER);
	oled.setTextXY(3, 0);           // Set cursor position, line 2 10th character
	oled.putLine("MULTI LOOPS");

	//------------------------  current sensor parts  ----------------------------------------
	Serial.println("Measuring voltage and current using ina3221 ...");
	ina3221.begin();
	Serial.print("Manufactures ID=0x");
	int MID;
	MID = ina3221.getManufID();
	Serial.println(MID, HEX);
	delay(5000);
}


void connection() {
	oled.clearDisplay();
	Serial.println();
	Serial.print("Connecting to ");
	Serial.println(ssid);
	//WiFi.setAutoReconnect(true);
	WiFi.begin(ssid, password);
	for (int i = 0; i < 60; i++)
	{
		if ( WiFi.status() != WL_CONNECTED )
		{
			oled.setTextXY(0, 0);
			oled.putLine("Try connecting");
			delay (250);
		}
	}

	if ( WiFi.status() == WL_CONNECTED )
	{
		IPAddress ip = WiFi.localIP();
		char bufIP[16];
		sprintf(bufIP, "%d.%d.%d.%d", ip[0], ip[1], ip[2], ip[3]);
		Serial.println("WiFi connected.");
		Serial.println("IP address: ");
		Serial.println(bufIP);
		oled.clearDisplay();
		oled.setTextXY(0, 0);
		oled.putLine("WIFI Connected");
		oled.setTextXY(1, 0);
		oled.putLine(bufIP);
		server.begin();
	}
}


static void ScanNetwork(){
	oled.clearDisplay();
	WiFi.mode(WIFI_STA);
	WiFi.disconnect();
	oled.setTextXY(0, 0);
	oled.putLine("Hotspot Lost");
	oled.setTextXY(3, 0);
	oled.putLine(activeLoop ? "Sender ON" : "Sender OFF");
	oled.setTextXY(4, 0);
	oled.putLine("worktime=");
	oled.setTextXY(4, 9);
	oled.putFloat(workTimeMins, 0);

	if (USE_PERI_CURRENT) {
		busvoltage1 = ina3221.getBusVoltage_V(PERI_CURRENT_CHANNEL);
		PeriCurrent = ina3221.getCurrent_mA(PERI_CURRENT_CHANNEL);
		PeriCurrent = PeriCurrent - 100.0; //the DC/DC,ESP32,LN298N can drain up to 300 ma when scanning network
		if (PeriCurrent <= 5) PeriCurrent = 0; //
		PeriCurrent = PeriCurrent * busvoltage1 / DcDcOutVoltage; // it's 3.2666 = 29.4/9.0 the power is read before the DC/DC converter so the current change according : 29.4V is the Power supply 9.0V is the DC/DC output voltage (Change according your setting)
		oled.setTextXY(5, 0);
		oled.putLine("Pericurr");
		oled.setTextXY(5, 9);
		oled.putFloat(PeriCurrent, 0);
	}


	if (USE_STATION) {
		ChargeCurrent = ina3221.getCurrent_mA(MOWER_STATION_CHANNEL);
		if(ChargeCurrent <= 5) ChargeCurrent = 0;
		oled.setTextXY(6, 0);
		oled.putLine("Charcurr");
		oled.setTextXY(6, 9);
		oled.putFloat(ChargeCurrent, 0);
	}
	delay(5000);  // wait until all is disconnect
	int n = WiFi.scanNetworks();
	switch(n){
		case -1:
			oled.setTextXY(0, 0);
			oled.putLine("Scan running ???");
			oled.setTextXY(1, 0);
			oled.putLine("Need Reset ???");
			oled.setTextXY(2, 0);
			oled.putLine("If sender is OFF");
			delay(5000);
			if (activeLoop==NULL) ESP.restart(); // do not reset if sender is ON
			break;
		case -2:
			//bug in esp32 if wifi is lost many time the esp32 fail to autoreconnect,maybe solve in other firmware ???????
			oled.setTextXY(0, 0);
			oled.putLine("Scan Fail.");
			oled.setTextXY(1, 0);
			oled.putLine("Need Reset ???");
			oled.setTextXY(2, 0);
			oled.putLine("If sender is Off");
			delay(5000);
			if (activeLoop==NULL) ESP.restart(); // do not reset if sender is ON
			break;
		case 0:
			oled.setTextXY(0, 0);
			oled.putLine("No networks.");
			break;
		default:
			if (n > 0){
				Serial.print("find ");
				Serial.println(n);
				oled.setTextXY(0, 0);
				oled.putLine("Find");
				for (int i = 0; i < n; ++i) {
					// Print SSID for each network found
					char currentSSID[64];
					WiFi.SSID(i).toCharArray(currentSSID, 64);
					Serial.print("find Wifi: ");
					Serial.println(currentSSID);
					oled.setTextXY(0, 5);
					oled.putString(currentSSID);
					delay (1500);
					if (strcmp(ssid, currentSSID) == 0) {
						connection();
						i = n+1; //to avoid loop again when connected
					}
				}
			}
	}
}

void stopSender(){
	if(activeLoop){
		LOOP *oldLoop = activeLoop;
		activeLoop = NULL;
		digitalWrite(oldLoop->pEnable, LOW);
		digitalWrite(oldLoop->pIN1, LOW);
		digitalWrite(oldLoop->pIN2, LOW);
		Serial.print("Stopped sender in loop: ");
		Serial.println(oldLoop->code);
	}
}


bool startLoop(LOOP *loop){
	loop = loop ? loop : &loops[0]; //if no loop requested default to first one
	stopSender();
	digitalWrite(loop->pEnable, HIGH);
	activeLoop = loop;
	Serial.print("Started loop: ");
	Serial.println(activeLoop->code);
	return true;
}

bool startLoop(uint8_t index){
	if(index>0 && index <= SIZEOF(loops)){
		return startLoop(&loops[index-1]);
	}else{
		return false;
	}
}

bool startNextLoop(){
	if(activeLoop==NULL){
		return startLoop(1); //no active loop so far; start with the first one
	}
	for(int i=0; i<SIZEOF(loops);i++){
		if(&loops[i]==activeLoop){ //find index of active loop
			if(i==SIZEOF(loops)-1){
				return startLoop(1); //last loop active so start the first one
			}else{
				return startLoop(&loops[i+1]); //not last activie so start the next
			}
		}
	}
	return false;
}

void loop(){
	if (millis() >= nextTimeControl) {
		nextTimeControl = millis() + 2000;  //after debug can set this to 10 secondes
		StartButtonProcess = false;
		oled.setTextXY(4, 0);
		oled.putLine("worktime ");
		oled.setTextXY(4, 9);
		oled.putFloat(workTimeMins, 0);
		if (USE_PERI_CURRENT) {
			busvoltage1 = ina3221.getBusVoltage_V(PERI_CURRENT_CHANNEL);
			PeriCurrent = ina3221.getCurrent_mA(PERI_CURRENT_CHANNEL);
			PeriCurrent = PeriCurrent - 100.0; //the DC/DC,ESP32,LN298N drain 100 ma when nothing is ON and a wifi access point is found (To confirm ????)
			if (PeriCurrent <= 5) PeriCurrent = 0; //
			PeriCurrent = PeriCurrent * busvoltage1 / DcDcOutVoltage; // it's 3.2666 = 29.4/9.0 the power is read before the DC/DC converter so the current change according : 29.4V is the Power supply 9.0V is the DC/DC output voltage (Change according your setting)
			if ((activeLoop) && (PeriCurrent < PERI_CURRENT_MIN)) {
				oled.setTextXY(5, 0);
				oled.putLine("  Wire is Cut  ");
			}else{
				oled.setTextXY(5, 0);
				oled.putLine("Pericurr");
				oled.setTextXY(5, 9);
				oled.putFloat(PeriCurrent, 0);
			}
		}

		if((WiFi.status() != WL_CONNECTED)) ScanNetwork();
		if(workTimeMins >= WORKING_TIMEOUT_MINS){
			// switch off perimeter
			stopSender();
			Serial.println("********************************   Timeout , so stop Sender  **********************************");
		}
	}

	if (millis() >= nextTimeSec) {
		nextTimeSec = millis() + 1000;

		/* oled.setTextXY(7, 0); */
		/* oled.putLine("Heap "); */
		/* oled.setTextXY(7, 6); */
		/* oled.putNumber(ESP.getFreeHeap()); */

		// woocash
		/* if(activeLoop){ */
		/* 	oled.setTextXY(7, 0); */
		/* 	oled.putLine("Loop "); */
		/* 	oled.setTextXY(7, 5); */
		/* 	oled.putString(activeLoop->code); */
		/* } */


		if (USE_STATION) {
			busvoltage2 = ina3221.getBusVoltage_V(MOWER_STATION_CHANNEL);
			shuntvoltage2 = ina3221.getShuntVoltage_mV(MOWER_STATION_CHANNEL);
			ChargeCurrent = ina3221.getCurrent_mA(MOWER_STATION_CHANNEL);
			if (ChargeCurrent <= 5) ChargeCurrent = 0;
			loadvoltage2 = busvoltage2 + (shuntvoltage2 / 1000);
			oled.setTextXY(6, 0);
			oled.putLine("Charcurr");
			oled.setTextXY(6, 9);
			oled.putFloat(ChargeCurrent, 0);

			if (ChargeCurrent > 200) { //mower is into the station ,in my test 410 ma are drained so possible to stop sender
				stopSender();
			}else if(activeLoop==NULL){//start loop only if not yet active
				startLoop(activeLoop); //do not pass any specific loop - let startLoop function decide which to use
			}
		}
		timeSeconds++;
		if ((activeLoop) && (timeSeconds >= 60)) {
			if (workTimeMins < 1440) workTimeMins++;
			timeSeconds = 0;
		}

		if (activeLoop) {
			oled.setTextXY(2, 0);
			oled.putLine("Sender ON");
			oled.setTextXY(2, 10);
			oled.putString(activeLoop->code);
		}else{
			oled.setTextXY(2, 0);
			oled.putLine("Sender OFF");
		}
	}

	if (millis() >= nextTimeInfo) {
		nextTimeInfo = millis() + 500;
	}
	// Check if a client has connected
	WiFiClient client = server.available();
	if (client) {
		// Read the first line of the request
		String req = client.readStringUntil('\r');
		if (req == "") return;
		Serial.print("Client say  ");
		Serial.println(req);
		Serial.println("------------------------ - ");
		//client.flush();
		// Match the request
		if (req.indexOf("GET /STOP") != -1) {
			// WiffiRequestOn = false;
			workTimeMins = 0;
			stopSender();
			char response[] = "SENDER IS OFF"; 
			// Send the response to the client
			Serial.println(response);
			client.print(response);
			client.flush();
		} else if (req.indexOf("GET /START/") != -1) {
			//WiffiRequestOn = 1;
			workTimeMins = 0;
			//parse loop id
			bool res = startLoop(strtoul(&req[11],NULL,10));
			//prepare the response
			String sResponse;
			if(res && activeLoop){
				sResponse = "Loop ";
				sResponse += activeLoop->code;
				sResponse +=" is active now";
			}else{
				sResponse = "Error, unknown loop!!!";
			};
			// Send the response to the client
			Serial.println(sResponse);
			client.print(sResponse);
			client.flush();
		} else if (req.indexOf("GET /?") != -1) {
			String sResponse, sHeader;
			sResponse = "MAC ADRESS = ";
			sResponse += WiFi.macAddress() ;
			sResponse += " WORKING DURATION= ";
			sResponse += workTimeMins ;
			sResponse += " PERI CURRENT Milli Amps= ";
			sResponse += PeriCurrent  ;
			sResponse += " sigDuration= ";
			sResponse += sigDuration ;
			sResponse += " activeSender= ";
			sResponse += activeLoop ? activeLoop->code : "none";
			Serial.println(sResponse);
			client.print(sResponse);
			client.flush();
		} else if (req.indexOf("GET /sigDuration/104") != -1) {
			sigDuration = 104;
			timerAlarmWrite(timer, 104, true);
			// Prepare the response
			String sResponse;
			sResponse = "NOW 104 microsecond signal duration";
			// Send the response to the client
			Serial.println(sResponse);
			client.print(sResponse);
			client.flush();

		} else if (req.indexOf("GET /sigDuration/50") != -1) {
			sigDuration = 50;
			timerAlarmWrite(timer, 50, true);
			// Prepare the response
			String sResponse;
			sResponse = "NOW 50 microsecond signal duration";
			// Send the response to the client
			Serial.println(sResponse);
			client.print(sResponse);
			client.flush();
		}
	}

	if ((USE_BUTTON) && (millis() > nextTimeCheckButton)) {
		nextTimeCheckButton = millis() + 100;
		if (StartButtonProcess) {
			oled.setTextXY(7, 0);
			oled.putLine("Button Press");
		}

		Button_pressed = digitalRead(pinPushButton);
		if (Button_pressed == LOW) {
			Serial.println("Button pressed");
			workTimeMins = 0;
			startNextLoop();
			nextTimeCheckButton = millis() + 1000;
			StartButtonProcess = true;
			nextTimeControl = millis() + 3000;
		}
	}
}
