/*
  WIFI Communicating sender with multi loops
  Loops are defined in areas array (for each loop three parameters have to be defined:
	pinIN1, pinIn2 and pinEnable.
  Number of loops is only limited by hardware (number of drivers and GPIOs)

  Adjust IP according to your ESP32 value 10.0.0.150 in this example
  On your browser send :
  http://10.0.0.150/A0   *********** to stop the sender on wire connected on output A
  http://10.0.0.150/A1   *********** to start the sender on wire connected on output A
  http://10.0.0.150/B0   *********** to stop the sender on wire connected on output B
  http://10.0.0.150/B1   *********** to start the sender on wire connected on output B

  http://10.0.0.150/sigCode/2 ******* to change the sigcode in use possible value are 0,1,2,3,4 ,see sigcode list
  http://10.0.0.150/?   *********** to see the state of the sender
  http://10.0.0.150/sigDuration/104    *********** to change the speed sender to 104 microsecondes
  http://10.0.0.150/sigDuration/50    *********** to change the speed sender to 50 microsecondes

  If USE_STATION : the sender start and stop automaticly if the mower is in the station or not


*/
#include "src/INA3221/SDL_Arduino_INA3221.h"
#include "src/SSD1306/ACROBOTIC_SSD1306.h"


//********************* user setting **********************************
const char* ssid     = "casa";   // put here your acces point ssid
const char* password = "SIedlisko!$";  // put here the password
//********************* setting for current sensor **********************************
float DcDcOutVoltage = 12.0;  //Use to have a correct value on perricurrent (Need to change the value each time you adjust the DC DC )

IPAddress staticIP(10, 0, 0, 75); // put here the static IP
IPAddress gateway(10, 0, 0, 1); // put here the gateway (IP of your routeur)
IPAddress subnet(255, 255, 255, 0);
IPAddress dns(10, 0, 0, 1); // put here one dns (IP of your routeur)

#define USE_STATION     1 // a station is connected and is used to charge the mower
#define USE_PERI_CURRENT      1     // use Feedback for perimeter current measurements? (set to '0' if not connected!)
#define USE_BUTTON      1     // use button to start mowing or send mower to station not finish to dev
#define USE_RAINFLOW    0     // check the amount of rain not finish to dev on 31/08/2020
#define WORKING_TIMEOUT_MINS 300  // timeout for perimeter switch-off if robot not in station (minutes)
#define PERI_CURRENT_MIN    100    // minimum milliAmpere for cutting wire detection

#define I2C_SDA 21
#define I2C_SCL 22 
#define PERI_CURRENT_CHANNEL 1
#define MOWER_STATION_CHANNEL 2

#define pinPushButton      33  //           (connect to Button) //R1 2.2K R2 3.3K
#define pinRainFlow       35  //           (connect to Rain box) //R3 2.2K R4 3.3K

// ---- choose only one perimeter signal code ----
//#define SIGCODE_0	//simple square test code
#define SIGCODE_1	//Ardumower default perimeter signal
//#define SIGCODE_2	//Ardumower alternative perimeter signal
//#define SIGCODE_3	//128 Zahlen from Roland
//#define SIGCODE_4	//extended square test code

int sigDuration = 104;  // send the bits each 104 microsecond (Also possible 50)

struct LOOP{
	char code[6];
	uint8_t pIN1;
	uint8_t pIN2;
	uint8_t pEnable;
}; 

LOOP loops[] = {
	{"MAIN", 2,0,15} //area 0 - {pinIN1, pinIN2, pinEnable}
	,{"FRONT", 4,16,17} //area 1 - {pinIN1, pinIN2, pinEnable}
};



