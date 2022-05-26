EESchema Schematic File Version 4
LIBS:devcart-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Durango-X development cartridge"
Date "2022-05-26"
Rev ""
Comp "@zuiko21"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 "64K ROM + 128K RAM"
$EndDescr
$Comp
L edge_conn:Durango_ROM J1
U 1 1 628FE747
P 1300 2050
F 0 "J1" H 1100 3100 50  0000 C CNN
F 1 "EDGE CONNECTOR" H 1700 3100 50  0000 C CNN
F 2 "edge_conn:Durango_ROM" H 1000 1050 50  0001 C CNN
F 3 "" H 1000 1050 50  0001 C CNN
	1    1300 2050
	1    0    0    -1  
$EndComp
$Comp
L Memory_RAM:628128_DIP32_SSOP32 U2
U 1 1 628FEFFB
P 4300 1950
F 0 "U2" H 4300 3131 50  0000 C CNN
F 1 "628128" H 4300 3040 50  0000 C CNN
F 2 "Package_DIP:DIP-32_W15.24mm" H 4300 1950 50  0001 C CNN
F 3 "http://www.futurlec.com/Datasheet/Memory/628128.pdf" H 4300 1950 50  0001 C CNN
	1    4300 1950
	1    0    0    -1  
$EndComp
$Comp
L Memory_EPROM:27C512 U1
U 1 1 6290008A
P 2750 2050
F 0 "U1" H 2750 3331 50  0000 C CNN
F 1 "27C512" H 2750 3240 50  0000 C CNN
F 2 "Socket:DIP_Socket-28_W11.9_W12.7_W15.24_W17.78_W18.5_3M_228-1277-00-0602J" H 2750 2050 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc0015.pdf" H 2750 2050 50  0001 C CNN
	1    2750 2050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS174 U3
U 1 1 62900B57
P 1300 4850
F 0 "U3" H 1500 5500 50  0000 C CNN
F 1 "74HC174" H 1500 5400 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 1300 4850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS174" H 1300 4850 50  0001 C CNN
	1    1300 4850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS157 U4
U 1 1 62901806
P 2750 5100
F 0 "U4" H 2950 5950 50  0000 C CNN
F 1 "74HC157" H 2950 5850 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 2750 5100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 2750 5100 50  0001 C CNN
	1    2750 5100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U6
U 1 1 62902251
P 6050 4600
F 0 "U6" H 6050 4967 50  0000 C CNN
F 1 "74HC139" H 6050 4876 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 6050 4600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 6050 4600 50  0001 C CNN
	1    6050 4600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U6
U 2 1 62902D56
P 6050 5300
F 0 "U6" H 6050 4950 50  0000 C CNN
F 1 "74HC139" H 6050 4850 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 6050 5300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 6050 5300 50  0001 C CNN
	2    6050 5300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U7
U 1 1 6290409E
P 8000 2750
F 0 "U7" H 8000 3117 50  0000 C CNN
F 1 "74HC139" H 8000 3026 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 8000 2750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 8000 2750 50  0001 C CNN
	1    8000 2750
	-1   0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U7
U 2 1 62904C6D
P 8000 3450
F 0 "U7" H 8000 3100 50  0000 C CNN
F 1 "74HC139" H 8000 3000 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 8000 3450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 8000 3450 50  0001 C CNN
	2    8000 3450
	-1   0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U6
U 3 1 62905B1C
P 9100 1450
F 0 "U6" H 9330 1496 50  0000 L CNN
F 1 "74HC139" H 9330 1405 50  0000 L CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 9100 1450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 9100 1450 50  0001 C CNN
	3    9100 1450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U7
U 3 1 629064A4
P 9950 1450
F 0 "U7" H 10180 1496 50  0000 L CNN
F 1 "74HC139" H 10180 1405 50  0000 L CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 9950 1450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 9950 1450 50  0001 C CNN
	3    9950 1450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC245 U8
U 1 1 62906E6F
P 4300 4950
F 0 "U8" H 4500 5700 50  0000 C CNN
F 1 "74HC245" H 4500 5600 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm" H 4300 4950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 4300 4950 50  0001 C CNN
	1    4300 4950
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x08_Odd_Even J2
U 1 1 629500C3
P 5600 1400
F 0 "J2" H 5650 2000 50  0000 C CNN
F 1 "PORT C" H 5650 1900 50  0000 C CNN
F 2 "Connector_IDC:IDC-Header_2x08_P2.54mm_Vertical" H 5600 1400 50  0001 C CNN
F 3 "~" H 5600 1400 50  0001 C CNN
	1    5600 1400
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x08_Odd_Even J3
U 1 1 62950E5E
P 6650 1400
F 0 "J3" H 6700 2000 50  0000 C CNN
F 1 "PORT D" H 6700 1900 50  0000 C CNN
F 2 "Connector_IDC:IDC-Header_2x08_P2.54mm_Vertical" H 6650 1400 50  0001 C CNN
F 3 "~" H 6650 1400 50  0001 C CNN
	1    6650 1400
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x08_Odd_Even J4
U 1 1 62952727
P 7700 1400
F 0 "J4" H 7750 2000 50  0000 C CNN
F 1 "PORT E" H 7750 1900 50  0000 C CNN
F 2 "Connector_IDC:IDC-Header_2x08_P2.54mm_Vertical" H 7700 1400 50  0001 C CNN
F 3 "~" H 7700 1400 50  0001 C CNN
	1    7700 1400
	1    0    0    -1  
$EndComp
NoConn ~ 1700 1500
NoConn ~ 1700 1600
Wire Wire Line
	1300 950  2750 950 
Wire Wire Line
	7500 950  7500 1100
Connection ~ 2750 950 
Wire Wire Line
	2750 950  4300 950 
Connection ~ 4300 950 
Wire Wire Line
	6450 950  6450 1100
Connection ~ 6450 950 
Wire Wire Line
	6450 950  7500 950 
Wire Wire Line
	5400 950  5400 1100
Connection ~ 5400 950 
Wire Wire Line
	5400 950  6450 950 
Wire Wire Line
	5400 1800 5400 2000
Wire Wire Line
	5400 2000 6450 2000
Wire Wire Line
	7500 2000 7500 1800
Wire Wire Line
	6450 1800 6450 2000
Connection ~ 6450 2000
Wire Wire Line
	6450 2000 7500 2000
Wire Wire Line
	1300 3150 2750 3150
Wire Wire Line
	4300 3150 4300 2950
Connection ~ 2750 3150
Wire Wire Line
	2750 3150 4300 3150
Wire Wire Line
	5400 2000 5400 3150
Wire Wire Line
	5400 3150 4300 3150
Connection ~ 5400 2000
Connection ~ 4300 3150
Wire Wire Line
	7500 950  9100 950 
Connection ~ 7500 950 
Connection ~ 9100 950 
Wire Wire Line
	9100 950  9950 950 
Wire Wire Line
	7500 2000 9100 2000
Wire Wire Line
	9950 2000 9950 1950
Connection ~ 7500 2000
Wire Wire Line
	9100 1950 9100 2000
Connection ~ 9100 2000
Wire Wire Line
	9100 2000 9950 2000
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 629CBBD2
P 9950 950
F 0 "#FLG0101" H 9950 1025 50  0001 C CNN
F 1 "PWR_FLAG" H 9950 1123 50  0000 C CNN
F 2 "" H 9950 950 50  0001 C CNN
F 3 "~" H 9950 950 50  0001 C CNN
	1    9950 950 
	1    0    0    -1  
$EndComp
Connection ~ 9950 950 
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 629CC1B0
P 9950 2000
F 0 "#FLG0102" H 9950 2075 50  0001 C CNN
F 1 "PWR_FLAG" H 9950 2173 50  0000 C CNN
F 2 "" H 9950 2000 50  0001 C CNN
F 3 "~" H 9950 2000 50  0001 C CNN
	1    9950 2000
	-1   0    0    1   
$EndComp
Connection ~ 9950 2000
$Comp
L power:+5V #PWR0101
U 1 1 629CCB97
P 1300 950
F 0 "#PWR0101" H 1300 800 50  0001 C CNN
F 1 "+5V" H 1315 1123 50  0000 C CNN
F 2 "" H 1300 950 50  0001 C CNN
F 3 "" H 1300 950 50  0001 C CNN
	1    1300 950 
	1    0    0    -1  
$EndComp
Connection ~ 1300 950 
$Comp
L power:GND #PWR0102
U 1 1 629CD076
P 1300 3150
F 0 "#PWR0102" H 1300 2900 50  0001 C CNN
F 1 "GND" H 1305 2977 50  0000 C CNN
F 2 "" H 1300 3150 50  0001 C CNN
F 3 "" H 1300 3150 50  0001 C CNN
	1    1300 3150
	1    0    0    -1  
$EndComp
Connection ~ 1300 3150
Wire Wire Line
	1300 4150 2050 4150
Wire Wire Line
	4300 6100 4300 5750
Connection ~ 2750 6100
Wire Wire Line
	2750 6100 3750 6100
$Comp
L power:+5V #PWR0103
U 1 1 629CEB5D
P 4300 4150
F 0 "#PWR0103" H 4300 4000 50  0001 C CNN
F 1 "+5V" H 4315 4323 50  0000 C CNN
F 2 "" H 4300 4150 50  0001 C CNN
F 3 "" H 4300 4150 50  0001 C CNN
	1    4300 4150
	1    0    0    -1  
$EndComp
Connection ~ 4300 4150
$Comp
L power:GND #PWR0104
U 1 1 629CEFDC
P 4300 6100
F 0 "#PWR0104" H 4300 5850 50  0001 C CNN
F 1 "GND" H 4305 5927 50  0000 C CNN
F 2 "" H 4300 6100 50  0001 C CNN
F 3 "" H 4300 6100 50  0001 C CNN
	1    4300 6100
	1    0    0    -1  
$EndComp
Connection ~ 4300 6100
NoConn ~ 1700 3000
Wire Wire Line
	1700 2100 1800 2100
Entry Wire Line
	1800 2100 1900 2200
Entry Wire Line
	1800 2200 1900 2300
Entry Wire Line
	1800 2300 1900 2400
Entry Wire Line
	1800 2400 1900 2500
Entry Wire Line
	1800 2500 1900 2600
Entry Wire Line
	1800 2600 1900 2700
Entry Wire Line
	1800 2700 1900 2800
Entry Wire Line
	1800 2800 1900 2900
Wire Wire Line
	1700 2200 1800 2200
Wire Wire Line
	1700 2300 1800 2300
Wire Wire Line
	1700 2400 1800 2400
Wire Wire Line
	1700 2500 1800 2500
Wire Wire Line
	1700 2600 1800 2600
Wire Wire Line
	1700 2700 1800 2700
Wire Wire Line
	1700 2800 1800 2800
Text Label 1700 2100 0    50   ~ 0
D7
Text Label 1700 2200 0    50   ~ 0
D6
Text Label 1700 2300 0    50   ~ 0
D5
Text Label 1700 2400 0    50   ~ 0
D4
Text Label 1700 2500 0    50   ~ 0
D3
Text Label 1700 2600 0    50   ~ 0
D2
Text Label 1700 2700 0    50   ~ 0
D1
Text Label 1700 2800 0    50   ~ 0
D0
Wire Wire Line
	3150 1150 3250 1150
Entry Wire Line
	3250 1150 3350 1250
Entry Wire Line
	3250 1250 3350 1350
Entry Wire Line
	3250 1350 3350 1450
Entry Wire Line
	3250 1450 3350 1550
Entry Wire Line
	3250 1550 3350 1650
Entry Wire Line
	3250 1650 3350 1750
Entry Wire Line
	3250 1750 3350 1850
Entry Wire Line
	3250 1850 3350 1950
Wire Wire Line
	3150 1250 3250 1250
Wire Wire Line
	3150 1350 3250 1350
Wire Wire Line
	3150 1450 3250 1450
Wire Wire Line
	3150 1550 3250 1550
Wire Wire Line
	3150 1650 3250 1650
Wire Wire Line
	3150 1750 3250 1750
Wire Wire Line
	3150 1850 3250 1850
Text Label 3150 1150 0    50   ~ 0
D0
Text Label 3150 1250 0    50   ~ 0
D1
Text Label 3150 1350 0    50   ~ 0
D2
Text Label 3150 1450 0    50   ~ 0
D3
Text Label 3150 1550 0    50   ~ 0
D4
Text Label 3150 1650 0    50   ~ 0
D5
Text Label 3150 1750 0    50   ~ 0
D6
Text Label 3150 1850 0    50   ~ 0
D7
Wire Wire Line
	4800 1150 4900 1150
Entry Wire Line
	4900 1150 5000 1250
Entry Wire Line
	4900 1250 5000 1350
Entry Wire Line
	4900 1350 5000 1450
Entry Wire Line
	4900 1450 5000 1550
Entry Wire Line
	4900 1550 5000 1650
Entry Wire Line
	4900 1650 5000 1750
Entry Wire Line
	4900 1750 5000 1850
Entry Wire Line
	4900 1850 5000 1950
Wire Wire Line
	4800 1250 4900 1250
Wire Wire Line
	4800 1350 4900 1350
Wire Wire Line
	4800 1450 4900 1450
Wire Wire Line
	4800 1550 4900 1550
Wire Wire Line
	4800 1650 4900 1650
Wire Wire Line
	4800 1750 4900 1750
Wire Wire Line
	4800 1850 4900 1850
Text Label 4800 1150 0    50   ~ 0
D0
Text Label 4800 1250 0    50   ~ 0
D1
Text Label 4800 1350 0    50   ~ 0
D2
Text Label 4800 1450 0    50   ~ 0
D3
Text Label 4800 1550 0    50   ~ 0
D4
Text Label 4800 1650 0    50   ~ 0
D5
Text Label 4800 1750 0    50   ~ 0
D6
Text Label 4800 1850 0    50   ~ 0
D7
Wire Wire Line
	5900 1100 6000 1100
Entry Wire Line
	6000 1100 6100 1200
Entry Wire Line
	6000 1200 6100 1300
Entry Wire Line
	6000 1300 6100 1400
Entry Wire Line
	6000 1400 6100 1500
Entry Wire Line
	6000 1500 6100 1600
Entry Wire Line
	6000 1600 6100 1700
Entry Wire Line
	6000 1700 6100 1800
Entry Wire Line
	6000 1800 6100 1900
Wire Wire Line
	5900 1200 6000 1200
Wire Wire Line
	5900 1300 6000 1300
Wire Wire Line
	5900 1400 6000 1400
Wire Wire Line
	5900 1500 6000 1500
Wire Wire Line
	5900 1600 6000 1600
Wire Wire Line
	5900 1700 6000 1700
Wire Wire Line
	5900 1800 6000 1800
Text Label 5900 1100 0    50   ~ 0
D0
Text Label 5900 1200 0    50   ~ 0
D1
Text Label 5900 1300 0    50   ~ 0
D2
Text Label 5900 1400 0    50   ~ 0
D3
Text Label 5900 1500 0    50   ~ 0
D4
Text Label 5900 1600 0    50   ~ 0
D5
Text Label 5900 1700 0    50   ~ 0
D6
Text Label 5900 1800 0    50   ~ 0
D7
Wire Wire Line
	6950 1100 7050 1100
Entry Wire Line
	7050 1100 7150 1200
Entry Wire Line
	7050 1200 7150 1300
Entry Wire Line
	7050 1300 7150 1400
Entry Wire Line
	7050 1400 7150 1500
Entry Wire Line
	7050 1500 7150 1600
Entry Wire Line
	7050 1600 7150 1700
Entry Wire Line
	7050 1700 7150 1800
Entry Wire Line
	7050 1800 7150 1900
Wire Wire Line
	6950 1200 7050 1200
Wire Wire Line
	6950 1300 7050 1300
Wire Wire Line
	6950 1400 7050 1400
Wire Wire Line
	6950 1500 7050 1500
Wire Wire Line
	6950 1600 7050 1600
Wire Wire Line
	6950 1700 7050 1700
Wire Wire Line
	6950 1800 7050 1800
Text Label 6950 1100 0    50   ~ 0
D0
Text Label 6950 1200 0    50   ~ 0
D1
Text Label 6950 1300 0    50   ~ 0
D2
Text Label 6950 1400 0    50   ~ 0
D3
Text Label 6950 1500 0    50   ~ 0
D4
Text Label 6950 1600 0    50   ~ 0
D5
Text Label 6950 1700 0    50   ~ 0
D6
Text Label 6950 1800 0    50   ~ 0
D7
Wire Wire Line
	8000 1100 8100 1100
Entry Wire Line
	8100 1100 8200 1200
Entry Wire Line
	8100 1200 8200 1300
Entry Wire Line
	8100 1300 8200 1400
Entry Wire Line
	8100 1400 8200 1500
Entry Wire Line
	8100 1500 8200 1600
Entry Wire Line
	8100 1600 8200 1700
Entry Wire Line
	8100 1700 8200 1800
Entry Wire Line
	8100 1800 8200 1900
Wire Wire Line
	8000 1200 8100 1200
Wire Wire Line
	8000 1300 8100 1300
Wire Wire Line
	8000 1400 8100 1400
Wire Wire Line
	8000 1500 8100 1500
Wire Wire Line
	8000 1600 8100 1600
Wire Wire Line
	8000 1700 8100 1700
Wire Wire Line
	8000 1800 8100 1800
Text Label 8000 1100 0    50   ~ 0
D0
Text Label 8000 1200 0    50   ~ 0
D1
Text Label 8000 1300 0    50   ~ 0
D2
Text Label 8000 1400 0    50   ~ 0
D3
Text Label 8000 1500 0    50   ~ 0
D4
Text Label 8000 1600 0    50   ~ 0
D5
Text Label 8000 1700 0    50   ~ 0
D6
Text Label 8000 1800 0    50   ~ 0
D7
Wire Wire Line
	3800 4450 3700 4450
Entry Wire Line
	3700 4450 3600 4350
Entry Wire Line
	3700 4550 3600 4450
Entry Wire Line
	3700 4650 3600 4550
Entry Wire Line
	3700 4750 3600 4650
Entry Wire Line
	3700 4850 3600 4750
Entry Wire Line
	3700 4950 3600 4850
Entry Wire Line
	3700 5050 3600 4950
Entry Wire Line
	3700 5150 3600 5050
Wire Wire Line
	3800 4550 3700 4550
Wire Wire Line
	3800 4650 3700 4650
Wire Wire Line
	3800 4750 3700 4750
Wire Wire Line
	3800 4850 3700 4850
Wire Wire Line
	3800 4950 3700 4950
Wire Wire Line
	3800 5050 3700 5050
Wire Wire Line
	3800 5150 3700 5150
Text Label 3800 4450 2    50   ~ 0
D0
Text Label 3800 4550 2    50   ~ 0
D1
Text Label 3800 4650 2    50   ~ 0
D2
Text Label 3800 4750 2    50   ~ 0
D3
Text Label 3800 4850 2    50   ~ 0
D4
Text Label 3800 4950 2    50   ~ 0
D5
Text Label 3800 5050 2    50   ~ 0
D6
Text Label 3800 5150 2    50   ~ 0
D7
Wire Wire Line
	800  4450 700  4450
Entry Wire Line
	700  4450 600  4350
Entry Wire Line
	700  4550 600  4450
Entry Wire Line
	700  4650 600  4550
Entry Wire Line
	700  4750 600  4650
Entry Wire Line
	700  4850 600  4750
Entry Wire Line
	700  4950 600  4850
Wire Wire Line
	800  4550 700  4550
Wire Wire Line
	800  4650 700  4650
Wire Wire Line
	800  4750 700  4750
Wire Wire Line
	800  4850 700  4850
Wire Wire Line
	800  4950 700  4950
Text Label 800  4450 2    50   ~ 0
D0
Text Label 800  4550 2    50   ~ 0
D1
Text Label 800  4650 2    50   ~ 0
D2
Text Label 800  4750 2    50   ~ 0
D4
Text Label 800  4850 2    50   ~ 0
D5
Text Label 800  4950 2    50   ~ 0
D7
Wire Bus Line
	5000 1950 6100 1950
Connection ~ 7150 1950
Wire Bus Line
	7150 1950 8200 1950
Connection ~ 6100 1950
Wire Bus Line
	6100 1950 7150 1950
Wire Bus Line
	5000 1950 5000 3200
Wire Bus Line
	5000 3200 3600 3200
Connection ~ 5000 1950
Wire Bus Line
	3350 3200 1900 3200
Connection ~ 3350 3200
Wire Wire Line
	3800 5350 3750 5350
Wire Wire Line
	3750 5350 3750 6100
Connection ~ 3750 6100
Wire Wire Line
	3750 6100 4300 6100
Wire Bus Line
	3600 4100 600  4100
Entry Wire Line
	650  1600 750  1500
Entry Wire Line
	650  1700 750  1600
Entry Wire Line
	650  1800 750  1700
Entry Wire Line
	650  1900 750  1800
Entry Wire Line
	650  2000 750  1900
Entry Wire Line
	650  2100 750  2000
Entry Wire Line
	650  2200 750  2100
Entry Wire Line
	650  2300 750  2200
Entry Wire Line
	650  2400 750  2300
Entry Wire Line
	650  2500 750  2400
Entry Wire Line
	650  2600 750  2500
Entry Wire Line
	650  2700 750  2600
Entry Wire Line
	650  2800 750  2700
Entry Wire Line
	650  2900 750  2800
Wire Wire Line
	750  1500 900  1500
Wire Wire Line
	750  1600 900  1600
Wire Wire Line
	750  1700 900  1700
Wire Wire Line
	750  1800 900  1800
Wire Wire Line
	750  1900 900  1900
Wire Wire Line
	750  2000 900  2000
Wire Wire Line
	750  2100 900  2100
Wire Wire Line
	750  2200 900  2200
Wire Wire Line
	750  2300 900  2300
Wire Wire Line
	750  2400 900  2400
Wire Wire Line
	750  2500 900  2500
Wire Wire Line
	750  2600 900  2600
Wire Wire Line
	750  2700 900  2700
Wire Wire Line
	750  2800 900  2800
Wire Bus Line
	650  3650 2100 3650
Wire Wire Line
	2350 1150 2200 1150
Entry Wire Line
	2100 1250 2200 1150
Entry Wire Line
	2100 1350 2200 1250
Entry Wire Line
	2100 1450 2200 1350
Entry Wire Line
	2100 1550 2200 1450
Entry Wire Line
	2100 1650 2200 1550
Entry Wire Line
	2100 1750 2200 1650
Entry Wire Line
	2100 1850 2200 1750
Entry Wire Line
	2100 1950 2200 1850
Entry Wire Line
	2100 2050 2200 1950
Entry Wire Line
	2100 2150 2200 2050
Entry Wire Line
	2100 2250 2200 2150
Entry Wire Line
	2100 2350 2200 2250
Entry Wire Line
	2100 2450 2200 2350
Entry Wire Line
	2100 2550 2200 2450
Entry Wire Line
	2100 2650 2200 2550
Wire Wire Line
	2200 1250 2350 1250
Wire Wire Line
	2200 1350 2350 1350
Wire Wire Line
	2200 1450 2350 1450
Wire Wire Line
	2200 1550 2350 1550
Wire Wire Line
	2200 1650 2350 1650
Wire Wire Line
	2200 1750 2350 1750
Wire Wire Line
	2200 1850 2350 1850
Wire Wire Line
	2200 1950 2350 1950
Wire Wire Line
	2200 2050 2350 2050
Wire Wire Line
	2200 2150 2350 2150
Wire Wire Line
	2200 2250 2350 2250
Wire Wire Line
	2200 2350 2350 2350
Wire Wire Line
	2200 2450 2350 2450
Wire Wire Line
	2200 2550 2350 2550
Entry Wire Line
	2100 2750 2200 2650
Wire Wire Line
	2200 2650 2350 2650
Text Label 2200 1150 0    50   ~ 0
A0
Text Label 2200 1250 0    50   ~ 0
A1
Text Label 2200 1350 0    50   ~ 0
A2
Text Label 2200 1450 0    50   ~ 0
A3
Text Label 2200 1550 0    50   ~ 0
A4
Text Label 2200 1650 0    50   ~ 0
A5
Text Label 2200 1750 0    50   ~ 0
A6
Text Label 2200 1850 0    50   ~ 0
A7
Text Label 2200 1950 0    50   ~ 0
A8
Text Label 2200 2050 0    50   ~ 0
A9
Text Label 2200 2150 0    50   ~ 0
A10
Text Label 2200 2250 0    50   ~ 0
A11
Text Label 2200 2350 0    50   ~ 0
A12
Text Label 2200 2450 0    50   ~ 0
A13
Text Label 2200 2550 0    50   ~ 0
A14
Text Label 2200 2650 0    50   ~ 0
A15
Wire Wire Line
	3800 1150 3650 1150
Entry Wire Line
	3550 1250 3650 1150
Entry Wire Line
	3550 1350 3650 1250
Entry Wire Line
	3550 1450 3650 1350
Entry Wire Line
	3550 1550 3650 1450
Entry Wire Line
	3550 1650 3650 1550
Entry Wire Line
	3550 1750 3650 1650
Entry Wire Line
	3550 1850 3650 1750
Entry Wire Line
	3550 1950 3650 1850
Entry Wire Line
	3550 2050 3650 1950
Entry Wire Line
	3550 2150 3650 2050
Entry Wire Line
	3550 2250 3650 2150
Entry Wire Line
	3550 2350 3650 2250
Entry Wire Line
	3550 2450 3650 2350
Entry Wire Line
	3550 2550 3650 2450
Entry Wire Line
	3550 2650 3650 2550
Wire Wire Line
	3650 1250 3800 1250
Wire Wire Line
	3650 1350 3800 1350
Wire Wire Line
	3650 1450 3800 1450
Wire Wire Line
	3650 1550 3800 1550
Wire Wire Line
	3650 1650 3800 1650
Wire Wire Line
	3650 1750 3800 1750
Wire Wire Line
	3650 1850 3800 1850
Wire Wire Line
	3650 1950 3800 1950
Wire Wire Line
	3650 2050 3800 2050
Wire Wire Line
	3650 2150 3800 2150
Wire Wire Line
	3650 2250 3800 2250
Wire Wire Line
	3650 2350 3800 2350
Wire Wire Line
	3650 2450 3800 2450
Wire Wire Line
	3650 2550 3800 2550
Entry Wire Line
	3550 2750 3650 2650
Wire Wire Line
	3650 2650 3800 2650
Text Label 3650 1150 0    50   ~ 0
A0
Text Label 3650 1250 0    50   ~ 0
A1
Text Label 3650 1350 0    50   ~ 0
A2
Text Label 3650 1450 0    50   ~ 0
A3
Text Label 3650 1550 0    50   ~ 0
A4
Text Label 3650 1650 0    50   ~ 0
A5
Text Label 3650 1750 0    50   ~ 0
A6
Text Label 3650 1850 0    50   ~ 0
A7
Text Label 3650 1950 0    50   ~ 0
A8
Text Label 3650 2050 0    50   ~ 0
A9
Text Label 3650 2150 0    50   ~ 0
A10
Text Label 3650 2250 0    50   ~ 0
A11
Text Label 3650 2350 0    50   ~ 0
A12
Text Label 3650 2450 0    50   ~ 0
A13
Text Label 3650 2550 0    50   ~ 0
A14
Text Label 3650 2650 0    50   ~ 0
A15
Entry Wire Line
	3550 2850 3650 2750
Wire Wire Line
	3650 2750 3800 2750
Text Label 3650 2750 0    50   ~ 0
A16
Wire Wire Line
	1800 4750 2250 4750
Wire Wire Line
	2250 4750 2250 4600
Wire Wire Line
	1800 4550 2150 4550
Wire Wire Line
	2150 4550 2150 4800
Wire Wire Line
	2150 4800 2250 4800
Wire Wire Line
	1800 4650 2100 4650
Wire Wire Line
	2100 4650 2100 5100
Wire Wire Line
	2100 5100 2250 5100
Wire Wire Line
	2250 5200 2050 5200
Wire Wire Line
	2050 5200 2050 4150
Text Label 1850 4450 0    50   ~ 0
L0
Text Label 1850 4550 0    50   ~ 0
L1
Text Label 1850 4650 0    50   ~ 0
L2
Text Label 1850 4750 0    50   ~ 0
H0
Text Label 1850 4850 0    50   ~ 0
H1
Text Label 1800 4950 0    50   ~ 0
~ROM
Wire Wire Line
	900  3000 550  3000
Wire Wire Line
	550  5350 800  5350
Wire Wire Line
	550  3000 550  5350
Text Label 550  4050 0    50   ~ 0
~RESET
Wire Wire Line
	3250 4500 3450 4500
Entry Wire Line
	3450 4500 3550 4400
Entry Wire Line
	3450 4800 3550 4700
Entry Wire Line
	3450 5100 3550 5000
NoConn ~ 3250 5400
Wire Wire Line
	2200 5400 2200 5500
Wire Wire Line
	2200 6100 2750 6100
Wire Wire Line
	2200 5800 2250 5800
Connection ~ 2200 5800
Wire Wire Line
	2200 5800 2200 6100
Wire Wire Line
	2250 5400 2200 5400
Wire Wire Line
	2200 5500 2250 5500
Connection ~ 2200 5500
Wire Wire Line
	2200 5500 2200 5800
Wire Wire Line
	3250 4800 3450 4800
Wire Wire Line
	3250 5100 3450 5100
Text Label 3250 4500 0    50   ~ 0
A14
Text Label 3250 4800 0    50   ~ 0
A15
Text Label 3250 5100 0    50   ~ 0
A16
Wire Bus Line
	3550 3650 2100 3650
Connection ~ 2100 3650
Connection ~ 3550 3650
Text Label 4800 4450 0    50   ~ 0
L0
Text Label 4800 4550 0    50   ~ 0
L1
Text Label 4800 4650 0    50   ~ 0
L2
Text Label 4800 4850 0    50   ~ 0
H0
Text Label 4800 4950 0    50   ~ 0
H1
Text Label 4800 5150 0    50   ~ 0
~ROM
Wire Wire Line
	4800 4750 5000 4750
Wire Wire Line
	5000 4750 5000 6100
Wire Wire Line
	5000 6100 4300 6100
Wire Wire Line
	4800 5050 4950 5050
Wire Wire Line
	4950 5050 4950 4150
Wire Wire Line
	4950 4150 4300 4150
Text Label 900  1400 2    50   ~ 0
CA14
Wire Wire Line
	900  1400 500  1400
Wire Wire Line
	500  1400 500  3850
Connection ~ 2200 6100
Wire Wire Line
	1300 6100 2200 6100
Wire Wire Line
	1300 5650 1300 6100
Wire Wire Line
	2750 4200 2750 4150
Wire Wire Line
	2750 4150 2050 4150
Connection ~ 2050 4150
Wire Wire Line
	2750 4150 4300 4150
Connection ~ 2750 4150
Wire Wire Line
	2250 4850 2250 4900
Wire Wire Line
	1800 4850 2250 4850
Wire Wire Line
	1800 4450 2250 4450
Wire Wire Line
	2250 4450 2250 4500
Wire Wire Line
	2250 5700 500  5700
Text Label 1900 5700 0    50   ~ 0
CA14
Wire Wire Line
	5400 1200 5250 1200
Entry Wire Line
	5150 1300 5250 1200
Entry Wire Line
	5150 1400 5250 1300
Entry Wire Line
	5150 1500 5250 1400
Entry Wire Line
	5150 1600 5250 1500
Wire Wire Line
	5250 1300 5400 1300
Wire Wire Line
	5250 1400 5400 1400
Wire Wire Line
	5250 1500 5400 1500
Text Label 5250 1200 0    50   ~ 0
A0
Text Label 5250 1300 0    50   ~ 0
A1
Text Label 5250 1400 0    50   ~ 0
A2
Text Label 5250 1500 0    50   ~ 0
A3
Wire Wire Line
	6450 1200 6300 1200
Entry Wire Line
	6200 1300 6300 1200
Entry Wire Line
	6200 1400 6300 1300
Entry Wire Line
	6200 1500 6300 1400
Entry Wire Line
	6200 1600 6300 1500
Wire Wire Line
	6300 1300 6450 1300
Wire Wire Line
	6300 1400 6450 1400
Wire Wire Line
	6300 1500 6450 1500
Text Label 6300 1200 0    50   ~ 0
A0
Text Label 6300 1300 0    50   ~ 0
A1
Text Label 6300 1400 0    50   ~ 0
A2
Text Label 6300 1500 0    50   ~ 0
A3
Wire Wire Line
	7500 1200 7350 1200
Entry Wire Line
	7250 1300 7350 1200
Entry Wire Line
	7250 1400 7350 1300
Entry Wire Line
	7250 1500 7350 1400
Entry Wire Line
	7250 1600 7350 1500
Wire Wire Line
	7350 1300 7500 1300
Wire Wire Line
	7350 1400 7500 1400
Wire Wire Line
	7350 1500 7500 1500
Text Label 7350 1200 0    50   ~ 0
A0
Text Label 7350 1300 0    50   ~ 0
A1
Text Label 7350 1400 0    50   ~ 0
A2
Text Label 7350 1500 0    50   ~ 0
A3
Wire Bus Line
	5150 3650 3550 3650
Wire Bus Line
	5150 2050 6200 2050
Connection ~ 5150 2050
Wire Bus Line
	5150 2050 5150 3650
Connection ~ 6200 2050
Wire Bus Line
	6200 2050 7250 2050
Text Label 900  850  1    50   ~ 0
~WE
Text Label 800  1000 1    50   ~ 0
~IOCART
Text Label 5350 850  1    50   ~ 0
~WE
Text Label 6400 1650 1    50   ~ 0
~WE
Text Label 7450 1650 1    50   ~ 0
~WE
Wire Wire Line
	8500 2650 8650 2650
Entry Wire Line
	8650 2650 8750 2550
Entry Wire Line
	8650 2750 8750 2650
Wire Wire Line
	8500 2750 8650 2750
Text Label 8500 2650 0    50   ~ 0
A5
Text Label 8500 2750 0    50   ~ 0
A4
Wire Bus Line
	7250 2050 8750 2050
Connection ~ 7250 2050
Wire Wire Line
	8500 2950 8800 2950
Wire Wire Line
	8800 2950 8800 3650
Wire Wire Line
	8800 3650 8500 3650
Text Label 8800 3250 1    50   ~ 0
~IOCART
Wire Wire Line
	5400 1700 5300 1700
Wire Wire Line
	5300 1700 5300 2650
Wire Wire Line
	5300 2650 7500 2650
Wire Wire Line
	6450 1700 6350 1700
Wire Wire Line
	6350 1700 6350 2750
Wire Wire Line
	6350 2750 7500 2750
Wire Wire Line
	7500 1700 7400 1700
Wire Wire Line
	7400 1700 7400 2850
Wire Wire Line
	7400 2850 7500 2850
Text Label 5300 2550 1    50   ~ 0
~IOC
Text Label 6350 2550 1    50   ~ 0
~IOD
Text Label 7400 2550 1    50   ~ 0
~IOE
Wire Wire Line
	7500 2950 7500 3150
Wire Wire Line
	7500 3150 8500 3150
Text Label 7800 3150 0    50   ~ 0
~IOF
Text Label 8550 3450 0    50   ~ 0
~WE
Wire Wire Line
	5400 1600 5350 1600
Wire Wire Line
	5350 3200 6400 3200
Wire Wire Line
	6450 1600 6400 1600
Wire Wire Line
	6400 1600 6400 3200
Wire Wire Line
	8500 3150 8500 3350
Wire Wire Line
	7500 1600 7450 1600
Wire Wire Line
	7450 1600 7450 3200
Wire Wire Line
	7450 3200 6400 3200
Connection ~ 6400 3200
Wire Wire Line
	7450 3200 8550 3200
Wire Wire Line
	8550 3200 8550 3450
Connection ~ 7450 3200
Wire Wire Line
	8500 3450 8550 3450
NoConn ~ 7500 3550
NoConn ~ 7500 3650
Wire Bus Line
	3600 4100 3600 3200
Connection ~ 3600 4100
Connection ~ 3600 3200
Wire Bus Line
	3600 3200 3350 3200
Text Label 7450 3350 2    50   ~ 0
~BSET
Text Label 7450 3450 2    50   ~ 0
~BRD
Wire Wire Line
	1700 1900 1950 1900
Wire Wire Line
	1950 1900 1950 3250
Wire Wire Line
	1950 3250 2350 3250
Wire Wire Line
	4900 3250 4900 2250
Wire Wire Line
	4900 2250 4800 2250
Wire Wire Line
	2350 2950 2350 3250
Connection ~ 2350 3250
Wire Wire Line
	2350 3250 4900 3250
Wire Wire Line
	4800 2150 5050 2150
Text Label 750  1500 0    50   ~ 0
A13
Text Label 750  1600 0    50   ~ 0
A12
Text Label 750  1700 0    50   ~ 0
A11
Text Label 750  1800 0    50   ~ 0
A10
Text Label 750  1900 0    50   ~ 0
A9
Text Label 750  2000 0    50   ~ 0
A8
Text Label 750  2100 0    50   ~ 0
A7
Text Label 750  2200 0    50   ~ 0
A6
Text Label 750  2300 0    50   ~ 0
A5
Text Label 750  2400 0    50   ~ 0
A4
Text Label 750  2500 0    50   ~ 0
A3
Text Label 750  2600 0    50   ~ 0
A2
Text Label 750  2700 0    50   ~ 0
A1
Text Label 750  2800 0    50   ~ 0
A0
Wire Wire Line
	900  1150 900  700 
Wire Wire Line
	900  700  5350 700 
Wire Wire Line
	5350 700  5350 1600
Connection ~ 5350 1600
Wire Wire Line
	7500 3350 5200 3350
Wire Wire Line
	750  6350 750  5150
Wire Wire Line
	750  5150 800  5150
Text Label 800  6350 0    50   ~ 0
~BSET
Wire Wire Line
	5200 6350 750  6350
Wire Wire Line
	5200 3350 5200 6350
Wire Wire Line
	7500 3450 5250 3450
Wire Wire Line
	5250 3450 5250 6400
Wire Wire Line
	5250 6400 3800 6400
Wire Wire Line
	3800 6400 3800 5450
Text Label 3800 5850 0    50   ~ 0
~BRD
Text Label 1750 1900 0    50   ~ 0
~OE
Wire Wire Line
	1700 1800 2000 1800
Wire Wire Line
	2000 1800 2000 3700
Wire Wire Line
	2000 3700 4950 3700
Wire Wire Line
	5150 3700 5150 4800
Wire Wire Line
	5550 4800 5150 4800
Connection ~ 5150 4800
Wire Wire Line
	5150 4800 5150 5500
Text Label 1750 1800 0    50   ~ 0
~CS
Text Label 5550 4800 2    50   ~ 0
~CS
Text Label 5550 5500 2    50   ~ 0
~CS
Wire Wire Line
	5550 4500 5100 4500
Wire Wire Line
	5100 4500 5100 5300
Wire Wire Line
	5100 5300 5550 5300
Wire Wire Line
	500  3850 5100 3850
Wire Wire Line
	5100 3850 5100 4500
Connection ~ 500  3850
Wire Wire Line
	500  3850 500  5700
Connection ~ 5100 4500
Text Label 5550 4500 2    50   ~ 0
CA14
Wire Wire Line
	4800 2050 4950 2050
Wire Wire Line
	4950 2050 4950 3700
Connection ~ 4950 3700
Wire Wire Line
	4950 3700 5150 3700
Text Label 4950 3500 1    50   ~ 0
~CS
Text Label 4900 3050 1    50   ~ 0
~OE
Wire Wire Line
	1800 4950 1800 6450
Wire Wire Line
	5300 5200 5550 5200
Wire Wire Line
	5150 5500 5550 5500
Wire Wire Line
	5300 6450 5300 5200
Wire Wire Line
	1800 6450 5300 6450
Text Label 5550 5300 2    50   ~ 0
CA14
Text Label 5550 5200 2    50   ~ 0
~ROM
NoConn ~ 6550 5200
NoConn ~ 6550 5500
NoConn ~ 6550 5400
Text Label 5400 3900 0    50   ~ 0
~ROMSEL
Wire Wire Line
	5350 3200 5350 4600
Wire Wire Line
	5350 4600 5550 4600
Connection ~ 5350 3200
Text Label 5550 4600 2    50   ~ 0
~WE
NoConn ~ 6550 4600
NoConn ~ 6550 4700
NoConn ~ 6550 4800
Text Label 5500 2350 0    50   ~ 0
~RAMWR
Wire Wire Line
	5350 1600 5350 3200
Wire Wire Line
	4800 2350 6550 2350
Wire Wire Line
	6550 2350 6550 4500
Text Label 6550 4350 1    50   ~ 0
~RAMWR
Wire Wire Line
	2350 2850 2300 2850
Wire Wire Line
	2300 2850 2300 3900
Wire Wire Line
	2300 3900 5050 3900
Wire Wire Line
	6600 3900 6600 5300
Wire Wire Line
	6600 5300 6550 5300
Text Label 2300 3600 1    50   ~ 0
~ROMSEL
Text Label 6600 5300 0    50   ~ 0
~ROMSEL
Wire Wire Line
	900  1250 800  1250
Wire Wire Line
	800  1250 800  650 
Wire Wire Line
	800  650  8800 650 
Wire Wire Line
	8800 650  8800 2950
Connection ~ 8800 2950
Wire Wire Line
	5300 5200 5300 5150
Wire Wire Line
	5300 5150 4800 5150
Connection ~ 5300 5200
Text Label 600  3850 0    50   ~ 0
CA14
Wire Wire Line
	4300 950  5400 950 
Wire Wire Line
	5050 2150 5050 3900
Connection ~ 5050 3900
Wire Wire Line
	5050 3900 6600 3900
Wire Wire Line
	1700 1300 1700 600 
Wire Wire Line
	1700 600  5900 600 
Wire Bus Line
	8750 2050 8750 2650
Wire Bus Line
	3550 3650 3550 5000
Wire Bus Line
	7250 1300 7250 2050
Wire Bus Line
	6200 1300 6200 2050
Wire Bus Line
	5150 1300 5150 2050
Wire Bus Line
	5000 1250 5000 1950
Wire Bus Line
	600  4100 600  4850
Wire Bus Line
	3600 4100 3600 5050
Wire Bus Line
	8200 1200 8200 1950
Wire Bus Line
	7150 1200 7150 1950
Wire Bus Line
	6100 1200 6100 1950
Wire Bus Line
	3350 1250 3350 3200
Wire Bus Line
	1900 2200 1900 3200
Wire Bus Line
	650  1600 650  3650
Wire Bus Line
	3550 1250 3550 3650
Wire Bus Line
	2100 1250 2100 3650
$Comp
L Connector_Generic:Conn_01x01 J7
U 1 1 6367BB9C
P 8000 800
F 0 "J7" V 8000 950 50  0000 L CNN
F 1 "AUDIO E" V 8100 850 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x01_P2.54mm_Vertical" H 8000 800 50  0001 C CNN
F 3 "~" H 8000 800 50  0001 C CNN
	1    8000 800 
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J6
U 1 1 6367C3A8
P 6950 800
F 0 "J6" V 6950 950 50  0000 L CNN
F 1 "AUDIO D" V 7050 850 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x01_P2.54mm_Vertical" H 6950 800 50  0001 C CNN
F 3 "~" H 6950 800 50  0001 C CNN
	1    6950 800 
	0    1    1    0   
$EndComp
Connection ~ 6950 600 
Wire Wire Line
	6950 600  8000 600 
$Comp
L Connector_Generic:Conn_01x01 J5
U 1 1 6367C998
P 5900 800
F 0 "J5" V 5900 950 50  0000 L CNN
F 1 "AUDIO C" V 6000 850 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x01_P2.54mm_Vertical" H 5900 800 50  0001 C CNN
F 3 "~" H 5900 800 50  0001 C CNN
	1    5900 800 
	0    1    1    0   
$EndComp
Connection ~ 5900 600 
Wire Wire Line
	5900 600  6950 600 
$EndSCHEMATC
