#ifndef GLOBALS_H
#define GLOBALS_H

#include <Arduino.h>

#if defined(__AVR__)
	#define BOARD Mega  // Mega board
	#define RaspberryPIPort Serial  //The PI is connected on NATIVE USB port over USB cable
#elif defined(__SAMD51__)
	#define BOARD GCM4  // Grand Central M4
	#define RaspberryPIPort Serial  //The PI is connected on NATIVE USB port over USB cable
	#define CONSOLE Serial      // Adafruit Grand Central M4
#elif defined(_SAM3XA_)
	#define BOARD Due   // Due
	#define RaspberryPIPort SerialUSB  //The PI is connected on NATIVE USB port over USB cable
	#define CONSOLE SerialUSB   // Arduino Due: do not change (used for Due native USB serial console)
#endif

//#define ENABLE_UDP 1                // enable console for UDP?
#define UDP_SERVER_IP   192,168,2,56     // remote UDP IP and port to connect to
#define UDP_SERVER_PORT 4210

#endif
