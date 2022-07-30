#include <Wire.h>
#include <WiFi.h>
/* #include "src/MemoryFree/MemoryFree.h" */
#include "config.h"
#include "OTA.h"
#include <Adafruit_GFX.h>
#include <Adafruit_SH110X.h>


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
Adafruit_SH1106G display = Adafruit_SH1106G(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

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

void oledClear(){
	display.clearDisplay();
	display.setCursor(0,0);
}

void oledInit(){
	display.begin(I2C_OLED_Address, true); // Address 0x3C default
	display.display();
	delay(1000);
	oledClear();
	display.setTextSize(1);
	display.setTextColor(SH110X_WHITE);
	delay(10);
}

void oledDisplay(){
	display.display();
}

void oledPrint(const char *string){
	display.print(string);
}

void oledPrint(const char *string, int y){
	display.setCursor(0,y*8);
    display.fillRect(0, y*8, display.width(), 8, SH110X_BLACK);
	oledPrint(string);
}

void oledPrint(const char *string, int y, int x){
	display.setCursor(x*8,y*8);
	oledPrint(string);
}

void oledPrintln(const char *string){
	display.println(string);
}

void oledPrintln(const char *string, int y){
	oledPrint(string, y);
	display.println();
}

void oledPrintln(const char *string, int x, int y){
	oledPrint(string, y, x);
	display.println();
}

void oledPrintln(const float val){
	char buff[10];
	sprintf(buff, "%.0f", val);
	display.println(buff);
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
	oledInit();
	oledPrintln("ARDUMOWER");
	oledPrintln("LK SENDER");
	oledPrintln(VER);
	oledPrintln("MULTI LOOPS");
	oledDisplay();

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
	oledClear();
	Serial.println();
	Serial.print("Connecting to ");
	Serial.println(ssid);
	//WiFi.setAutoReconnect(true);
	WiFi.begin(ssid, password);
	for (int i = 0; i < 60; i++)
	{
		if ( WiFi.status() != WL_CONNECTED )
		{
			oledPrintln("Try connecting");
			oledDisplay();
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
		oledClear();
		oledPrintln("WIFI Connected");
		oledPrintln(bufIP);
		oledDisplay();
		server.begin();
		setupOTA("ardu_sender");
	}
}


static void ScanNetwork(){
	WiFi.mode(WIFI_STA);
	WiFi.disconnect();
	oledClear();
	oledPrintln("Hotspot Lost");
	oledPrintln(activeLoop ? "Sender ON" : "Sender OFF");
	oledPrint("worktime="); oledPrintln(workTimeMins);

	if (USE_PERI_CURRENT) {
		busvoltage1 = ina3221.getBusVoltage_V(PERI_CURRENT_CHANNEL);
		PeriCurrent = ina3221.getCurrent_mA(PERI_CURRENT_CHANNEL);
		PeriCurrent = PeriCurrent - 100.0; //the DC/DC,ESP32,LN298N can drain up to 300 ma when scanning network
		if (PeriCurrent <= 5) PeriCurrent = 0; //
		PeriCurrent = PeriCurrent * busvoltage1 / DcDcOutVoltage; // it's 3.2666 = 29.4/9.0 the power is read before the DC/DC converter so the current change according : 29.4V is the Power supply 9.0V is the DC/DC output voltage (Change according your setting)
		oledPrint("Pericurr",5); oledPrintln(PeriCurrent);
	}


	if (USE_STATION) {
		ChargeCurrent = ina3221.getCurrent_mA(MOWER_STATION_CHANNEL);
		if(ChargeCurrent <= 5) ChargeCurrent = 0;
		oledPrint("Charcurr",6); oledPrintln(ChargeCurrent);
	}
	oledDisplay();
	delay(5000);  // wait until all is disconnect
	int n = WiFi.scanNetworks();
	switch(n){
		case -1:
			oledClear();
			oledPrintln("Scan running ???");
			oledPrintln("Need Reset ???");
			oledPrintln("If sender is OFF");
			oledDisplay();
			delay(5000);
			if (activeLoop==NULL) ESP.restart(); // do not reset if sender is ON
			break;
		case -2:
			//bug in esp32 if wifi is lost many time the esp32 fail to autoreconnect,maybe solve in other firmware ???????
			oledClear();
			oledPrintln("Scan Fail.");
			oledPrintln("Need Reset ???");
			oledPrintln("If sender is Off");
			oledDisplay();
			delay(5000);
			if (activeLoop==NULL) ESP.restart(); // do not reset if sender is ON
			break;
		case 0:
			oledClear();
			oledPrintln("No networks.");
			oledDisplay();
			break;
		default:
			if (n > 0){
				Serial.print("find ");
				Serial.println(n);
				oledClear();
				oledPrint("Find ");
				for (int i = 0; i < n; ++i) {
					// Print SSID for each network found
					char currentSSID[64];
					WiFi.SSID(i).toCharArray(currentSSID, 64);
					Serial.print("find Wifi: ");
					Serial.println(currentSSID);
					oledPrintln(currentSSID, 0, 5);
					oledDisplay();
					delay(1500);
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
	workTimeMins = 0;
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
	ArduinoOTA.handle();
	if (millis() >= nextTimeControl) {
		nextTimeControl = millis() + 2000;  //after debug can set this to 10 secondes
		StartButtonProcess = false;
		oledPrint("worktime ", 4); oledPrintln(workTimeMins);
		if (USE_PERI_CURRENT) {
			busvoltage1 = ina3221.getBusVoltage_V(PERI_CURRENT_CHANNEL);
			PeriCurrent = ina3221.getCurrent_mA(PERI_CURRENT_CHANNEL);
			PeriCurrent = PeriCurrent - 100.0; //the DC/DC,ESP32,LN298N drain 100 ma when nothing is ON and a wifi access point is found (To confirm ????)
			if (PeriCurrent <= 5) PeriCurrent = 0; //
			PeriCurrent = PeriCurrent * busvoltage1 / DcDcOutVoltage; // it's 3.2666 = 29.4/9.0 the power is read before the DC/DC converter so the current change according : 29.4V is the Power supply 9.0V is the DC/DC output voltage (Change according your setting)
			if ((activeLoop) && (PeriCurrent < PERI_CURRENT_MIN)) {
				oledPrintln("  !!! Wire is Cut !!!", 5);
			}else{
				oledPrint("Pericurr ", 5); oledPrintln(PeriCurrent);
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

		if (USE_STATION) {
			busvoltage2 = ina3221.getBusVoltage_V(MOWER_STATION_CHANNEL);
			shuntvoltage2 = ina3221.getShuntVoltage_mV(MOWER_STATION_CHANNEL);
			ChargeCurrent = ina3221.getCurrent_mA(MOWER_STATION_CHANNEL);
			if (ChargeCurrent <= 5) ChargeCurrent = 0;
			loadvoltage2 = busvoltage2 + (shuntvoltage2 / 1000);
			oledPrint("Charcurr ", 6); oledPrintln(ChargeCurrent);
			if (ChargeCurrent > CHARG_CURRENT_MIN){
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
			oledPrint("Sender ON    ", 2); oledPrintln(activeLoop->code);
		}else{
			oledPrintln("Sender OFF", 2);
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
			sResponse += "\nWORKING DURATION= ";
			sResponse += workTimeMins ;
			sResponse += "\nCHARGE CURRENT Milli Amps= ";
			sResponse += ChargeCurrent  ;
			sResponse += "\nPERI CURRENT Milli Amps= ";
			sResponse += PeriCurrent  ;
			sResponse += "\nsigDuration= ";
			sResponse += sigDuration ;
			sResponse += "\nactiveSender= ";
			sResponse += activeLoop ? activeLoop->code : "none";
			Serial.println(sResponse);
			sResponse += "\n\ncommands:\n/START/{#}\n/STOP";
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
			oledPrintln("Button pressed",7);
		}else{
			oledPrintln("", 7);
		}

		Button_pressed = digitalRead(pinPushButton);
		if (Button_pressed == LOW) {
			Serial.println("Button pressed");
			//WiFiClient client = server.available();
			workTimeMins = 0;
			//woocash commented
			/* if (client) { */
			/* 	String sResponse, sHeader; */
			/* 	sResponse = "BUTTON PRESSED"; */
			/* 	client.print(sResponse); */
			/* 	client.flush(); */
			/* } */
			startNextLoop();
			nextTimeCheckButton = millis() + 1000;
			StartButtonProcess = true;
			nextTimeControl = millis() + 3000;
		}
	}
	oledDisplay();
}
