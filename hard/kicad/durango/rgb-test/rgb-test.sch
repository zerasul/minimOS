EESchema Schematic File Version 4
LIBS:rgb-test-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Durango-X RGB SCART tester"
Date "2022-04-07"
Rev ""
Comp "@zuiko21"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 4xxx:4040 U2
U 1 1 610E542C
P 6750 3100
AR Path="/610E542C" Ref="U2"  Part="1" 
AR Path="/60C42E7C/610E542C" Ref="U19"  Part="1" 
F 0 "U2" H 6950 3850 50  0000 C CNN
F 1 "74HC4040" H 7000 3750 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 6750 3100 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/cd40/cd4020bms-24bms-40bms.pdf" H 6750 3100 50  0001 C CNN
	1    6750 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 610E5491
P 1200 2500
AR Path="/610E5491" Ref="#PWR0101"  Part="1" 
AR Path="/60C42E7C/610E5491" Ref="#PWR0112"  Part="1" 
F 0 "#PWR0101" H 1200 2250 50  0001 C CNN
F 1 "GND" H 1100 2350 50  0000 C CNN
F 2 "" H 1200 2500 50  0001 C CNN
F 3 "" H 1200 2500 50  0001 C CNN
	1    1200 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7250 2900 7450 2900
Wire Wire Line
	7250 3000 7650 3000
Wire Wire Line
	7250 3100 7750 3100
NoConn ~ 7250 3500
NoConn ~ 7250 3600
NoConn ~ 7250 3700
$Comp
L Oscillator:ACO-xxxMHz X1
U 1 1 610E54DD
P 1200 1100
AR Path="/610E54DD" Ref="X1"  Part="1" 
AR Path="/60C42E7C/610E54DD" Ref="X1"  Part="1" 
F 0 "X1" H 950 1200 50  0000 R CNN
F 1 "24.576 MHz" H 950 1100 50  0000 R CNN
F 2 "Oscillator:Oscillator_DIP-14" H 1650 750 50  0001 C CNN
F 3 "http://www.conwin.com/datasheets/cx/cx030.pdf" H 1100 1100 50  0001 C CNN
	1    1200 1100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0114
U 1 1 6112D9B0
P 3600 2450
F 0 "#PWR0114" H 3600 2300 50  0001 C CNN
F 1 "+5V" H 3700 2500 50  0000 C CNN
F 2 "" H 3600 2450 50  0001 C CNN
F 3 "" H 3600 2450 50  0001 C CNN
	1    3600 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	7250 3400 7550 3400
Wire Wire Line
	7750 3500 7750 3100
Connection ~ 7750 3100
Wire Wire Line
	7650 3000 7650 3500
Connection ~ 7650 3000
Wire Wire Line
	7450 2900 7450 3500
Connection ~ 7450 2900
Wire Wire Line
	7550 3500 7550 3400
Connection ~ 7550 3400
Wire Wire Line
	7550 3400 8050 3400
Wire Wire Line
	6750 800  6750 2300
$Comp
L power:GND #PWR0117
U 1 1 61380C56
P 6750 4000
F 0 "#PWR0117" H 6750 3750 50  0001 C CNN
F 1 "GND" H 6600 3950 50  0000 C CNN
F 2 "" H 6750 4000 50  0001 C CNN
F 3 "" H 6750 4000 50  0001 C CNN
	1    6750 4000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS85 U7
U 1 1 607EF60C
P 5350 3900
F 0 "U7" V 4900 3450 50  0000 R CNN
F 1 "74HC85" V 5000 3500 50  0000 R CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 5350 3900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS85" H 5350 3900 50  0001 C CNN
	1    5350 3900
	0    -1   1    0   
$EndComp
$Comp
L 74xx:74LS85 U8
U 1 1 607F05F3
P 8850 3900
F 0 "U8" V 8350 3450 50  0000 R CNN
F 1 "74HC85" V 8450 3450 50  0000 R CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 8850 3900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS85" H 8850 3900 50  0001 C CNN
	1    8850 3900
	0    -1   1    0   
$EndComp
Wire Wire Line
	4650 3900 4650 4400
NoConn ~ 5550 4400
NoConn ~ 5650 4400
NoConn ~ 9050 4400
NoConn ~ 9150 4400
Wire Wire Line
	8150 3900 8150 4400
Wire Wire Line
	8150 4400 8450 4400
Connection ~ 8450 4400
Wire Wire Line
	8450 4400 8550 4400
$Comp
L power:GND #PWR0118
U 1 1 6080613A
P 9550 3900
F 0 "#PWR0118" H 9550 3650 50  0001 C CNN
F 1 "GND" H 9555 3727 50  0000 C CNN
F 2 "" H 9550 3900 50  0001 C CNN
F 3 "" H 9550 3900 50  0001 C CNN
	1    9550 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0119
U 1 1 608064C6
P 6050 3900
F 0 "#PWR0119" H 6050 3650 50  0001 C CNN
F 1 "GND" H 6055 3727 50  0000 C CNN
F 2 "" H 6050 3900 50  0001 C CNN
F 3 "" H 6050 3900 50  0001 C CNN
	1    6050 3900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0120
U 1 1 6080689B
P 4650 3300
F 0 "#PWR0120" H 4650 3150 50  0001 C CNN
F 1 "+5V" H 4700 3350 50  0000 L CNN
F 2 "" H 4650 3300 50  0001 C CNN
F 3 "" H 4650 3300 50  0001 C CNN
	1    4650 3300
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0121
U 1 1 60806BB3
P 8150 3300
F 0 "#PWR0121" H 8150 3150 50  0001 C CNN
F 1 "+5V" H 8150 3450 50  0000 C CNN
F 2 "" H 8150 3300 50  0001 C CNN
F 3 "" H 8150 3300 50  0001 C CNN
	1    8150 3300
	1    0    0    -1  
$EndComp
Text Label 5750 4400 0    50   ~ 0
HS
Text Label 8100 2150 0    50   ~ 0
~DEH
Text Label 8050 2700 2    50   ~ 0
~DEV
Wire Wire Line
	8050 3400 8050 2750
$Comp
L 74xx:74HCT02 U4
U 1 1 6080EDF3
P 8350 2550
F 0 "U4" H 8350 2850 50  0000 C CNN
F 1 "74HC02" H 8350 2750 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 8350 2550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hct02" H 8350 2550 50  0001 C CNN
	1    8350 2550
	1    0    0    -1  
$EndComp
Text Label 9600 2550 2    50   ~ 0
DE
Text Label 2350 2600 2    50   ~ 0
LEND
Connection ~ 4650 3900
Wire Wire Line
	5250 3400 5250 3300
Wire Wire Line
	4650 3300 4650 3900
Wire Wire Line
	5150 3400 5150 3350
Wire Wire Line
	5150 3350 6050 3350
Wire Wire Line
	6050 3350 6050 3900
Connection ~ 6050 3900
Connection ~ 4950 4400
Wire Wire Line
	4950 4400 5050 4400
Connection ~ 5050 4400
Wire Wire Line
	5050 4400 5150 4400
Wire Wire Line
	5150 3350 5050 3350
Wire Wire Line
	5050 3350 5050 3400
Connection ~ 5150 3350
Wire Wire Line
	8050 3400 8050 4450
Wire Wire Line
	8050 4450 8650 4450
Wire Wire Line
	8650 4450 8650 4400
Connection ~ 8050 3400
Wire Wire Line
	7750 3100 8950 3100
Wire Wire Line
	8950 3100 8950 3400
Wire Wire Line
	7650 3000 9050 3000
Wire Wire Line
	9050 3000 9050 3400
Wire Wire Line
	9150 2900 9150 3400
Wire Wire Line
	9250 2800 9250 3400
Wire Wire Line
	8450 3400 8450 3350
Wire Wire Line
	8450 3350 8650 3350
Wire Wire Line
	8650 3350 8650 3400
Wire Wire Line
	8550 3400 8550 3300
$Comp
L power:GND #PWR0123
U 1 1 608EF4C1
P 8450 3350
F 0 "#PWR0123" H 8450 3100 50  0001 C CNN
F 1 "GND" V 8455 3222 50  0000 R CNN
F 2 "" H 8450 3350 50  0001 C CNN
F 3 "" H 8450 3350 50  0001 C CNN
	1    8450 3350
	0    1    1    0   
$EndComp
Connection ~ 8450 3350
Wire Wire Line
	6250 2900 6250 4250
Wire Wire Line
	6250 4250 7600 4250
Wire Wire Line
	5750 4400 5750 4650
$Comp
L power:+5V #PWR0144
U 1 1 609AC98D
P 6150 5400
F 0 "#PWR0144" H 6150 5250 50  0001 C CNN
F 1 "+5V" H 6250 5450 50  0000 C CNN
F 2 "" H 6150 5400 50  0001 C CNN
F 3 "" H 6150 5400 50  0001 C CNN
	1    6150 5400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0145
U 1 1 60A2F9CC
P 6150 7200
F 0 "#PWR0145" H 6150 6950 50  0001 C CNN
F 1 "GND" H 6155 7027 50  0000 C CNN
F 2 "" H 6150 7200 50  0001 C CNN
F 3 "" H 6150 7200 50  0001 C CNN
	1    6150 7200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC245 U5
U 1 1 60A3BC75
P 6150 6200
F 0 "U5" H 6000 6950 50  0000 C CNN
F 1 "74HC245" H 5950 6850 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm_Socket" H 6150 6200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 6150 6200 50  0001 C CNN
	1    6150 6200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5650 5700 5650 5800
Wire Wire Line
	5650 6000 5650 5900
Wire Wire Line
	5650 6300 5650 6400
Wire Wire Line
	5650 6100 5650 6200
Wire Wire Line
	6150 7200 6150 7000
Wire Wire Line
	6650 5800 7200 5800
Wire Wire Line
	6650 6000 7200 6000
Wire Wire Line
	6650 6200 7200 6200
$Comp
L Device:R R2
U 1 1 60B908BB
P 7350 6000
F 0 "R2" V 7300 6150 50  0000 C CNN
F 1 "470" V 7350 6000 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 7280 6000 50  0001 C CNN
F 3 "~" H 7350 6000 50  0001 C CNN
	1    7350 6000
	0    1    1    0   
$EndComp
$Comp
L Device:R R3
U 1 1 60B90BF0
P 7350 6200
F 0 "R3" V 7300 6350 50  0000 C CNN
F 1 "470" V 7350 6200 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 7280 6200 50  0001 C CNN
F 3 "~" H 7350 6200 50  0001 C CNN
	1    7350 6200
	0    1    1    0   
$EndComp
$Comp
L Device:R R4
U 1 1 60B90F46
P 6800 5200
F 0 "R4" V 6700 5200 50  0000 C CNN
F 1 "1K2" V 6800 5200 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 6730 5200 50  0001 C CNN
F 3 "~" H 6800 5200 50  0001 C CNN
	1    6800 5200
	0    1    1    0   
$EndComp
Wire Wire Line
	7750 6200 7700 6200
Wire Wire Line
	7700 6200 7700 6000
Wire Wire Line
	7700 6000 7750 6000
Wire Wire Line
	7700 6000 7700 5800
Wire Wire Line
	7700 5800 7750 5800
Connection ~ 7700 6000
Wire Wire Line
	8250 6200 8300 6200
Wire Wire Line
	8300 6400 8250 6400
Connection ~ 7700 5800
Wire Wire Line
	8250 5500 8300 5500
NoConn ~ 7750 6400
NoConn ~ 7750 6300
NoConn ~ 7750 5600
NoConn ~ 7750 5500
Wire Wire Line
	7700 5400 7750 5400
NoConn ~ 8250 6000
NoConn ~ 8250 5900
NoConn ~ 8250 5800
Wire Wire Line
	7550 6100 7750 6100
Wire Wire Line
	7500 6200 7550 6200
Wire Wire Line
	7550 5700 7750 5700
Wire Wire Line
	7650 5900 7750 5900
$Comp
L power:+5V #PWR0146
U 1 1 60B1E4C5
P 9100 5700
F 0 "#PWR0146" H 9100 5550 50  0001 C CNN
F 1 "+5V" V 9115 5828 50  0000 L CNN
F 2 "" H 9100 5700 50  0001 C CNN
F 3 "" H 9100 5700 50  0001 C CNN
	1    9100 5700
	0    1    1    0   
$EndComp
Wire Wire Line
	7650 5900 7650 6000
Wire Wire Line
	7650 6000 7500 6000
Wire Wire Line
	7550 6100 7550 6200
$Comp
L Device:CP C1
U 1 1 60C049B1
P 8300 5350
F 0 "C1" H 8250 5650 50  0000 L CNN
F 1 "100uF" H 8200 5550 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D4.0mm_P1.50mm" H 8338 5200 50  0001 C CNN
F 3 "~" H 8300 5350 50  0001 C CNN
	1    8300 5350
	1    0    0    -1  
$EndComp
Connection ~ 7700 5400
$Comp
L power:GND #PWR0147
U 1 1 60CE8ADA
P 8300 6300
F 0 "#PWR0147" H 8300 6050 50  0001 C CNN
F 1 "GND" H 8300 6150 50  0000 C CNN
F 2 "" H 8300 6300 50  0001 C CNN
F 3 "" H 8300 6300 50  0001 C CNN
	1    8300 6300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7600 4250 7600 4100
$Comp
L 74xx:74HCT02 U4
U 4 1 6181229E
P 9850 2850
F 0 "U4" V 9800 2400 50  0000 L CNN
F 1 "74HC02" V 9900 2350 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 9850 2850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hct02" H 9850 2850 50  0001 C CNN
	4    9850 2850
	0    -1   1    0   
$EndComp
Wire Wire Line
	8050 2450 8050 2150
Wire Wire Line
	8050 2150 5750 2150
Connection ~ 5750 2150
$Comp
L Device:R R5
U 1 1 615F5223
P 8950 5700
F 0 "R5" V 8850 5700 50  0000 C CNN
F 1 "180" V 8950 5700 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P2.54mm_Vertical" V 8880 5700 50  0001 C CNN
F 3 "~" H 8950 5700 50  0001 C CNN
	1    8950 5700
	0    1    1    0   
$EndComp
Wire Wire Line
	6650 6200 6650 6100
Connection ~ 6650 6200
Wire Wire Line
	6650 6000 6650 5900
Connection ~ 6650 6000
Wire Wire Line
	6650 5800 6650 5700
Connection ~ 6650 5800
Wire Wire Line
	9950 2550 9750 2550
Wire Wire Line
	4650 4400 4950 4400
$Comp
L 74xx:74HCT02 U4
U 2 1 608EFBD8
P 7500 4500
F 0 "U4" H 7500 4700 50  0000 C CNN
F 1 "74HC02" H 7500 4300 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 7500 4500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hct02" H 7500 4500 50  0001 C CNN
	2    7500 4500
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3600 2550 4250 2550
Text Label 3800 2550 0    50   ~ 0
VA1
Wire Wire Line
	3600 2650 5750 2650
Wire Wire Line
	5750 2150 5750 2600
Connection ~ 5750 2650
Text Label 3800 2650 0    50   ~ 0
~LINE
Text Label 3800 2750 0    50   ~ 0
VA5
Wire Wire Line
	9850 6500 6750 6500
Wire Wire Line
	6650 6600 6700 6600
Wire Wire Line
	6700 6600 6700 7200
Wire Wire Line
	6700 7200 6150 7200
Text Label 7050 4250 0    50   ~ 0
FEND
$Comp
L 74xx:74LS21 U3
U 1 1 615D7357
P 7600 3800
F 0 "U3" V 7700 3550 50  0000 C CNN
F 1 "74HC21" V 7800 3550 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 7600 3800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS21" H 7600 3800 50  0001 C CNN
	1    7600 3800
	0    1    1    0   
$EndComp
$Comp
L 74xx:74LS21 U3
U 2 1 615EA142
P 3300 2600
F 0 "U3" H 3600 2750 50  0000 R CNN
F 1 "74HC21" H 3650 2850 50  0000 R CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 3300 2600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS21" H 3300 2600 50  0001 C CNN
	2    3300 2600
	-1   0    0    1   
$EndComp
Wire Wire Line
	1200 1400 1200 2500
$Comp
L 4xxx:4040 U1
U 1 1 617B535F
P 2000 1600
F 0 "U1" H 2000 2581 50  0000 C CNN
F 1 "74HCT4040" H 2000 2490 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 2000 1600 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/cd40/cd4020bms-24bms-40bms.pdf" H 2000 1600 50  0001 C CNN
	1    2000 1600
	1    0    0    -1  
$EndComp
Connection ~ 1200 2500
$Comp
L power:+5V #PWR0124
U 1 1 61ABC077
P 1200 800
F 0 "#PWR0124" H 1200 650 50  0001 C CNN
F 1 "+5V" H 1200 950 50  0000 C CNN
F 2 "" H 1200 800 50  0001 C CNN
F 3 "" H 1200 800 50  0001 C CNN
	1    1200 800 
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 2600 1500 2600
Wire Wire Line
	1500 2600 1500 1400
NoConn ~ 2500 1100
Wire Wire Line
	2500 1600 4250 1600
Wire Wire Line
	4250 1600 4250 2550
Wire Wire Line
	2500 1800 5450 1800
Wire Wire Line
	2500 1900 5550 1900
Wire Wire Line
	5550 1900 5550 3400
Wire Wire Line
	2500 2000 5650 2000
Wire Wire Line
	2500 2100 5750 2100
Wire Wire Line
	5750 2100 5750 2150
NoConn ~ 2500 2200
Connection ~ 2000 800 
Wire Wire Line
	1200 2500 2000 2500
Wire Wire Line
	5750 2650 5750 3400
$Comp
L 74xx:74HCT02 U4
U 3 1 612B6A33
P 9100 2250
F 0 "U4" H 9100 1950 50  0000 C CNN
F 1 "74HC02" H 9100 2050 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 9100 2250 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hct02" H 9100 2250 50  0001 C CNN
	3    9100 2250
	1    0    0    1   
$EndComp
Connection ~ 1200 800 
Wire Wire Line
	1200 800  2000 800 
Wire Wire Line
	8300 6200 8300 6300
Wire Wire Line
	7500 5400 7700 5400
Wire Wire Line
	6950 5200 8300 5200
Wire Wire Line
	7700 5400 7700 5800
$Comp
L power:GND #PWR0162
U 1 1 623A5F47
P 7500 5400
F 0 "#PWR0162" H 7500 5150 50  0001 C CNN
F 1 "GND" H 7400 5300 50  0000 C CNN
F 2 "" H 7500 5400 50  0001 C CNN
F 3 "" H 7500 5400 50  0001 C CNN
	1    7500 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 5600 8300 5600
Wire Wire Line
	8250 6300 8300 6300
Connection ~ 8300 6200
Wire Wire Line
	7200 4500 6200 4500
Wire Wire Line
	6200 4500 6200 3250
Text Label 7050 4500 0    50   ~ 0
~VS
Wire Wire Line
	4650 3300 5250 3300
Wire Wire Line
	4950 3400 4950 3250
Wire Wire Line
	4950 3250 6200 3250
Wire Wire Line
	6250 2600 5750 2600
Connection ~ 5750 2600
Wire Wire Line
	5750 2600 5750 2650
Wire Wire Line
	8650 3350 8750 3350
Wire Wire Line
	8750 3350 8750 3400
Connection ~ 8650 3350
$Comp
L Connector_Generic:Conn_2Rows-21Pins J1
U 1 1 608DC490
P 7950 5900
F 0 "J1" H 7800 5300 50  0000 C CNN
F 1 "SCART" H 8050 5300 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x11_P2.54mm_Vertical" H 7950 5900 50  0001 C CNN
F 3 "~" H 7950 5900 50  0001 C CNN
	1    7950 5900
	1    0    0    1   
$EndComp
$Comp
L Device:R R1
U 1 1 60B9031C
P 7350 5800
F 0 "R1" V 7300 5950 50  0000 C CNN
F 1 "470" V 7350 5800 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 7280 5800 50  0001 C CNN
F 3 "~" H 7350 5800 50  0001 C CNN
	1    7350 5800
	0    1    1    0   
$EndComp
Wire Wire Line
	2000 800  6750 800 
Wire Wire Line
	7250 2800 9250 2800
Wire Wire Line
	7450 2900 9150 2900
Connection ~ 8300 6300
Wire Wire Line
	8300 6300 8300 6400
Wire Wire Line
	9100 6100 8250 6100
Connection ~ 9750 2550
Wire Wire Line
	9750 2550 9650 2550
Wire Wire Line
	9850 6500 9850 3150
Text Label 6700 6000 0    50   ~ 0
GREEN
Text Label 6700 5800 0    50   ~ 0
RED
Text Label 6700 6200 0    50   ~ 0
BLUE
Text Label 7550 5200 0    50   ~ 0
~S_SYNC
Text Label 5650 6000 2    50   ~ 0
GIN
Text Label 5650 5800 2    50   ~ 0
RIN
Text Label 5650 6150 2    50   ~ 0
BIN
Text Label 5750 5200 0    50   ~ 0
~CSYNC
NoConn ~ 7250 2600
NoConn ~ 7250 2700
NoConn ~ 2500 1500
NoConn ~ 2500 1400
NoConn ~ 2500 1300
NoConn ~ 2500 1200
Wire Wire Line
	9100 5700 9100 6100
Connection ~ 9100 5700
Wire Wire Line
	7800 4400 7800 4600
Wire Wire Line
	7800 4600 9250 4600
Wire Wire Line
	9250 4600 9250 4400
Connection ~ 7800 4600
Text Label 9250 4600 2    50   ~ 0
VS
Wire Wire Line
	6750 6500 6750 6700
Wire Wire Line
	6750 6700 6650 6700
Text Label 9850 6500 2    50   ~ 0
~DE
Text Label 7550 5700 0    50   ~ 0
S_R
Text Label 7650 6000 1    50   ~ 0
S_G
Text Label 7550 6200 0    50   ~ 0
S_B
$Comp
L 74xx:74HC86 U6
U 1 1 628E9C05
P 5450 4750
F 0 "U6" H 5450 4450 50  0000 C CNN
F 1 "74HC86" H 5450 4550 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 5450 4750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 5450 4750 50  0001 C CNN
	1    5450 4750
	-1   0    0    1   
$EndComp
Wire Wire Line
	5750 4850 7800 4850
Wire Wire Line
	7800 4850 7800 4600
Wire Wire Line
	6150 7200 5650 7200
Connection ~ 6150 7200
$Comp
L 74xx:74HC86 U6
U 2 1 62913F52
P 5050 5100
F 0 "U6" V 5004 5288 50  0000 L CNN
F 1 "74HC86" V 5095 5288 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 5050 5100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 5050 5100 50  0001 C CNN
	2    5050 5100
	0    1    1    0   
$EndComp
$Comp
L 74xx:74HC86 U6
U 3 1 62918DBD
P 4400 5100
F 0 "U6" V 4354 5288 50  0000 L CNN
F 1 "74HC86" V 4445 5288 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 4400 5100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 4400 5100 50  0001 C CNN
	3    4400 5100
	0    1    1    0   
$EndComp
$Comp
L 74xx:74HC86 U6
U 4 1 6291D70F
P 3750 5100
F 0 "U6" V 3704 5288 50  0000 L CNN
F 1 "74HC86" V 3795 5288 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 3750 5100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 3750 5100 50  0001 C CNN
	4    3750 5100
	0    1    1    0   
$EndComp
Wire Wire Line
	5150 4800 5150 4750
Wire Wire Line
	5150 4750 4500 4750
Wire Wire Line
	3850 4750 3850 4800
Wire Wire Line
	4500 4750 4500 4800
Connection ~ 4500 4750
Wire Wire Line
	4500 4750 3850 4750
Wire Wire Line
	4950 4800 4950 4700
Wire Wire Line
	4950 4700 4650 4700
Wire Wire Line
	4300 4700 4300 4800
Wire Wire Line
	4300 4700 3650 4700
Wire Wire Line
	3650 4700 3650 4800
Connection ~ 4300 4700
Wire Wire Line
	4650 4400 4650 4700
Connection ~ 4650 4400
Connection ~ 4650 4700
Wire Wire Line
	4650 4700 4300 4700
Text Label 5150 4750 1    50   ~ 0
CSYNC
Wire Wire Line
	3750 5400 4400 5400
Wire Wire Line
	5750 5400 5750 5200
Wire Wire Line
	5750 5200 6650 5200
Connection ~ 4400 5400
Wire Wire Line
	4400 5400 5050 5400
Connection ~ 5050 5400
Wire Wire Line
	5050 5400 5750 5400
NoConn ~ 6650 6300
NoConn ~ 6650 6400
Wire Wire Line
	5650 6400 5650 7200
Connection ~ 5650 6400
Connection ~ 5650 7200
$Comp
L 74xx:74HC86 U6
U 5 1 6296569A
P 1650 6700
F 0 "U6" H 1880 6746 50  0000 L CNN
F 1 "74HC86" H 1880 6655 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 1650 6700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 1650 6700 50  0001 C CNN
	5    1650 6700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC02 U4
U 5 1 62966881
P 2400 6700
F 0 "U4" H 2630 6746 50  0000 L CNN
F 1 "74HC02" H 2630 6655 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 2400 6700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc02" H 2400 6700 50  0001 C CNN
	5    2400 6700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS21 U3
U 3 1 62968D57
P 3150 6700
F 0 "U3" H 3380 6746 50  0000 L CNN
F 1 "74HC21" H 3380 6655 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 3150 6700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS21" H 3150 6700 50  0001 C CNN
	3    3150 6700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1650 7200 2400 7200
Connection ~ 2400 7200
Wire Wire Line
	2400 7200 3150 7200
Connection ~ 3150 7200
Wire Wire Line
	1650 6200 2400 6200
Wire Wire Line
	3150 6200 3150 4700
Wire Wire Line
	3150 4700 2250 4700
Connection ~ 3150 6200
Connection ~ 2400 6200
Wire Wire Line
	2400 6200 3150 6200
Connection ~ 3650 4700
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 6298E54E
P 3150 7200
F 0 "#FLG0101" H 3150 7275 50  0001 C CNN
F 1 "PWR_FLAG" H 3150 7373 50  0000 C CNN
F 2 "" H 3150 7200 50  0001 C CNN
F 3 "~" H 3150 7200 50  0001 C CNN
	1    3150 7200
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 6298EE98
P 3150 4700
F 0 "#FLG0102" H 3150 4775 50  0001 C CNN
F 1 "PWR_FLAG" H 3150 4873 50  0000 C CNN
F 2 "" H 3150 4700 50  0001 C CNN
F 3 "~" H 3150 4700 50  0001 C CNN
	1    3150 4700
	1    0    0    -1  
$EndComp
Connection ~ 3150 4700
Text Label 7250 3300 0    50   ~ 0
V2
Text Label 7250 3200 0    50   ~ 0
V1
Text Label 7250 3100 0    50   ~ 0
V0
Wire Wire Line
	9650 2550 9650 5200
Wire Wire Line
	9650 5200 9100 5200
Connection ~ 9650 2550
Wire Wire Line
	9650 2550 8650 2550
$Comp
L Device:R R6
U 1 1 6299BA6E
P 8950 5200
F 0 "R6" V 8850 5200 50  0000 C CNN
F 1 "1K5" V 8950 5200 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 8880 5200 50  0001 C CNN
F 3 "~" H 8950 5200 50  0001 C CNN
	1    8950 5200
	0    1    1    0   
$EndComp
Wire Wire Line
	8800 5200 8300 5200
Connection ~ 8300 5200
Text Label 2500 2000 0    50   ~ 0
H2
Text Label 2500 1900 0    50   ~ 0
H1
Text Label 2500 1800 0    50   ~ 0
H0
NoConn ~ 2500 1700
$Comp
L Jumper:Jumper_3_Open JP1
U 1 1 629CB504
P 4650 5850
F 0 "JP1" H 4650 6074 50  0000 C CNN
F 1 "GREEN SEL" H 4650 5983 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 4650 5850 50  0001 C CNN
F 3 "~" H 4650 5850 50  0001 C CNN
	1    4650 5850
	1    0    0    -1  
$EndComp
$Comp
L Jumper:Jumper_3_Open JP2
U 1 1 629CE90F
P 5150 5650
F 0 "JP2" H 5150 5874 50  0000 C CNN
F 1 "RED SEL" H 5150 5783 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 5150 5650 50  0001 C CNN
F 3 "~" H 5150 5650 50  0001 C CNN
	1    5150 5650
	1    0    0    -1  
$EndComp
$Comp
L Jumper:Jumper_3_Open JP3
U 1 1 629D055D
P 4150 6050
F 0 "JP3" H 4150 6274 50  0000 C CNN
F 1 "BLUE SEL" H 4150 6183 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 4150 6050 50  0001 C CNN
F 3 "~" H 4150 6050 50  0001 C CNN
	1    4150 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 5800 5150 5800
Connection ~ 5650 5800
Wire Wire Line
	4650 6000 5650 6000
Connection ~ 5650 6000
Wire Wire Line
	4150 6200 5650 6200
Connection ~ 5650 6200
Text Label 3900 6050 2    50   ~ 0
H0
Text Label 4900 5650 2    50   ~ 0
H1
Text Label 4400 5850 2    50   ~ 0
H2
Text Label 4400 6050 0    50   ~ 0
V0
Text Label 5400 5650 0    50   ~ 0
V1
Text Label 4900 5850 0    50   ~ 0
V2
Connection ~ 5150 4750
Wire Wire Line
	3150 7200 5650 7200
Wire Wire Line
	8800 2150 8050 2150
Connection ~ 8050 2150
Wire Wire Line
	8800 2350 8800 2750
Wire Wire Line
	8800 2750 8050 2750
Connection ~ 8050 2750
Wire Wire Line
	8050 2750 8050 2650
Wire Wire Line
	9400 2250 9650 2250
Wire Wire Line
	9650 2250 9650 2550
$Comp
L Switch:SW_Push_Open SW1
U 1 1 62AB13E7
P 8600 5700
F 0 "SW1" H 8600 5600 50  0000 C CNN
F 1 "TEST" H 8600 5800 50  0000 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 8600 5900 50  0001 C CNN
F 3 "~" H 8600 5900 50  0001 C CNN
	1    8600 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	8300 5600 8300 6200
Wire Wire Line
	8250 5700 8400 5700
Wire Wire Line
	8550 3300 8150 3300
Wire Wire Line
	8150 3300 8150 3900
Connection ~ 8150 3300
Connection ~ 8150 3900
Text Label 8300 5500 0    50   ~ 0
COMP
Text Notes 8500 5050 0    50   ~ 0
or lower, down to 470 ohm
Text Notes 8700 5900 0    50   ~ 0
or higher,\nup to 360
Text Notes 3850 6400 0    50   ~ 10
Horizontal/Vertical pattern choice,\nmay be connected to any counter output
Text Notes 9300 2100 0    50   ~ 0
may be supressed,\nfor buffering only
Text Notes 3650 4650 0    50   ~ 0
these may be supressed,\nfor buffering only
Text Notes 500  1400 0    50   Italic 0
or 24 MHz\nfor nominal f.
Text Notes 3800 2450 0    50   Italic 0
or +5V for\nnominal f.
Wire Wire Line
	5650 2000 5650 2750
Wire Wire Line
	5650 2750 3600 2750
Connection ~ 5650 2750
Wire Wire Line
	5650 2750 5650 3400
Wire Wire Line
	5450 1800 5450 3400
Text Notes 2300 750  0    50   Italic 0
74AC might be fast enough for nominal f.
Text Notes 8550 5550 0    50   ~ 10
press to disable RGB\n(grey square)
Text Label 8350 5700 0    50   ~ 0
FB
Connection ~ 4650 3300
Wire Wire Line
	7550 5700 7550 5800
Wire Wire Line
	7550 5800 7500 5800
$Comp
L Connector:USB_B J2
U 1 1 625936AB
P 1650 4900
F 0 "J2" H 1500 5350 50  0000 C CNN
F 1 "POWER" H 1550 5250 50  0000 C CNN
F 2 "Connector_USB:USB_B_OST_USB-B1HSxx_Horizontal" H 1800 4850 50  0001 C CNN
F 3 " ~" H 1800 4850 50  0001 C CNN
	1    1650 4900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 625A1F95
P 1650 5300
F 0 "#PWR0102" H 1650 5050 50  0001 C CNN
F 1 "GND" H 1655 5127 50  0000 C CNN
F 2 "" H 1650 5300 50  0001 C CNN
F 3 "" H 1650 5300 50  0001 C CNN
	1    1650 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 5300 1650 5300
Connection ~ 1650 5300
NoConn ~ 1950 4900
NoConn ~ 1950 5000
$Comp
L Device:CP C2
U 1 1 62638BCA
P 2250 4850
F 0 "C2" H 2300 5050 50  0000 L CNN
F 1 "470uF" H 2300 4950 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 2288 4700 50  0001 C CNN
F 3 "~" H 2250 4850 50  0001 C CNN
	1    2250 4850
	1    0    0    -1  
$EndComp
Connection ~ 2250 4700
Wire Wire Line
	1650 5300 2250 5300
Wire Wire Line
	2250 5300 2250 5000
Wire Wire Line
	3150 4700 3650 4700
Wire Wire Line
	2250 4700 1950 4700
$EndSCHEMATC
