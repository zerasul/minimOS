EESchema Schematic File Version 4
LIBS:nes-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "NES-controller for Durango-X"
Date "2022-03-27"
Rev "1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74xx:74LS139 U1
U 1 1 6240ABEF
P 2800 2400
F 0 "U1" H 2800 2767 50  0000 C CNN
F 1 "74HC139" H 2800 2676 50  0000 C CNN
F 2 "" H 2800 2400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 2800 2400 50  0001 C CNN
	1    2800 2400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U1
U 2 1 6240B2D4
P 2800 3000
F 0 "U1" H 2800 2650 50  0000 C CNN
F 1 "74HC139" H 2800 2550 50  0000 C CNN
F 2 "" H 2800 3000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 2800 3000 50  0001 C CNN
	2    2800 3000
	1    0    0    -1  
$EndComp
Text Label 2150 2400 2    50   ~ 0
PA0
Text Label 2300 2300 2    50   ~ 0
R~W
Text Label 3300 2300 0    50   ~ 0
CL0
Text Label 3300 2600 0    50   ~ 0
DAT1
Text Label 2300 3200 3    50   ~ 0
~IO9
Text Label 2450 2750 2    50   ~ 0
~NES
Text Label 2300 3000 2    50   ~ 0
HSEL
Text Label 2150 3200 2    50   ~ 0
PA1
Text Label 3450 3000 0    50   ~ 0
~NES
NoConn ~ 3300 2900
NoConn ~ 3300 3200
Wire Wire Line
	3300 3000 3450 3000
Wire Wire Line
	3450 3000 3450 2750
Wire Wire Line
	3450 2750 2300 2750
Wire Wire Line
	2300 2750 2300 2600
Text Label 3300 2500 0    50   ~ 0
CL1
Text Label 3300 2400 0    50   ~ 0
DAT0
$Comp
L 74xx:74LS125 U2
U 1 1 62413B67
P 4050 3500
F 0 "U2" V 4100 3200 50  0000 L CNN
F 1 "74HC125" V 4200 3100 50  0000 L CNN
F 2 "" H 4050 3500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS125" H 4050 3500 50  0001 C CNN
	1    4050 3500
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_2Rows-07Pins J1
U 1 1 624170B7
P 4150 2450
F 0 "J1" V 4246 2162 50  0000 R CNN
F 1 "NES 0" V 4155 2162 50  0000 R CNN
F 2 "" H 4150 2450 50  0001 C CNN
F 3 "~" H 4150 2450 50  0001 C CNN
	1    4150 2450
	0    -1   -1   0   
$EndComp
NoConn ~ 4050 2150
NoConn ~ 4150 2150
$Comp
L Connector_Generic:Conn_2Rows-07Pins J2
U 1 1 62418766
P 5000 2450
F 0 "J2" V 5096 2162 50  0000 R CNN
F 1 "NES 1" V 5005 2162 50  0000 R CNN
F 2 "" H 5000 2450 50  0001 C CNN
F 3 "~" H 5000 2450 50  0001 C CNN
	1    5000 2450
	0    -1   -1   0   
$EndComp
NoConn ~ 4900 2150
NoConn ~ 5000 2150
$Comp
L power:+5V #PWR0101
U 1 1 6241C2BB
P 5100 2150
F 0 "#PWR0101" H 5100 2000 50  0001 C CNN
F 1 "+5V" H 5115 2323 50  0000 C CNN
F 2 "" H 5100 2150 50  0001 C CNN
F 3 "" H 5100 2150 50  0001 C CNN
	1    5100 2150
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0102
U 1 1 6241C45F
P 4250 2150
F 0 "#PWR0102" H 4250 2000 50  0001 C CNN
F 1 "+5V" H 4265 2323 50  0000 C CNN
F 2 "" H 4250 2150 50  0001 C CNN
F 3 "" H 4250 2150 50  0001 C CNN
	1    4250 2150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 6241C6CE
P 5200 2650
F 0 "#PWR0103" H 5200 2400 50  0001 C CNN
F 1 "GND" H 5205 2477 50  0000 C CNN
F 2 "" H 5200 2650 50  0001 C CNN
F 3 "" H 5200 2650 50  0001 C CNN
	1    5200 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 6241C882
P 4350 2650
F 0 "#PWR0104" H 4350 2400 50  0001 C CNN
F 1 "GND" H 4355 2477 50  0000 C CNN
F 2 "" H 4350 2650 50  0001 C CNN
F 3 "" H 4350 2650 50  0001 C CNN
	1    4350 2650
	1    0    0    -1  
$EndComp
Text Label 4050 2650 3    50   ~ 0
NES0D
Text Label 4150 2650 3    50   ~ 0
NES0L
Text Label 4250 2650 3    50   ~ 0
NES0C
Text Label 4900 2650 3    50   ~ 0
NES1D
Text Label 5000 2650 3    50   ~ 0
NES1L
Text Label 5100 2650 3    50   ~ 0
NES1C
$Comp
L 74xx:74LS125 U2
U 2 1 6241F0AC
P 4900 3500
F 0 "U2" V 4950 3200 50  0000 L CNN
F 1 "74HC125" V 5050 3100 50  0000 L CNN
F 2 "" H 4900 3500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS125" H 4900 3500 50  0001 C CNN
	2    4900 3500
	0    1    1    0   
$EndComp
Wire Wire Line
	4900 3800 4050 3800
Text Label 4050 3800 0    50   ~ 0
PD7
Wire Wire Line
	4050 3200 4050 2650
Wire Wire Line
	4900 3200 4900 2650
Wire Wire Line
	4150 2650 4150 2950
Wire Wire Line
	4150 2950 5000 2950
Wire Wire Line
	5000 2950 5000 2650
Wire Wire Line
	4250 2650 4250 3050
Wire Wire Line
	4250 3050 5100 3050
Wire Wire Line
	5100 3050 5100 2650
NoConn ~ 3300 3100
Wire Wire Line
	3800 3500 3800 2400
Wire Wire Line
	3800 2400 3300 2400
Wire Wire Line
	3300 2600 3850 2600
Wire Wire Line
	3850 2600 3850 3150
Wire Wire Line
	3850 3150 4650 3150
Wire Wire Line
	4650 3150 4650 3500
$Comp
L 74xx:74LS125 U2
U 4 1 624237C4
P 6250 3700
F 0 "U2" V 6400 3900 50  0000 L CNN
F 1 "74HC125" V 6300 3800 50  0000 L CNN
F 2 "" H 6250 3700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS125" H 6250 3700 50  0001 C CNN
	4    6250 3700
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS125 U2
U 3 1 62420C91
P 5450 3700
F 0 "U2" V 5600 3900 50  0000 L CNN
F 1 "74HC125" V 5500 3800 50  0000 L CNN
F 2 "" H 5450 3700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS125" H 5450 3700 50  0001 C CNN
	3    5450 3700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5450 3400 5450 3050
Wire Wire Line
	5450 3050 5100 3050
Connection ~ 5100 3050
Wire Wire Line
	5000 2950 6250 2950
Wire Wire Line
	6250 2950 6250 3400
Connection ~ 5000 2950
Text Label 6250 4000 3    50   ~ 0
PD1
Text Label 5450 4000 3    50   ~ 0
PD0
Wire Wire Line
	5700 3700 5700 3350
Wire Wire Line
	5700 3350 6500 3350
Wire Wire Line
	6500 3350 6500 3700
$Comp
L 74xx:74LS08 U3
U 1 1 6242F68F
P 1800 3000
F 0 "U3" H 1800 3325 50  0000 C CNN
F 1 "74HC08" H 1800 3234 50  0000 C CNN
F 2 "" H 1800 3000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 1800 3000 50  0001 C CNN
	1    1800 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 3000 2300 3000
$Comp
L 74xx:74LS08 U3
U 2 1 6243906B
P 3850 1900
F 0 "U3" H 3850 2225 50  0000 C CNN
F 1 "74HC08" H 3850 2134 50  0000 C CNN
F 2 "" H 3850 1900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 3850 1900 50  0001 C CNN
	2    3850 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 2000 3550 2500
Wire Wire Line
	3550 2500 3300 2500
Wire Wire Line
	3300 2300 3500 2300
Wire Wire Line
	3500 2300 3500 1800
Wire Wire Line
	3500 1800 3550 1800
Wire Wire Line
	4150 1900 6500 1900
Wire Wire Line
	6500 1900 6500 3350
Connection ~ 6500 3350
Text Label 4150 1900 0    50   ~ 0
CLK-STB
$Comp
L Connector_Generic:Conn_02x08_Odd_Even J3
U 1 1 624873B1
P 2000 3800
F 0 "J3" V 2000 4250 50  0000 C CNN
F 1 "IOx" V 2100 4250 50  0000 C CNN
F 2 "" H 2000 3800 50  0001 C CNN
F 3 "~" H 2000 3800 50  0001 C CNN
	1    2000 3800
	0    -1   1    0   
$EndComp
Wire Wire Line
	6250 4150 6250 4000
Text Label 1500 3100 2    50   ~ 0
PA3
Text Label 1500 2900 2    50   ~ 0
PA2
Wire Wire Line
	2300 3200 2300 3600
Wire Wire Line
	2300 2300 2200 2300
Wire Wire Line
	2200 2300 2200 3600
Wire Wire Line
	2300 2900 2150 2900
Wire Wire Line
	2150 2900 2150 3200
Wire Wire Line
	2150 3200 1900 3200
Wire Wire Line
	1900 3200 1900 3600
Wire Wire Line
	1500 3100 1500 3250
Wire Wire Line
	1500 3250 2100 3250
Wire Wire Line
	2100 3250 2100 3600
Wire Wire Line
	1500 2900 1350 2900
Wire Wire Line
	1350 2900 1350 3300
Wire Wire Line
	1350 3300 2000 3300
Wire Wire Line
	2000 3300 2000 3600
Wire Wire Line
	1800 3600 1800 3350
Wire Wire Line
	1800 3350 1250 3350
Wire Wire Line
	1250 3350 1250 2400
Wire Wire Line
	1250 2400 2300 2400
$Comp
L power:GND #PWR0105
U 1 1 624F5B55
P 2400 3600
F 0 "#PWR0105" H 2400 3350 50  0001 C CNN
F 1 "GND" V 2405 3472 50  0000 R CNN
F 2 "" H 2400 3600 50  0001 C CNN
F 3 "" H 2400 3600 50  0001 C CNN
	1    2400 3600
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0106
U 1 1 624F5FAB
P 1700 3600
F 0 "#PWR0106" H 1700 3450 50  0001 C CNN
F 1 "+5V" H 1715 3773 50  0000 C CNN
F 2 "" H 1700 3600 50  0001 C CNN
F 3 "" H 1700 3600 50  0001 C CNN
	1    1700 3600
	1    0    0    -1  
$EndComp
NoConn ~ 1900 4100
NoConn ~ 2000 4100
NoConn ~ 2100 4100
NoConn ~ 2200 4100
NoConn ~ 2300 4100
Wire Wire Line
	2400 4100 4050 4100
Wire Wire Line
	4050 4100 4050 3800
Connection ~ 4050 3800
Wire Wire Line
	6250 4150 1800 4150
Wire Wire Line
	1800 4150 1800 4100
Wire Wire Line
	1700 4100 1700 4200
Wire Wire Line
	1700 4200 5450 4200
Wire Wire Line
	5450 4200 5450 4000
$Comp
L 74xx:74LS08 U3
U 3 1 624FF70B
P 3350 5150
F 0 "U3" V 3396 4970 50  0000 R CNN
F 1 "74HC08" V 3305 4970 50  0000 R CNN
F 2 "" H 3350 5150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 3350 5150 50  0001 C CNN
	3    3350 5150
	0    -1   -1   0   
$EndComp
$Comp
L 74xx:74LS08 U3
U 4 1 625049E8
P 4000 5150
F 0 "U3" V 4046 4970 50  0000 R CNN
F 1 "74HC08" V 3955 4970 50  0000 R CNN
F 2 "" H 4000 5150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 4000 5150 50  0001 C CNN
	4    4000 5150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3250 5450 3450 5450
Connection ~ 3450 5450
Connection ~ 3900 5450
Wire Wire Line
	3900 5450 4100 5450
$Comp
L power:GND #PWR0107
U 1 1 625084F8
P 4700 5450
F 0 "#PWR0107" H 4700 5200 50  0001 C CNN
F 1 "GND" H 4705 5277 50  0000 C CNN
F 2 "" H 4700 5450 50  0001 C CNN
F 3 "" H 4700 5450 50  0001 C CNN
	1    4700 5450
	1    0    0    -1  
$EndComp
NoConn ~ 3350 4850
NoConn ~ 4000 4850
$Comp
L 74xx:74LS08 U3
U 5 1 6250B3EA
P 4700 4950
F 0 "U3" H 4930 4996 50  0000 L CNN
F 1 "74HC08" H 4930 4905 50  0000 L CNN
F 2 "" H 4700 4950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 4700 4950 50  0001 C CNN
	5    4700 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 5450 4700 5450
Connection ~ 4100 5450
$Comp
L power:+5V #PWR0108
U 1 1 6251736A
P 4700 4450
F 0 "#PWR0108" H 4700 4300 50  0001 C CNN
F 1 "+5V" H 4715 4623 50  0000 C CNN
F 2 "" H 4700 4450 50  0001 C CNN
F 3 "" H 4700 4450 50  0001 C CNN
	1    4700 4450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS125 U2
U 5 1 6251E94E
P 5500 4950
F 0 "U2" H 5730 4996 50  0000 L CNN
F 1 "74HC125" H 5730 4905 50  0000 L CNN
F 2 "" H 5500 4950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS125" H 5500 4950 50  0001 C CNN
	5    5500 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 5450 5500 5450
Connection ~ 4700 5450
Wire Wire Line
	5500 4450 4700 4450
Connection ~ 4700 4450
Wire Wire Line
	3450 5450 3900 5450
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 6252467A
P 5500 4450
F 0 "#FLG0101" H 5500 4525 50  0001 C CNN
F 1 "PWR_FLAG" H 5500 4623 50  0000 C CNN
F 2 "" H 5500 4450 50  0001 C CNN
F 3 "~" H 5500 4450 50  0001 C CNN
	1    5500 4450
	1    0    0    -1  
$EndComp
Connection ~ 5500 4450
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 62524E07
P 5500 5450
F 0 "#FLG0102" H 5500 5525 50  0001 C CNN
F 1 "PWR_FLAG" H 5500 5623 50  0000 C CNN
F 2 "" H 5500 5450 50  0001 C CNN
F 3 "~" H 5500 5450 50  0001 C CNN
	1    5500 5450
	-1   0    0    1   
$EndComp
Connection ~ 5500 5450
$EndSCHEMATC
