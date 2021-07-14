EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Ardumower DUE Basic Board"
Date "2021-04-06"
Rev "v1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 5135 2580 2    50   Input ~ 0
SDA1
Text GLabel 5135 2680 2    50   Input ~ 0
SCL1
Text GLabel 2935 1980 0    50   Output ~ 0
pinMotorRightEnable
Text GLabel 2935 2180 0    50   Output ~ 0
pinMotorRightPWM
Text GLabel 2935 2080 0    50   Output ~ 0
pinMotorRightDir
Text GLabel 2935 2480 0    50   Output ~ 0
pinMotorLeftPWM
Text GLabel 2935 2380 0    50   Output ~ 0
pinMotorLeftDir
Text GLabel 2935 2980 0    50   Input ~ 0
pinOdometryLeft
Text GLabel 2935 2880 0    50   Input ~ 0
pinOdometryRight
Text GLabel 5135 3780 2    50   Input ~ 0
pinBumperLeft
Text GLabel 5135 3680 2    50   Input ~ 0
pinBumperRight
Text GLabel 5135 2080 2    50   Input ~ 0
pinPerimeterRight
Text GLabel 5135 1980 2    50   Input ~ 0
pinPerimeterLeft
Text GLabel 5135 3580 2    50   Output ~ 0
pinBuzzer
Text GLabel 5135 3480 2    50   Input ~ 0
pinButton
Text GLabel 5135 3980 2    50   Output ~ 0
pinBatterySwitch
Text GLabel 5135 3880 2    50   Output ~ 0
pinChargeEnable
Text GLabel 5135 3380 2    50   Input ~ 0
pinRain
Text GLabel 2935 1780 0    50   Input ~ 0
RX1
Text GLabel 2935 1880 0    50   Output ~ 0
TX1
Text GLabel 5135 2880 2    50   Input ~ 0
TX3
Text GLabel 5135 2780 2    50   Output ~ 0
RX3
Text GLabel 5135 2480 2    50   Input ~ 0
SDA0
Text GLabel 5135 2380 2    50   Input ~ 0
SCL0
$Comp
L Connector:Screw_Terminal_01x04 J10
U 1 1 60757000
P 1560 3105
F 0 "J10" H 1640 3097 50  0000 L CNN
F 1 "Sonar_R" H 1640 3006 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 1560 3105 50  0001 C CNN
F 3 "~" H 1560 3105 50  0001 C CNN
	1    1560 3105
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 J12
U 1 1 60758E5B
P 1540 3750
F 0 "J12" H 1620 3742 50  0000 L CNN
F 1 "Sonar_L" H 1620 3651 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 1540 3750 50  0001 C CNN
F 3 "~" H 1540 3750 50  0001 C CNN
	1    1540 3750
	1    0    0    -1  
$EndComp
Text GLabel 1360 3305 0    50   Input ~ 0
pinSonarRightEcho
Text GLabel 1340 3950 0    50   Input ~ 0
pinSonarLeftEcho
$Comp
L Connector:Screw_Terminal_01x04 J5
U 1 1 60770CE6
P 1525 4280
F 0 "J5" H 1605 4272 50  0000 L CNN
F 1 "Bumper" H 1605 4181 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 1525 4280 50  0001 C CNN
F 3 "~" H 1525 4280 50  0001 C CNN
	1    1525 4280
	1    0    0    -1  
$EndComp
Text GLabel 1325 4280 0    50   Input ~ 0
pinBumperRight
Text GLabel 1325 4480 0    50   Input ~ 0
pinBumperLeft
$Comp
L Connector:Screw_Terminal_01x03 J9
U 1 1 607A8DE0
P 1225 5010
F 0 "J9" H 1305 5052 50  0000 L CNN
F 1 "Rain" H 1305 4961 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B3B-XH-A_1x03_P2.50mm_Vertical" H 1225 5010 50  0001 C CNN
F 3 "~" H 1225 5010 50  0001 C CNN
	1    1225 5010
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR011
U 1 1 607A92DC
P 725 4910
F 0 "#PWR011" H 725 4760 50  0001 C CNN
F 1 "+3.3V" H 740 5083 50  0000 C CNN
F 2 "" H 725 4910 50  0001 C CNN
F 3 "" H 725 4910 50  0001 C CNN
	1    725  4910
	1    0    0    -1  
$EndComp
Wire Wire Line
	725  4910 1025 4910
Text GLabel 1025 5110 0    50   Input ~ 0
pinRain
$Comp
L Connector:Screw_Terminal_01x02 J15
U 1 1 607D1A82
P 2185 4970
F 0 "J15" H 2265 4962 50  0000 L CNN
F 1 "Button" H 2265 4871 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 2185 4970 50  0001 C CNN
F 3 "~" H 2185 4970 50  0001 C CNN
	1    2185 4970
	1    0    0    -1  
$EndComp
Text GLabel 1985 5070 0    50   Input ~ 0
pinButton
$Comp
L power:GND #PWR030
U 1 1 60978B23
P 1985 4970
F 0 "#PWR030" H 1985 4720 50  0001 C CNN
F 1 "GND" V 1990 4842 50  0000 R CNN
F 2 "" H 1985 4970 50  0001 C CNN
F 3 "" H 1985 4970 50  0001 C CNN
	1    1985 4970
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR017
U 1 1 6097D1A4
P 1025 5010
F 0 "#PWR017" H 1025 4760 50  0001 C CNN
F 1 "GND" V 1030 4882 50  0000 R CNN
F 2 "" H 1025 5010 50  0001 C CNN
F 3 "" H 1025 5010 50  0001 C CNN
	1    1025 5010
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR012
U 1 1 6097EBFF
P 1075 4180
F 0 "#PWR012" H 1075 3930 50  0001 C CNN
F 1 "GND" V 1080 4052 50  0000 R CNN
F 2 "" H 1075 4180 50  0001 C CNN
F 3 "" H 1075 4180 50  0001 C CNN
	1    1075 4180
	0    1    1    0   
$EndComp
Wire Wire Line
	1075 4180 1325 4180
$Comp
L power:GND #PWR013
U 1 1 609BE8A2
P 1325 4380
F 0 "#PWR013" H 1325 4130 50  0001 C CNN
F 1 "GND" V 1330 4252 50  0000 R CNN
F 2 "" H 1325 4380 50  0001 C CNN
F 3 "" H 1325 4380 50  0001 C CNN
	1    1325 4380
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR019
U 1 1 60A92EB8
P 1340 3750
F 0 "#PWR019" H 1340 3500 50  0001 C CNN
F 1 "GND" V 1345 3622 50  0000 R CNN
F 2 "" H 1340 3750 50  0001 C CNN
F 3 "" H 1340 3750 50  0001 C CNN
	1    1340 3750
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR020
U 1 1 60A9B8D5
P 1360 3105
F 0 "#PWR020" H 1360 2855 50  0001 C CNN
F 1 "GND" V 1365 2977 50  0000 R CNN
F 2 "" H 1360 3105 50  0001 C CNN
F 3 "" H 1360 3105 50  0001 C CNN
	1    1360 3105
	0    1    1    0   
$EndComp
Text GLabel 2935 2780 0    50   Output ~ 0
pinMotorMowPWM
Text GLabel 2935 2680 0    50   Output ~ 0
pinMotorMowDir
Text GLabel 2935 2580 0    50   Output ~ 0
pinMotorMowEnable
Text GLabel 1360 3205 0    50   Output ~ 0
pinSonarRightTrigger
Text GLabel 1340 3850 0    50   Output ~ 0
pinSonarLeftTrigger
$Comp
L Connector:Screw_Terminal_01x02 J25
U 1 1 60C7263B
P 650 700
F 0 "J25" V 614 512 50  0000 R CNN
F 1 "5V IN" V 750 750 50  0000 R CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 650 700 50  0001 C CNN
F 3 "~" H 650 700 50  0001 C CNN
	1    650  700 
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N5819 D7
U 1 1 60C72F7B
P 1100 900
F 0 "D7" H 1100 683 50  0000 C CNN
F 1 "1N5819" H 1100 774 50  0000 C CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 1100 725 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88525/1n5817.pdf" H 1100 900 50  0001 C CNN
	1    1100 900 
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR023
U 1 1 60C72F86
P 650 900
F 0 "#PWR023" H 650 650 50  0001 C CNN
F 1 "GND" H 655 727 50  0000 C CNN
F 2 "" H 650 900 50  0001 C CNN
F 3 "" H 650 900 50  0001 C CNN
	1    650  900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	750  900  950  900 
Wire Wire Line
	1250 900  1400 900 
$Comp
L Connector:Screw_Terminal_01x02 J29
U 1 1 60C78D92
P 4150 650
F 0 "J29" V 4114 462 50  0000 R CNN
F 1 "3.3V IN" V 4250 700 50  0000 R CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 4150 650 50  0001 C CNN
F 3 "~" H 4150 650 50  0001 C CNN
	1    4150 650 
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N5819 D8
U 1 1 60C7971C
P 4630 860
F 0 "D8" H 4630 643 50  0000 C CNN
F 1 "1N5819" H 4630 734 50  0000 C CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 4630 685 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88525/1n5817.pdf" H 4630 860 50  0001 C CNN
	1    4630 860 
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR049
U 1 1 60C79727
P 4150 850
F 0 "#PWR049" H 4150 600 50  0001 C CNN
F 1 "GND" H 4155 677 50  0000 C CNN
F 2 "" H 4150 850 50  0001 C CNN
F 3 "" H 4150 850 50  0001 C CNN
	1    4150 850 
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR039
U 1 1 60C8C573
P 1400 900
F 0 "#PWR039" H 1400 750 50  0001 C CNN
F 1 "+5V" H 1415 1073 50  0000 C CNN
F 2 "" H 1400 900 50  0001 C CNN
F 3 "" H 1400 900 50  0001 C CNN
	1    1400 900 
	0    1    1    0   
$EndComp
$Comp
L Device:R R11
U 1 1 607EF5D8
P 3100 850
F 0 "R11" V 3000 850 50  0000 C CNN
F 1 "100" V 3100 850 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 3030 850 50  0001 C CNN
F 3 "~" H 3100 850 50  0001 C CNN
	1    3100 850 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2950 850  2800 850 
$Comp
L power:GND #PWR042
U 1 1 608BA949
P 2400 850
F 0 "#PWR042" H 2400 600 50  0001 C CNN
F 1 "GND" V 2405 722 50  0000 R CNN
F 2 "" H 2400 850 50  0001 C CNN
F 3 "" H 2400 850 50  0001 C CNN
	1    2400 850 
	0    1    1    0   
$EndComp
$Comp
L Ardumower-rescue:LED-Zimprich D2
U 1 1 608BB0E1
P 2600 850
F 0 "D2" H 2600 605 50  0000 C CNN
F 1 "LED_3V" H 2600 696 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm" H 2600 850 60  0001 C CNN
F 3 "" H 2600 850 60  0000 C CNN
	1    2600 850 
	1    0    0    -1  
$EndComp
$Comp
L Ardumower-rescue:SPEAKER-Lötpad_2,5mm SP1
U 1 1 607B6900
P 9650 900
F 0 "SP1" H 9928 961 70  0000 L CNN
F 1 "SPEAKER" H 9928 840 70  0000 L CNN
F 2 "Zimprich:Buzzer_12x9.5RM7.6" H 9650 900 60  0001 C CNN
F 3 "" H 9650 900 60  0000 C CNN
	1    9650 900 
	1    0    0    -1  
$EndComp
Text GLabel 9350 1000 0    50   Input ~ 0
pinBuzzer
$Comp
L power:GND #PWR035
U 1 1 60932E8B
P 9350 800
F 0 "#PWR035" H 9350 550 50  0001 C CNN
F 1 "GND" V 9355 672 50  0000 R CNN
F 2 "" H 9350 800 50  0001 C CNN
F 3 "" H 9350 800 50  0001 C CNN
	1    9350 800 
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR024
U 1 1 60CD5141
P 1360 3005
F 0 "#PWR024" H 1360 2855 50  0001 C CNN
F 1 "+3.3V" H 1375 3178 50  0000 C CNN
F 2 "" H 1360 3005 50  0001 C CNN
F 3 "" H 1360 3005 50  0001 C CNN
	1    1360 3005
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR038
U 1 1 60CDB03B
P 1340 3650
F 0 "#PWR038" H 1340 3500 50  0001 C CNN
F 1 "+3.3V" H 1355 3823 50  0000 C CNN
F 2 "" H 1340 3650 50  0001 C CNN
F 3 "" H 1340 3650 50  0001 C CNN
	1    1340 3650
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x03 J14
U 1 1 60D52135
P 10750 1250
F 0 "J14" H 10830 1292 50  0000 L CNN
F 1 "Buzzer" H 10830 1201 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B3B-XH-A_1x03_P2.50mm_Vertical" H 10750 1250 50  0001 C CNN
F 3 "~" H 10750 1250 50  0001 C CNN
	1    10750 1250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR029
U 1 1 60D52AC3
P 10550 1250
F 0 "#PWR029" H 10550 1000 50  0001 C CNN
F 1 "GND" V 10555 1122 50  0000 R CNN
F 2 "" H 10550 1250 50  0001 C CNN
F 3 "" H 10550 1250 50  0001 C CNN
	1    10550 1250
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR028
U 1 1 60D5C4CF
P 10550 1150
F 0 "#PWR028" H 10550 1000 50  0001 C CNN
F 1 "+5V" V 10565 1278 50  0000 L CNN
F 2 "" H 10550 1150 50  0001 C CNN
F 3 "" H 10550 1150 50  0001 C CNN
	1    10550 1150
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 60D6E833
P 11950 1550
F 0 "H2" H 12050 1599 50  0000 L CNN
F 1 "MountingHole_Pad" H 12050 1508 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad_TopBottom" H 11950 1550 50  0001 C CNN
F 3 "~" H 11950 1550 50  0001 C CNN
	1    11950 1550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR048
U 1 1 60D6F1F9
P 11950 1650
F 0 "#PWR048" H 11950 1400 50  0001 C CNN
F 1 "GND" V 11955 1522 50  0000 R CNN
F 2 "" H 11950 1650 50  0001 C CNN
F 3 "" H 11950 1650 50  0001 C CNN
	1    11950 1650
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H3
U 1 1 60D7064F
P 11950 2250
F 0 "H3" H 12050 2299 50  0000 L CNN
F 1 "MountingHole_Pad" H 12050 2208 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad_TopBottom" H 11950 2250 50  0001 C CNN
F 3 "~" H 11950 2250 50  0001 C CNN
	1    11950 2250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR069
U 1 1 60D7102F
P 11950 2350
F 0 "#PWR069" H 11950 2100 50  0001 C CNN
F 1 "GND" V 11955 2222 50  0000 R CNN
F 2 "" H 11950 2350 50  0001 C CNN
F 3 "" H 11950 2350 50  0001 C CNN
	1    11950 2350
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H4
U 1 1 60D71039
P 11950 2950
F 0 "H4" H 12050 2999 50  0000 L CNN
F 1 "MountingHole_Pad" H 12050 2908 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad_TopBottom" H 11950 2950 50  0001 C CNN
F 3 "~" H 11950 2950 50  0001 C CNN
	1    11950 2950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR070
U 1 1 60D71043
P 11950 3050
F 0 "#PWR070" H 11950 2800 50  0001 C CNN
F 1 "GND" V 11955 2922 50  0000 R CNN
F 2 "" H 11950 3050 50  0001 C CNN
F 3 "" H 11950 3050 50  0001 C CNN
	1    11950 3050
	1    0    0    -1  
$EndComp
Text GLabel 2935 2280 0    50   Output ~ 0
pinMotorLeftEnable
$Comp
L Connector:Screw_Terminal_01x04 J2
U 1 1 606BAE4D
P 1205 7455
F 0 "J2" H 1285 7447 50  0000 L CNN
F 1 "I2C2_0" H 1285 7356 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 1205 7455 50  0001 C CNN
F 3 "~" H 1205 7455 50  0001 C CNN
	1    1205 7455
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 J4
U 1 1 606BFED6
P 1200 6950
F 0 "J4" H 1280 6942 50  0000 L CNN
F 1 "I2C1_1" H 1280 6851 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 1200 6950 50  0001 C CNN
F 3 "~" H 1200 6950 50  0001 C CNN
	1    1200 6950
	1    0    0    -1  
$EndComp
Text GLabel 1005 7555 0    50   BiDi ~ 0
SDA2
Text GLabel 1000 7050 0    50   Input ~ 0
SDA1
Text GLabel 1005 7655 0    50   BiDi ~ 0
SCL2
Text GLabel 1000 7150 0    50   Input ~ 0
SCL1
$Comp
L power:GND #PWR07
U 1 1 6097FEEB
P 1000 6950
F 0 "#PWR07" H 1000 6700 50  0001 C CNN
F 1 "GND" V 1005 6822 50  0000 R CNN
F 2 "" H 1000 6950 50  0001 C CNN
F 3 "" H 1000 6950 50  0001 C CNN
	1    1000 6950
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR02
U 1 1 609C2617
P 1005 7355
F 0 "#PWR02" H 1005 7205 50  0001 C CNN
F 1 "+3.3V" V 1020 7483 50  0000 L CNN
F 2 "" H 1005 7355 50  0001 C CNN
F 3 "" H 1005 7355 50  0001 C CNN
	1    1005 7355
	0    -1   -1   0   
$EndComp
$Comp
L power:+3.3V #PWR06
U 1 1 609C9CA5
P 1000 6850
F 0 "#PWR06" H 1000 6700 50  0001 C CNN
F 1 "+3.3V" V 1015 6978 50  0000 L CNN
F 2 "" H 1000 6850 50  0001 C CNN
F 3 "" H 1000 6850 50  0001 C CNN
	1    1000 6850
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR03
U 1 1 609CCF77
P 1005 7455
F 0 "#PWR03" H 1005 7205 50  0001 C CNN
F 1 "GND" V 1010 7327 50  0000 R CNN
F 2 "" H 1005 7455 50  0001 C CNN
F 3 "" H 1005 7455 50  0001 C CNN
	1    1005 7455
	0    1    1    0   
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 J30
U 1 1 60D185B1
P 2250 6295
F 0 "J30" H 2330 6287 50  0000 L CNN
F 1 "I2C1_0" H 2330 6196 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 2250 6295 50  0001 C CNN
F 3 "~" H 2250 6295 50  0001 C CNN
	1    2250 6295
	1    0    0    -1  
$EndComp
Text GLabel 1500 6395 0    50   Input ~ 0
SDA1
Text GLabel 900  6495 0    50   Input ~ 0
SCL1
$Comp
L power:GND #PWR068
U 1 1 60D18FDB
P 2050 6295
F 0 "#PWR068" H 2050 6045 50  0001 C CNN
F 1 "GND" V 2055 6167 50  0000 R CNN
F 2 "" H 2050 6295 50  0001 C CNN
F 3 "" H 2050 6295 50  0001 C CNN
	1    2050 6295
	0    1    1    0   
$EndComp
$Comp
L Device:R R4
U 1 1 60D18FEF
P 1650 6245
F 0 "R4" V 1550 6245 50  0000 C CNN
F 1 "XXX" V 1650 6245 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 1580 6245 50  0001 C CNN
F 3 "~" H 1650 6245 50  0001 C CNN
	1    1650 6245
	-1   0    0    1   
$EndComp
$Comp
L Device:R R2
U 1 1 60D18FF9
P 1100 6345
F 0 "R2" V 1000 6345 50  0000 C CNN
F 1 "XXX" V 1100 6345 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 1030 6345 50  0001 C CNN
F 3 "~" H 1100 6345 50  0001 C CNN
	1    1100 6345
	-1   0    0    1   
$EndComp
Wire Wire Line
	1500 6395 1650 6395
Wire Wire Line
	1650 6395 2050 6395
Connection ~ 1650 6395
Wire Wire Line
	2050 6195 2050 6095
Wire Wire Line
	2050 6095 1650 6095
Connection ~ 1650 6095
Wire Wire Line
	1650 6095 1104 6095
Wire Wire Line
	900  6495 1100 6495
Wire Wire Line
	1100 6495 2050 6495
Connection ~ 1100 6495
Wire Wire Line
	1100 6195 1100 6095
Text GLabel 2020 7430 0    50   Input ~ 0
RX3
Text GLabel 2020 7330 0    50   Output ~ 0
TX3
$Comp
L Connector:Screw_Terminal_01x05 J31
U 1 1 60DA6EC4
P 2220 7230
F 0 "J31" H 2300 7272 50  0000 L CNN
F 1 "Ser3" H 2300 7181 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B5B-XH-A_1x05_P2.50mm_Vertical" H 2220 7230 50  0001 C CNN
F 3 "~" H 2220 7230 50  0001 C CNN
	1    2220 7230
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR079
U 1 1 60DA6ECE
P 2020 7130
F 0 "#PWR079" H 2020 6980 50  0001 C CNN
F 1 "+3.3V" V 2035 7258 50  0000 L CNN
F 2 "" H 2020 7130 50  0001 C CNN
F 3 "" H 2020 7130 50  0001 C CNN
	1    2020 7130
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR080
U 1 1 60DA6ED8
P 2020 7230
F 0 "#PWR080" H 2020 6980 50  0001 C CNN
F 1 "GND" V 2025 7102 50  0000 R CNN
F 2 "" H 2020 7230 50  0001 C CNN
F 3 "" H 2020 7230 50  0001 C CNN
	1    2020 7230
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR078
U 1 1 60DA6EE2
P 2020 7030
F 0 "#PWR078" H 2020 6880 50  0001 C CNN
F 1 "+5V" V 2035 7158 50  0000 L CNN
F 2 "" H 2020 7030 50  0001 C CNN
F 3 "" H 2020 7030 50  0001 C CNN
	1    2020 7030
	0    -1   -1   0   
$EndComp
$Comp
L teensy:Teensy4.1 U3
U 1 1 60E23AD3
P 4035 3830
F 0 "U3" H 4035 6395 50  0000 C CNN
F 1 "Teensy4.1" H 4035 6304 50  0000 C CNN
F 2 "teensy_library-master:Teensy41" H 3635 4230 50  0001 C CNN
F 3 "" H 3635 4230 50  0001 C CNN
	1    4035 3830
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0101
U 1 1 60E6CE57
P 5135 1680
F 0 "#PWR0101" H 5135 1530 50  0001 C CNN
F 1 "+5V" H 5150 1853 50  0000 C CNN
F 2 "" H 5135 1680 50  0001 C CNN
F 3 "" H 5135 1680 50  0001 C CNN
	1    5135 1680
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 60E6F0CD
P 5135 1780
F 0 "#PWR0102" H 5135 1530 50  0001 C CNN
F 1 "GND" H 5140 1607 50  0000 C CNN
F 2 "" H 5135 1780 50  0001 C CNN
F 3 "" H 5135 1780 50  0001 C CNN
	1    5135 1780
	0    -1   -1   0   
$EndComp
Text GLabel 2935 3280 0    50   BiDi ~ 0
SDA2
Text GLabel 2935 3180 0    50   BiDi ~ 0
SCL2
Text GLabel 10550 1350 0    50   Output ~ 0
pinBuzzer
NoConn ~ 5135 3080
NoConn ~ 2935 3080
NoConn ~ 11180 5820
Wire Wire Line
	1215 1695 965  1695
Wire Wire Line
	715  1695 965  1695
$Comp
L Device:R R10
U 1 1 6075BEEE
P 965 1845
F 0 "R10" V 865 1845 50  0000 C CNN
F 1 "1.5KO" V 965 1845 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 895 1845 50  0001 C CNN
F 3 "~" H 965 1845 50  0001 C CNN
	1    965  1845
	-1   0    0    1   
$EndComp
Connection ~ 965  1995
Wire Wire Line
	1365 1995 965  1995
Wire Wire Line
	915  1995 965  1995
Connection ~ 965  1695
$Comp
L Device:R R9
U 1 1 6075BEF9
P 765 1995
F 0 "R9" V 665 1995 50  0000 C CNN
F 1 "1KO" V 765 1995 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 695 1995 50  0001 C CNN
F 3 "~" H 765 1995 50  0001 C CNN
	1    765  1995
	0    1    1    0   
$EndComp
Text GLabel 615  1995 0    50   Output ~ 0
pinPerimeterLeft
Wire Wire Line
	1215 1695 1215 1895
Wire Wire Line
	1215 1895 1365 1895
$Comp
L power:GND #PWR022
U 1 1 6075B52F
P 715 1695
F 0 "#PWR022" H 715 1445 50  0001 C CNN
F 1 "GND" V 720 1567 50  0000 R CNN
F 2 "" H 715 1695 50  0001 C CNN
F 3 "" H 715 1695 50  0001 C CNN
	1    715  1695
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR034
U 1 1 607617F6
P 1365 1795
F 0 "#PWR034" H 1365 1645 50  0001 C CNN
F 1 "+5V" H 1380 1968 50  0000 C CNN
F 2 "" H 1365 1795 50  0001 C CNN
F 3 "" H 1365 1795 50  0001 C CNN
	1    1365 1795
	1    0    0    -1  
$EndComp
Connection ~ 1365 2495
$Comp
L Device:R R7
U 1 1 6076D999
P 765 2595
F 0 "R7" V 665 2595 50  0000 C CNN
F 1 "1KO" V 765 2595 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 695 2595 50  0001 C CNN
F 3 "~" H 765 2595 50  0001 C CNN
	1    765  2595
	0    1    1    0   
$EndComp
Wire Wire Line
	915  2595 965  2595
$Comp
L Device:R R8
U 1 1 6076D98E
P 965 2445
F 0 "R8" V 865 2445 50  0000 C CNN
F 1 "1.5KO" V 965 2445 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 895 2445 50  0001 C CNN
F 3 "~" H 965 2445 50  0001 C CNN
	1    965  2445
	-1   0    0    1   
$EndComp
Connection ~ 965  2595
Wire Wire Line
	1365 2595 965  2595
Connection ~ 965  2295
Wire Wire Line
	715  2295 965  2295
Wire Wire Line
	1215 2295 965  2295
Wire Wire Line
	1215 2495 1365 2495
Wire Wire Line
	1215 2295 1215 2495
$Comp
L power:GND #PWR021
U 1 1 6076CF93
P 715 2295
F 0 "#PWR021" H 715 2045 50  0001 C CNN
F 1 "GND" V 720 2167 50  0000 R CNN
F 2 "" H 715 2295 50  0001 C CNN
F 3 "" H 715 2295 50  0001 C CNN
	1    715  2295
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR027
U 1 1 6097F899
P 1365 2495
F 0 "#PWR027" H 1365 2245 50  0001 C CNN
F 1 "GND" V 1370 2367 50  0000 R CNN
F 2 "" H 1365 2495 50  0001 C CNN
F 3 "" H 1365 2495 50  0001 C CNN
	1    1365 2495
	0    1    1    0   
$EndComp
Text GLabel 615  2595 0    50   Output ~ 0
pinPerimeterRight
$Comp
L power:+5V #PWR026
U 1 1 6077B973
P 1365 2395
F 0 "#PWR026" H 1365 2245 50  0001 C CNN
F 1 "+5V" H 1380 2568 50  0000 C CNN
F 2 "" H 1365 2395 50  0001 C CNN
F 3 "" H 1365 2395 50  0001 C CNN
	1    1365 2395
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x03 J13
U 1 1 6077742A
P 1565 2495
F 0 "J13" H 1645 2537 50  0000 L CNN
F 1 "P_Right" H 1645 2446 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B3B-XH-A_1x03_P2.50mm_Vertical" H 1565 2495 50  0001 C CNN
F 3 "~" H 1565 2495 50  0001 C CNN
	1    1565 2495
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J19
U 1 1 60776476
P 1565 1895
F 0 "J19" H 1645 1937 50  0000 L CNN
F 1 "P_Left" H 1645 1846 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B3B-XH-A_1x03_P2.50mm_Vertical" H 1565 1895 50  0001 C CNN
F 3 "~" H 1565 1895 50  0001 C CNN
	1    1565 1895
	1    0    0    -1  
$EndComp
Wire Wire Line
	4480 860  4250 860 
Wire Wire Line
	4250 860  4250 850 
$Comp
L power:+3.3V #PWR050
U 1 1 60C9BB63
P 5290 960
F 0 "#PWR050" H 5290 810 50  0001 C CNN
F 1 "+3.3V" H 5305 1133 50  0000 C CNN
F 2 "" H 5290 960 50  0001 C CNN
F 3 "" H 5290 960 50  0001 C CNN
	1    5290 960 
	-1   0    0    1   
$EndComp
NoConn ~ 2935 1680
NoConn ~ 5135 4230
NoConn ~ 5135 4330
NoConn ~ 5135 4430
NoConn ~ 5135 4530
NoConn ~ 5135 4630
NoConn ~ 5135 4730
NoConn ~ 4185 5130
NoConn ~ 2935 4180
NoConn ~ 2935 4280
NoConn ~ 2935 4430
NoConn ~ 2935 4530
NoConn ~ 2935 4630
NoConn ~ 2935 4730
NoConn ~ 2935 4830
Wire Wire Line
	5135 1880 5830 1880
$Comp
L Device:Jumper_NC_Dual JP1
U 1 1 60E4CAF5
P 5290 860
F 0 "JP1" H 5290 1099 50  0000 C CNN
F 1 "Jumper_3.3V" H 5290 1008 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x03_P2.54mm_Vertical" H 5290 860 50  0001 C CNN
F 3 "~" H 5290 860 50  0001 C CNN
	1    5290 860 
	1    0    0    -1  
$EndComp
Wire Wire Line
	4780 860  5040 860 
Wire Wire Line
	5540 860  5830 860 
Wire Wire Line
	5830 860  5830 1880
$Comp
L doit-esp32-devkit-v1:DOIT-ESP32-DEVKIT-V1 U1
U 1 1 60ECFCEF
P 7300 1100
F 0 "U1" H 7275 1665 50  0000 C CNN
F 1 "DOIT-ESP32-DEVKIT-V1" H 7275 1574 50  0000 C CNN
F 2 "teensy_library-master:ESP32-DOIT-DEVKIT" H 7250 1550 50  0001 C CNN
F 3 "" H 7250 1550 50  0001 C CNN
	1    7300 1100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR09
U 1 1 60EDAE05
P 6350 2500
F 0 "#PWR09" H 6350 2350 50  0001 C CNN
F 1 "+5V" V 6365 2628 50  0000 L CNN
F 2 "" H 6350 2500 50  0001 C CNN
F 3 "" H 6350 2500 50  0001 C CNN
	1    6350 2500
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR01
U 1 1 60EDBE6C
P 6350 2400
F 0 "#PWR01" H 6350 2150 50  0001 C CNN
F 1 "GND" V 6355 2272 50  0000 R CNN
F 2 "" H 6350 2400 50  0001 C CNN
F 3 "" H 6350 2400 50  0001 C CNN
	1    6350 2400
	0    1    1    0   
$EndComp
Text GLabel 8200 1600 2    50   Input ~ 0
RX1
Text GLabel 8200 1700 2    50   Output ~ 0
TX1
Wire Wire Line
	4000 7050 4000 7250
Wire Wire Line
	4000 6300 4000 6500
Connection ~ 3850 6600
Wire Wire Line
	3850 6600 3550 6600
Wire Wire Line
	4000 6600 3850 6600
Connection ~ 3850 6300
Wire Wire Line
	3850 6300 4000 6300
Wire Wire Line
	3750 6300 3850 6300
Wire Wire Line
	3350 6300 3450 6300
$Comp
L Device:R R?
U 1 1 60F0C7DF
P 3600 6300
AR Path="/609243F4/60F0C7DF" Ref="R?"  Part="1" 
AR Path="/60F0C7DF" Ref="R5"  Part="1" 
F 0 "R5" V 3500 6300 50  0000 C CNN
F 1 "1KO" V 3600 6300 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 3530 6300 50  0001 C CNN
F 3 "~" H 3600 6300 50  0001 C CNN
	1    3600 6300
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 60F0C7E5
P 3850 6450
AR Path="/609243F4/60F0C7E5" Ref="R?"  Part="1" 
AR Path="/60F0C7E5" Ref="R12"  Part="1" 
F 0 "R12" H 3920 6496 50  0000 L CNN
F 1 "1,5KO" V 3850 6350 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 3780 6450 50  0001 C CNN
F 3 "~" H 3850 6450 50  0001 C CNN
	1    3850 6450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60F0C7EB
P 3550 6600
AR Path="/609243F4/60F0C7EB" Ref="#PWR?"  Part="1" 
AR Path="/60F0C7EB" Ref="#PWR010"  Part="1" 
F 0 "#PWR010" H 3550 6350 50  0001 C CNN
F 1 "GND" V 3555 6472 50  0000 R CNN
F 2 "" H 3550 6600 50  0001 C CNN
F 3 "" H 3550 6600 50  0001 C CNN
	1    3550 6600
	0    1    1    0   
$EndComp
Connection ~ 3850 7350
Wire Wire Line
	3850 7350 3550 7350
Wire Wire Line
	4000 7350 3850 7350
Connection ~ 3850 7050
Wire Wire Line
	3850 7050 4000 7050
Wire Wire Line
	3750 7050 3850 7050
Wire Wire Line
	3350 7050 3450 7050
$Comp
L Device:R R?
U 1 1 60F0C7F8
P 3600 7050
AR Path="/609243F4/60F0C7F8" Ref="R?"  Part="1" 
AR Path="/60F0C7F8" Ref="R6"  Part="1" 
F 0 "R6" V 3500 7050 50  0000 C CNN
F 1 "1KO" V 3600 7050 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 3530 7050 50  0001 C CNN
F 3 "~" H 3600 7050 50  0001 C CNN
	1    3600 7050
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 60F0C7FE
P 3850 7200
AR Path="/609243F4/60F0C7FE" Ref="R?"  Part="1" 
AR Path="/60F0C7FE" Ref="R13"  Part="1" 
F 0 "R13" H 3920 7246 50  0000 L CNN
F 1 "1,5KO" V 3850 7100 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 3780 7200 50  0001 C CNN
F 3 "~" H 3850 7200 50  0001 C CNN
	1    3850 7200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60F0C804
P 3550 7350
AR Path="/609243F4/60F0C804" Ref="#PWR?"  Part="1" 
AR Path="/60F0C804" Ref="#PWR014"  Part="1" 
F 0 "#PWR014" H 3550 7100 50  0001 C CNN
F 1 "GND" V 3555 7222 50  0000 R CNN
F 2 "" H 3550 7350 50  0001 C CNN
F 3 "" H 3550 7350 50  0001 C CNN
	1    3550 7350
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 60F0C80A
P 4000 6700
AR Path="/609243F4/60F0C80A" Ref="#PWR?"  Part="1" 
AR Path="/60F0C80A" Ref="#PWR015"  Part="1" 
F 0 "#PWR015" H 4000 6550 50  0001 C CNN
F 1 "+5V" V 4015 6828 50  0000 L CNN
F 2 "" H 4000 6700 50  0001 C CNN
F 3 "" H 4000 6700 50  0001 C CNN
	1    4000 6700
	0    -1   -1   0   
$EndComp
Text GLabel 3350 7050 0    50   Input ~ 0
pinOdometryLeft
$Comp
L power:+5V #PWR?
U 1 1 60F0C811
P 4000 7450
AR Path="/609243F4/60F0C811" Ref="#PWR?"  Part="1" 
AR Path="/60F0C811" Ref="#PWR018"  Part="1" 
F 0 "#PWR018" H 4000 7300 50  0001 C CNN
F 1 "+5V" V 4015 7578 50  0000 L CNN
F 2 "" H 4000 7450 50  0001 C CNN
F 3 "" H 4000 7450 50  0001 C CNN
	1    4000 7450
	0    -1   -1   0   
$EndComp
$Comp
L power:+3.3V #PWR?
U 1 1 60F0C817
P 4000 7550
AR Path="/609243F4/60F0C817" Ref="#PWR?"  Part="1" 
AR Path="/60F0C817" Ref="#PWR025"  Part="1" 
F 0 "#PWR025" H 4000 7400 50  0001 C CNN
F 1 "+3.3V" V 4015 7678 50  0000 L CNN
F 2 "" H 4000 7550 50  0001 C CNN
F 3 "" H 4000 7550 50  0001 C CNN
	1    4000 7550
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 J?
U 1 1 60F0C81D
P 4200 7350
AR Path="/609243F4/60F0C81D" Ref="J?"  Part="1" 
AR Path="/60F0C81D" Ref="J6"  Part="1" 
F 0 "J6" H 4280 7342 50  0000 L CNN
F 1 "ODO_Right" H 4280 7251 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 4200 7350 50  0001 C CNN
F 3 "~" H 4200 7350 50  0001 C CNN
	1    4200 7350
	1    0    0    -1  
$EndComp
Text GLabel 3350 6300 0    50   Input ~ 0
pinOdometryRight
$Comp
L power:+3.3V #PWR?
U 1 1 60F0C824
P 4000 6800
AR Path="/609243F4/60F0C824" Ref="#PWR?"  Part="1" 
AR Path="/60F0C824" Ref="#PWR016"  Part="1" 
F 0 "#PWR016" H 4000 6650 50  0001 C CNN
F 1 "+3.3V" V 4015 6928 50  0000 L CNN
F 2 "" H 4000 6800 50  0001 C CNN
F 3 "" H 4000 6800 50  0001 C CNN
	1    4000 6800
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 J?
U 1 1 60F0C82A
P 4200 6600
AR Path="/609243F4/60F0C82A" Ref="J?"  Part="1" 
AR Path="/60F0C82A" Ref="J1"  Part="1" 
F 0 "J1" H 4280 6592 50  0000 L CNN
F 1 "ODO_Left" H 4280 6501 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 4200 6600 50  0001 C CNN
F 3 "~" H 4200 6600 50  0001 C CNN
	1    4200 6600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x05 J?
U 1 1 60F18D1B
P 10850 4400
AR Path="/609243F4/60F18D1B" Ref="J?"  Part="1" 
AR Path="/60F18D1B" Ref="J11"  Part="1" 
F 0 "J11" H 10930 4442 50  0000 L CNN
F 1 "Cutter" H 10930 4351 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B5B-XH-A_1x05_P2.50mm_Vertical" H 10850 4400 50  0001 C CNN
F 3 "~" H 10850 4400 50  0001 C CNN
	1    10850 4400
	1    0    0    -1  
$EndComp
Text GLabel 10650 4400 0    50   Input ~ 0
pinMotorMowPWM
Text GLabel 10650 4500 0    50   Input ~ 0
pinMotorMowDir
Text GLabel 10650 4600 0    50   Input ~ 0
pinMotorMowEnable
$Comp
L Device:Jumper_NC_Dual JP?
U 1 1 60F18D24
P 9700 3850
AR Path="/609243F4/60F18D24" Ref="JP?"  Part="1" 
AR Path="/60F18D24" Ref="JP5"  Part="1" 
F 0 "JP5" H 9700 4089 50  0000 C CNN
F 1 "CutterPower" H 9700 3998 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x03_P2.54mm_Vertical" H 9700 3850 50  0001 C CNN
F 3 "~" H 9700 3850 50  0001 C CNN
	1    9700 3850
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR?
U 1 1 60F18D2A
P 9950 3850
AR Path="/609243F4/60F18D2A" Ref="#PWR?"  Part="1" 
AR Path="/60F18D2A" Ref="#PWR037"  Part="1" 
F 0 "#PWR037" H 9950 3700 50  0001 C CNN
F 1 "+3.3V" V 9965 3978 50  0000 L CNN
F 2 "" H 9950 3850 50  0001 C CNN
F 3 "" H 9950 3850 50  0001 C CNN
	1    9950 3850
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 60F18D30
P 9450 3850
AR Path="/609243F4/60F18D30" Ref="#PWR?"  Part="1" 
AR Path="/60F18D30" Ref="#PWR033"  Part="1" 
F 0 "#PWR033" H 9450 3700 50  0001 C CNN
F 1 "+5V" V 9465 3978 50  0000 L CNN
F 2 "" H 9450 3850 50  0001 C CNN
F 3 "" H 9450 3850 50  0001 C CNN
	1    9450 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9700 3950 9700 4200
$Comp
L power:GND #PWR?
U 1 1 60F18D37
P 10650 4300
AR Path="/609243F4/60F18D37" Ref="#PWR?"  Part="1" 
AR Path="/60F18D37" Ref="#PWR040"  Part="1" 
F 0 "#PWR040" H 10650 4050 50  0001 C CNN
F 1 "GND" V 10655 4172 50  0000 R CNN
F 2 "" H 10650 4300 50  0001 C CNN
F 3 "" H 10650 4300 50  0001 C CNN
	1    10650 4300
	0    1    1    0   
$EndComp
Wire Wire Line
	9700 4200 10650 4200
$Comp
L Connector:Screw_Terminal_01x05 J?
U 1 1 60F2668A
P 10850 2700
AR Path="/609243F4/60F2668A" Ref="J?"  Part="1" 
AR Path="/60F2668A" Ref="J7"  Part="1" 
F 0 "J7" H 10930 2742 50  0000 L CNN
F 1 "Motor_Right1" H 10930 2651 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B5B-XH-A_1x05_P2.50mm_Vertical" H 10850 2700 50  0001 C CNN
F 3 "~" H 10850 2700 50  0001 C CNN
	1    10850 2700
	1    0    0    -1  
$EndComp
$Comp
L Device:Jumper_NC_Dual JP?
U 1 1 60F26690
P 9700 2250
AR Path="/609243F4/60F26690" Ref="JP?"  Part="1" 
AR Path="/60F26690" Ref="JP3"  Part="1" 
F 0 "JP3" H 9700 2489 50  0000 C CNN
F 1 "MotorPower" H 9700 2398 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x03_P2.54mm_Vertical" H 9700 2250 50  0001 C CNN
F 3 "~" H 9700 2250 50  0001 C CNN
	1    9700 2250
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR?
U 1 1 60F26696
P 9950 2250
AR Path="/609243F4/60F26696" Ref="#PWR?"  Part="1" 
AR Path="/60F26696" Ref="#PWR036"  Part="1" 
F 0 "#PWR036" H 9950 2100 50  0001 C CNN
F 1 "+3.3V" V 9965 2378 50  0000 L CNN
F 2 "" H 9950 2250 50  0001 C CNN
F 3 "" H 9950 2250 50  0001 C CNN
	1    9950 2250
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 60F2669C
P 9450 2250
AR Path="/609243F4/60F2669C" Ref="#PWR?"  Part="1" 
AR Path="/60F2669C" Ref="#PWR032"  Part="1" 
F 0 "#PWR032" H 9450 2100 50  0001 C CNN
F 1 "+5V" V 9465 2378 50  0000 L CNN
F 2 "" H 9450 2250 50  0001 C CNN
F 3 "" H 9450 2250 50  0001 C CNN
	1    9450 2250
	0    -1   -1   0   
$EndComp
Text GLabel 10650 2700 0    50   Input ~ 0
pinMotorRightPWM
Text GLabel 10650 2800 0    50   Input ~ 0
pinMotorRightDir
Text GLabel 10650 2900 0    50   Input ~ 0
pinMotorRightEnable
$Comp
L Connector:Screw_Terminal_01x05 J?
U 1 1 60F266A5
P 10850 3300
AR Path="/609243F4/60F266A5" Ref="J?"  Part="1" 
AR Path="/60F266A5" Ref="J8"  Part="1" 
F 0 "J8" H 10930 3342 50  0000 L CNN
F 1 "Motor_Left1" H 10930 3251 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B5B-XH-A_1x05_P2.50mm_Vertical" H 10850 3300 50  0001 C CNN
F 3 "~" H 10850 3300 50  0001 C CNN
	1    10850 3300
	1    0    0    -1  
$EndComp
Text GLabel 10650 3300 0    50   Input ~ 0
pinMotorLeftPWM
Text GLabel 10650 3400 0    50   Input ~ 0
pinMotorLeftDir
Text GLabel 10650 3500 0    50   Input ~ 0
pinMotorLeftEnable
Wire Wire Line
	10650 2500 9700 2500
Wire Wire Line
	10650 3100 9700 3100
Wire Wire Line
	10650 2600 9550 2600
Wire Wire Line
	9550 3200 10650 3200
$Comp
L power:GND #PWR?
U 1 1 60F266B2
P 9350 3200
AR Path="/609243F4/60F266B2" Ref="#PWR?"  Part="1" 
AR Path="/60F266B2" Ref="#PWR031"  Part="1" 
F 0 "#PWR031" H 9350 2950 50  0001 C CNN
F 1 "GND" V 9355 3072 50  0000 R CNN
F 2 "" H 9350 3200 50  0001 C CNN
F 3 "" H 9350 3200 50  0001 C CNN
	1    9350 3200
	0    1    1    0   
$EndComp
Connection ~ 9550 3200
Wire Wire Line
	9700 2350 9700 2500
Connection ~ 9700 2500
Wire Wire Line
	9350 3200 9550 3200
Wire Wire Line
	9550 2600 9550 3200
Wire Wire Line
	9700 2500 9700 3100
$Comp
L power:+3.3V #PWR0103
U 1 1 60F3D87B
P 3250 850
F 0 "#PWR0103" H 3250 700 50  0001 C CNN
F 1 "+3.3V" H 3265 1023 50  0000 C CNN
F 2 "" H 3250 850 50  0001 C CNN
F 3 "" H 3250 850 50  0001 C CNN
	1    3250 850 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR047
U 1 1 60D69D5C
P 11950 950
F 0 "#PWR047" H 11950 700 50  0001 C CNN
F 1 "GND" V 11955 822 50  0000 R CNN
F 2 "" H 11950 950 50  0001 C CNN
F 3 "" H 11950 950 50  0001 C CNN
	1    11950 950 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 60D6858C
P 11950 850
F 0 "H1" H 12050 899 50  0000 L CNN
F 1 "MountingHole_Pad" H 12050 808 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad_TopBottom" H 11950 850 50  0001 C CNN
F 3 "~" H 11950 850 50  0001 C CNN
	1    11950 850 
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR04
U 1 1 60EBC81A
P 5850 6300
F 0 "#PWR04" H 5850 6150 50  0001 C CNN
F 1 "+3.3V" H 5865 6473 50  0000 C CNN
F 2 "" H 5850 6300 50  0001 C CNN
F 3 "" H 5850 6300 50  0001 C CNN
	1    5850 6300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 60EBEB69
P 5850 7500
F 0 "#PWR05" H 5850 7250 50  0001 C CNN
F 1 "GND" H 5855 7327 50  0000 C CNN
F 2 "" H 5850 7500 50  0001 C CNN
F 3 "" H 5850 7500 50  0001 C CNN
	1    5850 7500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 60EDD299
P 1000 5550
F 0 "R1" H 930 5504 50  0000 R CNN
F 1 "XXXX" H 930 5595 50  0000 R CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 930 5550 50  0001 C CNN
F 3 "~" H 1000 5550 50  0001 C CNN
	1    1000 5550
	-1   0    0    1   
$EndComp
Text GLabel 6400 6800 2    50   Input ~ 0
SCL0
Text GLabel 6400 6900 2    50   Input ~ 0
SDA0
$Comp
L Device:Jumper JP4
U 1 1 60F0074B
P 5250 6400
F 0 "JP4" H 5250 6664 50  0000 C CNN
F 1 "Jumper" H 5250 6573 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x02_P2.54mm_Vertical" H 5250 6400 50  0001 C CNN
F 3 "~" H 5250 6400 50  0001 C CNN
	1    5250 6400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4950 6400 4950 7000
Wire Wire Line
	4950 7000 5300 7000
$Comp
L Device:R R3
U 1 1 60F05BB1
P 1500 5550
F 0 "R3" H 1570 5596 50  0000 L CNN
F 1 "XXXX" H 1570 5505 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 1430 5550 50  0001 C CNN
F 3 "~" H 1500 5550 50  0001 C CNN
	1    1500 5550
	1    0    0    -1  
$EndComp
NoConn ~ 5300 6800
NoConn ~ 5300 6900
NoConn ~ 6400 7000
Wire Wire Line
	5550 6400 5600 6400
Wire Wire Line
	5600 6400 5600 6300
Wire Wire Line
	5600 6300 5850 6300
$Comp
L power:+3.3V #PWR043
U 1 1 60F57E19
P 1104 6095
F 0 "#PWR043" H 1104 5945 50  0001 C CNN
F 1 "+3.3V" V 1119 6223 50  0000 L CNN
F 2 "" H 1104 6095 50  0001 C CNN
F 3 "" H 1104 6095 50  0001 C CNN
	1    1104 6095
	0    -1   -1   0   
$EndComp
Connection ~ 1104 6095
Wire Wire Line
	1104 6095 1100 6095
Text GLabel 1450 5700 0    50   Input ~ 0
SDA0
$Comp
L Connector:Screw_Terminal_01x04 J3
U 1 1 60F6C524
P 2250 5600
F 0 "J3" H 2330 5592 50  0000 L CNN
F 1 "I2C0_0" H 2330 5501 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 2250 5600 50  0001 C CNN
F 3 "~" H 2250 5600 50  0001 C CNN
	1    2250 5600
	1    0    0    -1  
$EndComp
Connection ~ 5850 6300
$Comp
L teensy:GY-521 U2
U 1 1 60EB6FBE
P 5850 6900
F 0 "U2" H 6000 7250 60  0000 C CNN
F 1 "GY-521" H 5850 6600 60  0000 C CNN
F 2 "teensy_library-master:GY-521" H 5850 7597 60  0001 C CNN
F 3 "" H 5850 6900 60  0001 C CNN
	1    5850 6900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR044
U 1 1 60F8AC53
P 2050 5600
F 0 "#PWR044" H 2050 5350 50  0001 C CNN
F 1 "GND" V 2055 5472 50  0000 R CNN
F 2 "" H 2050 5600 50  0001 C CNN
F 3 "" H 2050 5600 50  0001 C CNN
	1    2050 5600
	0    1    1    0   
$EndComp
Wire Wire Line
	1450 5700 1500 5700
Wire Wire Line
	1500 5700 2050 5700
Connection ~ 1500 5700
$Comp
L power:+3V3 #PWR041
U 1 1 60F98C3A
P 850 5400
F 0 "#PWR041" H 850 5250 50  0001 C CNN
F 1 "+3V3" V 865 5528 50  0000 L CNN
F 2 "" H 850 5400 50  0001 C CNN
F 3 "" H 850 5400 50  0001 C CNN
	1    850  5400
	0    -1   -1   0   
$EndComp
Wire Wire Line
	850  5400 1000 5400
Wire Wire Line
	1500 5400 1000 5400
Connection ~ 1000 5400
Wire Wire Line
	1500 5400 1800 5400
Wire Wire Line
	1800 5400 1800 5500
Wire Wire Line
	1800 5500 2050 5500
Connection ~ 1500 5400
Text GLabel 900  5800 0    50   Input ~ 0
SCL0
Wire Wire Line
	900  5800 1000 5800
Wire Wire Line
	1000 5700 1000 5800
Connection ~ 1000 5800
Wire Wire Line
	1000 5800 2050 5800
Text GLabel 3400 5550 0    50   Output ~ 0
pinChargeEnable
Text GLabel 3400 5650 0    50   Output ~ 0
pinBatterySwitch
$Comp
L Connector:Screw_Terminal_01x06 J16
U 1 1 60FD4058
P 3600 5750
F 0 "J16" H 3680 5742 50  0000 L CNN
F 1 "Power_Board" H 3680 5651 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B6B-XH-A_1x06_P2.50mm_Vertical" H 3600 5750 50  0001 C CNN
F 3 "~" H 3600 5750 50  0001 C CNN
	1    3600 5750
	1    0    0    -1  
$EndComp
Text GLabel 3400 5850 0    50   BiDi ~ 0
SDA2
Text GLabel 3400 5750 0    50   BiDi ~ 0
SCL2
$Comp
L power:GND #PWR08
U 1 1 60FE4B86
P 3400 5950
F 0 "#PWR08" H 3400 5700 50  0001 C CNN
F 1 "GND" V 3405 5822 50  0000 R CNN
F 2 "" H 3400 5950 50  0001 C CNN
F 3 "" H 3400 5950 50  0001 C CNN
	1    3400 5950
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR045
U 1 1 60FE595E
P 3400 6050
F 0 "#PWR045" H 3400 5900 50  0001 C CNN
F 1 "+3.3V" V 3415 6178 50  0000 L CNN
F 2 "" H 3400 6050 50  0001 C CNN
F 3 "" H 3400 6050 50  0001 C CNN
	1    3400 6050
	0    -1   -1   0   
$EndComp
Text GLabel 2935 3480 0    50   Input ~ 0
pinSonarRightEcho
Text GLabel 2935 3680 0    50   Output ~ 0
pinSonarRightTrigger
Text GLabel 2935 3380 0    50   Input ~ 0
pinSonarLeftEcho
Text GLabel 2935 3580 0    50   Output ~ 0
pinSonarLeftTrigger
$Comp
L Device:Battery_Cell BT1
U 1 1 60EE371C
P 3300 5150
F 0 "BT1" V 3045 5200 50  0000 C CNN
F 1 "Battery_Cell" V 3136 5200 50  0000 C CNN
F 2 "Battery:BatteryHolder_Keystone_103_1x20mm" V 3300 5210 50  0001 C CNN
F 3 "~" V 3300 5210 50  0001 C CNN
	1    3300 5150
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR046
U 1 1 60EE61C7
P 3200 5150
F 0 "#PWR046" H 3200 4900 50  0001 C CNN
F 1 "GND" H 3205 4977 50  0000 C CNN
F 2 "" H 3200 5150 50  0001 C CNN
F 3 "" H 3200 5150 50  0001 C CNN
	1    3200 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 5150 3735 5150
Wire Wire Line
	3735 5118 3735 5130
Connection ~ 3735 5130
Wire Wire Line
	3735 5130 3735 5150
NoConn ~ 4335 5130
NoConn ~ 4035 5130
NoConn ~ 3885 5130
$EndSCHEMATC