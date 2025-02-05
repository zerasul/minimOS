EESchema Schematic File Version 4
LIBS:full-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 3
Title "Durango-X power & extra features"
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR0111
U 1 1 6315BD20
P 1350 1300
F 0 "#PWR0111" H 1350 1050 50  0001 C CNN
F 1 "GND" H 1355 1127 50  0000 C CNN
F 2 "" H 1350 1300 50  0001 C CNN
F 3 "" H 1350 1300 50  0001 C CNN
	1    1350 1300
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C6
U 1 1 6315BFF0
P 1350 1150
F 0 "C6" H 1400 1250 50  0000 L CNN
F 1 "470uF" H 1350 1050 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 1388 1000 50  0001 C CNN
F 3 "~" H 1350 1150 50  0001 C CNN
	1    1350 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	850  1300 950  1300
Connection ~ 1350 1300
$Comp
L power:+5V #PWR0153
U 1 1 6315CF6B
P 1700 650
F 0 "#PWR0153" H 1700 500 50  0001 C CNN
F 1 "+5V" H 1800 750 50  0000 C CNN
F 2 "" H 1700 650 50  0001 C CNN
F 3 "" H 1700 650 50  0001 C CNN
	1    1700 650 
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 6315D0B4
P 1700 1150
F 0 "C7" H 1750 1250 50  0000 L CNN
F 1 "100nF" H 1700 1050 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 1738 1000 50  0001 C CNN
F 3 "~" H 1700 1150 50  0001 C CNN
	1    1700 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 1000 1700 1000
Wire Wire Line
	1350 1300 1700 1300
$Comp
L 74xx:74LS20 U17
U 3 1 6318F3D4
P 4850 1150
F 0 "U17" H 4850 1600 50  0000 L CNN
F 1 "74HC21" H 4850 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 4850 1150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS20" H 4850 1150 50  0001 C CNN
	3    4850 1150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT02 U16
U 5 1 63193401
P 4400 1150
F 0 "U16" H 4400 1600 50  0000 L CNN
F 1 "74HC02" H 4400 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 4400 1150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hct02" H 4400 1150 50  0001 C CNN
	5    4400 1150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS132 U8
U 5 1 63199332
P 2150 1150
F 0 "U8" H 2150 1600 50  0000 L CNN
F 1 "74HC132" H 2150 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 2150 1150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS132" H 2150 1150 50  0001 C CNN
	5    2150 1150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT00 U9
U 5 1 631D9308
P 2600 1150
F 0 "U9" H 2600 1600 50  0000 L CNN
F 1 "74HC00" H 2600 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 2600 1150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hct00" H 2600 1150 50  0001 C CNN
	5    2600 1150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC74 U12
U 3 1 631DC617
P 3500 1150
F 0 "U12" H 3500 1600 50  0000 L CNN
F 1 "74HC74" H 3500 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 3500 1150 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 3500 1150 50  0001 C CNN
	3    3500 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 1000 1700 650 
Connection ~ 1700 1000
Wire Wire Line
	1700 1300 1700 1650
Connection ~ 1700 1300
$Comp
L 74xx:74HC86 U23
U 5 1 61BA3670
P 5300 1150
F 0 "U23" H 5300 1600 50  0000 L CNN
F 1 "74HC86" H 5300 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 5300 1150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 5300 1150 50  0001 C CNN
	5    5300 1150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U13
U 5 1 61BAB9F2
P 3950 1150
F 0 "U13" H 3950 1600 50  0000 L CNN
F 1 "74HC32" H 3950 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 3950 1150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 3950 1150 50  0001 C CNN
	5    3950 1150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC86 U126
U 5 1 61BC27C7
P 5750 1150
F 0 "U126" H 5750 1600 50  0000 L CNN
F 1 "HC86" H 5750 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 5750 1150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 5750 1150 50  0001 C CNN
	5    5750 1150
	1    0    0    -1  
$EndComp
Text GLabel 900  2150 1    50   Input ~ 0
D[0..7]
Text GLabel 750  2150 1    50   Input ~ 0
A[0..15]
$Comp
L Connector_Generic:Conn_01x17 J8
U 1 1 60AD9E5D
P 1550 2850
F 0 "J8" H 1630 2842 50  0000 L CNN
F 1 "DEBUG" H 1630 2751 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x17_P2.54mm_Vertical" H 1550 2850 50  0001 C CNN
F 3 "~" H 1550 2850 50  0001 C CNN
	1    1550 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	850  3250 1350 3250
Wire Wire Line
	850  3350 1350 3350
Wire Wire Line
	1000 3150 1350 3150
Wire Wire Line
	1000 3050 1350 3050
Wire Wire Line
	1000 2950 1350 2950
Wire Wire Line
	1000 2850 1350 2850
Wire Wire Line
	1000 2750 1350 2750
Wire Wire Line
	1000 2650 1350 2650
Wire Wire Line
	1000 2550 1350 2550
Wire Wire Line
	1000 2450 1350 2450
Text Label 1200 2450 0    50   ~ 0
D0
Text Label 1200 2550 0    50   ~ 0
D1
Text Label 1200 2650 0    50   ~ 0
D2
Text Label 1200 2750 0    50   ~ 0
D3
Text Label 1200 2850 0    50   ~ 0
D4
Text Label 1200 2950 0    50   ~ 0
D5
Text Label 1200 3050 0    50   ~ 0
D6
Text Label 1200 3150 0    50   ~ 0
D7
Text Label 1200 3250 0    50   ~ 0
A15
Text Label 1200 3350 0    50   ~ 0
A14
Entry Wire Line
	750  3150 850  3250
Entry Wire Line
	750  3250 850  3350
Entry Wire Line
	900  3050 1000 3150
Entry Wire Line
	900  2950 1000 3050
Entry Wire Line
	900  2850 1000 2950
Entry Wire Line
	900  2750 1000 2850
Entry Wire Line
	900  2650 1000 2750
Entry Wire Line
	900  2550 1000 2650
Entry Wire Line
	900  2450 1000 2550
Entry Wire Line
	900  2350 1000 2450
Text GLabel 1050 2050 1    50   Input ~ 0
R~W
Wire Wire Line
	1050 2350 1350 2350
$Comp
L power:GND #PWR0150
U 1 1 60AD9E86
P 1350 3650
F 0 "#PWR0150" H 1350 3400 50  0001 C CNN
F 1 "GND" V 1355 3522 50  0000 R CNN
F 2 "" H 1350 3650 50  0001 C CNN
F 3 "" H 1350 3650 50  0001 C CNN
	1    1350 3650
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0155
U 1 1 60AD9E8C
P 1200 1750
F 0 "#PWR0155" H 1200 1600 50  0001 C CNN
F 1 "+5V" H 1000 1850 50  0000 L CNN
F 2 "" H 1200 1750 50  0001 C CNN
F 3 "" H 1200 1750 50  0001 C CNN
	1    1200 1750
	1    0    0    -1  
$EndComp
Text GLabel 1350 2050 1    50   Input ~ 0
VCLK
$Comp
L 74xx:74LS20 U227
U 3 1 6259510E
P 6200 1150
F 0 "U227" H 6200 1600 50  0000 L CNN
F 1 "74HC20" H 6200 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 6200 1150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS20" H 6200 1150 50  0001 C CNN
	3    6200 1150
	1    0    0    -1  
$EndComp
NoConn ~ 1350 2250
Text Notes 1600 2300 0    50   ~ 0
KEY
Entry Wire Line
	750  3350 850  3450
Entry Wire Line
	750  3450 850  3550
Wire Wire Line
	850  3450 1350 3450
Wire Wire Line
	850  3550 1350 3550
Text Label 1200 3450 0    50   ~ 0
A13
Text Label 1200 3550 0    50   ~ 0
A12
Text Label 1200 2350 0    50   ~ 0
R~W
$Comp
L 74xx:74LS139 U10
U 3 1 612E1A0F
P 3050 1150
F 0 "U10" H 3050 1600 50  0000 L CNN
F 1 "74HC139" H 3050 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 3050 1150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 3050 1150 50  0001 C CNN
	3    3050 1150
	1    0    0    -1  
$EndComp
Connection ~ 5750 650 
Wire Wire Line
	5750 650  6200 650 
Connection ~ 5750 1650
Wire Wire Line
	5750 1650 6200 1650
Text GLabel 3700 2150 1    50   Input ~ 0
D[0..7]
Entry Wire Line
	3700 2700 3600 2800
Entry Wire Line
	3700 2600 3600 2700
Entry Wire Line
	3700 2500 3600 2600
Entry Wire Line
	3700 2400 3600 2500
Text Label 3600 2500 2    50   ~ 0
D4
Text Label 3600 2600 2    50   ~ 0
D5
Text Label 3600 2700 2    50   ~ 0
D6
Text Label 3600 2800 2    50   ~ 0
D7
Text GLabel 2250 2800 0    50   Input ~ 0
HIRES
Text GLabel 2250 2700 0    50   Input ~ 0
INVERT
Text GLabel 2250 3000 0    50   Input ~ 0
~FRAME
Text GLabel 2250 2900 0    50   Input ~ 0
~LINE
Wire Wire Line
	3500 750  3500 650 
Wire Wire Line
	3500 1550 3500 1650
Connection ~ 5300 650 
Wire Wire Line
	5300 650  5750 650 
Connection ~ 5300 1650
Wire Wire Line
	5300 1650 5750 1650
Connection ~ 2150 650 
Connection ~ 2150 1650
Connection ~ 2600 650 
Connection ~ 2600 1650
Connection ~ 3050 650 
Connection ~ 3050 1650
Connection ~ 3500 650 
Connection ~ 3500 1650
Connection ~ 3950 650 
Connection ~ 3950 1650
Wire Wire Line
	1700 650  2150 650 
Wire Wire Line
	1700 1650 2150 1650
Wire Wire Line
	2150 650  2600 650 
Wire Wire Line
	2150 1650 2600 1650
Wire Wire Line
	2600 650  3050 650 
Wire Wire Line
	2600 1650 3050 1650
Wire Wire Line
	3050 650  3500 650 
Wire Wire Line
	3050 1650 3500 1650
Wire Wire Line
	3500 650  3950 650 
Wire Wire Line
	3500 1650 3950 1650
Wire Wire Line
	3950 650  4400 650 
Wire Wire Line
	3950 1650 4400 1650
Connection ~ 4400 650 
Connection ~ 4400 1650
Wire Wire Line
	4400 650  4850 650 
Wire Wire Line
	4400 1650 4850 1650
Connection ~ 4850 650 
Wire Wire Line
	4850 650  5300 650 
Connection ~ 4850 1650
Wire Wire Line
	4850 1650 5300 1650
$Comp
L 74xx:74LS139 U529
U 3 1 62D1DE0F
P 6650 1150
F 0 "U529" H 6650 1600 50  0000 L CNN
F 1 "74HC139" H 6650 1500 50  0000 L CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 6650 1150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 6650 1150 50  0001 C CNN
	3    6650 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 650  6650 650 
Connection ~ 6200 650 
Wire Wire Line
	6200 1650 6650 1650
Connection ~ 6200 1650
Text GLabel 2250 3200 0    50   Input ~ 0
~STAT
Text GLabel 2250 3300 0    50   Input ~ 0
~BLANK
Wire Wire Line
	1050 2050 1050 2350
Wire Wire Line
	3250 2500 3600 2500
Wire Wire Line
	3250 2600 3600 2600
Text GLabel 2250 2500 0    50   Input ~ 0
SC0
Text GLabel 2250 2600 0    50   Input ~ 0
SC1
$Comp
L Connector:USB_B J7
U 1 1 61A5663E
P 950 900
F 0 "J7" H 600 950 50  0000 C CNN
F 1 "POWER" H 600 850 50  0000 C CNN
F 2 "Connector_USB:USB_B_OST_USB-B1HSxx_Horizontal" H 1100 850 50  0001 C CNN
F 3 " ~" H 1100 850 50  0001 C CNN
	1    950  900 
	1    0    0    -1  
$EndComp
Connection ~ 950  1300
Wire Wire Line
	950  1300 1350 1300
Connection ~ 1700 650 
Wire Wire Line
	1350 700  1250 700 
NoConn ~ 1250 900 
NoConn ~ 1250 1000
Text GLabel 1350 5600 0    50   Input ~ 0
VCLK
Text GLabel 1850 5600 2    50   Input ~ 0
~RESET
Text GLabel 1200 4200 0    50   Input ~ 0
~WE
Text GLabel 2050 4000 2    50   Input ~ 0
~IOC
Entry Wire Line
	750  4200 850  4300
Entry Wire Line
	750  4300 850  4400
Entry Wire Line
	750  4400 850  4500
Entry Wire Line
	750  4500 850  4600
Entry Wire Line
	750  4600 850  4700
Entry Wire Line
	750  4700 850  4800
Entry Wire Line
	750  4900 850  5000
Entry Wire Line
	750  4800 850  4900
$Comp
L power:GND #PWR0164
U 1 1 624C4252
P 1350 5500
F 0 "#PWR0164" H 1350 5250 50  0001 C CNN
F 1 "GND" V 1355 5372 50  0000 R CNN
F 2 "" H 1350 5500 50  0001 C CNN
F 3 "" H 1350 5500 50  0001 C CNN
	1    1350 5500
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0165
U 1 1 624C4A16
P 1850 4200
F 0 "#PWR0165" H 1850 4050 50  0001 C CNN
F 1 "+5V" V 1865 4328 50  0000 L CNN
F 2 "" H 1850 4200 50  0001 C CNN
F 3 "" H 1850 4200 50  0001 C CNN
	1    1850 4200
	0    1    1    0   
$EndComp
Wire Bus Line
	750  5750 2450 5750
Wire Bus Line
	900  5700 2300 5700
Entry Wire Line
	750  5000 850  5100
Entry Wire Line
	900  5100 1000 5200
Entry Wire Line
	900  5200 1000 5300
Entry Wire Line
	2200 5500 2300 5600
Entry Wire Line
	2200 5400 2300 5500
Entry Wire Line
	2200 5300 2300 5400
Entry Wire Line
	2200 5200 2300 5300
Entry Wire Line
	2200 5100 2300 5200
Entry Wire Line
	2350 4900 2450 5000
Entry Wire Line
	2350 4700 2450 4800
Entry Wire Line
	2350 4600 2450 4700
Entry Wire Line
	2350 4500 2450 4600
Entry Wire Line
	2350 4400 2450 4500
Entry Wire Line
	2350 4300 2450 4400
Wire Wire Line
	1850 4300 2350 4300
Wire Wire Line
	1850 4400 2350 4400
Wire Wire Line
	1850 4500 2350 4500
Wire Wire Line
	1850 4600 2350 4600
Wire Wire Line
	1850 4700 2350 4700
Wire Wire Line
	1850 4900 2350 4900
Wire Wire Line
	1850 5100 2200 5100
Wire Wire Line
	1850 5200 2200 5200
Wire Wire Line
	1850 5300 2200 5300
Wire Wire Line
	1850 5400 2200 5400
Wire Wire Line
	1850 5500 2200 5500
Entry Wire Line
	900  5300 1000 5400
Text Label 1350 5200 2    50   ~ 0
D0
Text Label 1350 5400 2    50   ~ 0
D2
Text Label 1850 5500 0    50   ~ 0
D3
Text Label 1850 5400 0    50   ~ 0
D4
Text Label 1850 5300 0    50   ~ 0
D5
Text Label 1850 5200 0    50   ~ 0
D6
Text Label 1850 5100 0    50   ~ 0
D7
Text Label 1850 4900 0    50   ~ 0
A10
Text Label 1850 4700 0    50   ~ 0
A11
Text Label 1850 4600 0    50   ~ 0
A9
Text Label 1850 4500 0    50   ~ 0
A8
Text Label 1850 4400 0    50   ~ 0
A13
Text Label 1850 4300 0    50   ~ 0
A14
Text Label 1350 4300 2    50   ~ 0
A12
Text Label 1350 4400 2    50   ~ 0
A7
Text Label 1350 4500 2    50   ~ 0
A6
Text Label 1350 4600 2    50   ~ 0
A5
Text Label 1350 4700 2    50   ~ 0
A4
Text Label 1350 4800 2    50   ~ 0
A3
Text Label 1350 4900 2    50   ~ 0
A2
Text Label 1350 5000 2    50   ~ 0
A1
Text Label 1350 5100 2    50   ~ 0
A0
Text GLabel 2000 5000 2    50   Input ~ 0
~ROM_CS
Text GLabel 2000 4800 2    50   Input ~ 0
~ROM_OE
Wire Wire Line
	2000 4800 1850 4800
Wire Wire Line
	2000 5000 1850 5000
Text GLabel 1350 4000 0    50   Input ~ 0
AUDIO_IN
Wire Wire Line
	1200 4200 1350 4200
Wire Wire Line
	850  4300 1350 4300
Wire Wire Line
	850  4400 1350 4400
Wire Wire Line
	850  4500 1350 4500
Wire Wire Line
	850  4600 1350 4600
Wire Wire Line
	850  4700 1350 4700
Wire Wire Line
	850  4800 1350 4800
Wire Wire Line
	850  4900 1350 4900
Wire Wire Line
	850  5000 1350 5000
Wire Wire Line
	1000 5200 1350 5200
Wire Wire Line
	1000 5300 1350 5300
Text Label 1350 5300 2    50   ~ 0
D1
Wire Wire Line
	1000 5400 1350 5400
Wire Wire Line
	1350 3650 1350 3750
Wire Wire Line
	1350 3750 2750 3750
Wire Wire Line
	2750 3600 2750 3750
Connection ~ 1350 3650
Text Notes 4150 3300 0    100  ~ 0
 xx = Standard\n1xx = Only needed for Colour mode\n2xx = Only needed for HiRes mode\n3xx = Only for switching modes (may be replaced by jumpers)\n4xx = Switchable features (may be replaced by jumpers)\n5xx = Advanced features (may be replaced by jumpers)\n8xx = Only if HiRes is *NOT* supported
NoConn ~ 1350 4100
NoConn ~ 1850 4100
Text Notes 1900 4150 0    50   Italic 0
KEY
Text Notes 1150 4150 0    50   Italic 0
KEY
$Comp
L Connector_Generic:Conn_02x18_Odd_Even J9
U 1 1 625630C9
P 1650 4700
F 0 "J9" H 1700 3600 50  0000 C CNN
F 1 "CARTRIDGE" H 1700 3500 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x18_EDGE" H 1650 4700 50  0001 C CNN
F 3 "~" H 1650 4700 50  0001 C CNN
	1    1650 4700
	-1   0    0    -1  
$EndComp
Text GLabel 1350 3900 0    50   Input ~ 0
~NMI
Text GLabel 1850 3900 2    50   Input ~ 0
~IRQ
Wire Wire Line
	2050 4000 1850 4000
Text GLabel 5750 4450 0    50   Input ~ 0
RED
Text GLabel 5750 5050 0    50   Input ~ 0
BLUE
Text GLabel 5750 4750 0    50   Input ~ 0
GRN
$Comp
L Device:Jumper_NC_Small JP3
U 1 1 626C59A2
P 1350 800
F 0 "JP3" V 1304 874 50  0000 L CNN
F 1 "PWR_SW" V 1450 800 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 1350 800 50  0001 C CNN
F 3 "~" H 1350 800 50  0001 C CNN
	1    1350 800 
	0    1    1    0   
$EndComp
Wire Wire Line
	1350 900  1350 1000
Connection ~ 1350 1000
Text Notes 5900 4850 0    100  Italic 0
Future component-video output\ngoes here…
Text Label 1250 700  0    50   ~ 0
+5V_IN
NoConn ~ 3750 4800
Text Label 3750 4300 0    50   ~ 0
BA0
Text Label 3750 4400 0    50   ~ 0
BA1
Text Label 3750 4500 0    50   ~ 0
BA2
Text Label 3750 4600 0    50   ~ 0
BA3
Wire Wire Line
	3950 4300 3750 4300
Wire Wire Line
	3950 4400 3750 4400
Wire Wire Line
	3950 4500 3750 4500
Wire Wire Line
	3950 4600 3750 4600
Wire Wire Line
	3950 4700 3750 4700
Entry Wire Line
	3950 4300 4050 4400
Entry Wire Line
	3950 4400 4050 4500
Entry Wire Line
	3950 4500 4050 4600
Entry Wire Line
	3950 4600 4050 4700
Entry Wire Line
	3950 4700 4050 4800
Text GLabel 4050 4900 3    50   Input ~ 0
BA[0..4]
$Comp
L 74xx:74HC245 U?
U 1 1 627D9D31
P 3250 4800
AR Path="/60C42E7C/627D9D31" Ref="U?"  Part="1" 
AR Path="/6310B9C7/627D9D31" Ref="U32"  Part="1" 
F 0 "U32" H 3050 5550 50  0000 R CNN
F 1 "74HC245" H 3150 5450 50  0000 R CNN
F 2 "Package_DIP:DIP-20_W7.62mm_Socket" H 3250 4800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 3250 4800 50  0001 C CNN
	1    3250 4800
	-1   0    0    -1  
$EndComp
Entry Wire Line
	2450 4400 2550 4300
Entry Wire Line
	2450 4500 2550 4400
Entry Wire Line
	2450 4600 2550 4500
Entry Wire Line
	2450 4700 2550 4600
NoConn ~ 3750 4900
NoConn ~ 3750 5000
Wire Wire Line
	3250 5600 3750 5600
Wire Wire Line
	3750 5600 3750 5300
Connection ~ 3750 5300
Wire Wire Line
	3750 5300 3750 5200
Wire Wire Line
	2550 4300 2750 4300
Wire Wire Line
	2550 4400 2750 4400
Wire Wire Line
	2550 4500 2750 4500
Wire Wire Line
	2550 4600 2750 4600
Wire Wire Line
	3250 5600 2750 5600
Wire Wire Line
	2750 5600 2750 5000
Connection ~ 3250 5600
Connection ~ 2750 4900
Wire Wire Line
	2750 4900 2750 4800
Connection ~ 2750 5000
Wire Wire Line
	2750 5000 2750 4900
$Comp
L power:GND #PWR0135
U 1 1 628164ED
P 3250 5600
F 0 "#PWR0135" H 3250 5350 50  0001 C CNN
F 1 "GND" H 3255 5427 50  0000 C CNN
F 2 "" H 3250 5600 50  0001 C CNN
F 3 "" H 3250 5600 50  0001 C CNN
	1    3250 5600
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0166
U 1 1 62816C8C
P 3250 4000
F 0 "#PWR0166" H 3250 3850 50  0001 C CNN
F 1 "+5V" H 3265 4173 50  0000 C CNN
F 2 "" H 3250 4000 50  0001 C CNN
F 3 "" H 3250 4000 50  0001 C CNN
	1    3250 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 4700 2750 4700
Text Label 2600 4700 0    50   ~ 0
R~W
Wire Wire Line
	2550 4850 2550 4700
Text GLabel 2550 4850 3    50   Input ~ 0
R~W
Text Label 2600 4300 0    50   ~ 0
A0
Text Label 2600 4400 0    50   ~ 0
A1
Text Label 2600 4500 0    50   ~ 0
A2
Text Label 2600 4600 0    50   ~ 0
A3
$Comp
L Connector:Conn_Coaxial J?
U 1 1 631CCF99
P 3550 3550
AR Path="/60C42E7C/631CCF99" Ref="J?"  Part="1" 
AR Path="/6310B9C7/631CCF99" Ref="J006"  Part="1" 
F 0 "J006" H 3650 3550 50  0000 L CNN
F 1 "VIDEO/Y" H 3600 3450 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 3550 3550 50  0001 C CNN
F 3 " ~" H 3550 3550 50  0001 C CNN
	1    3550 3550
	1    0    0    -1  
$EndComp
Text GLabel 3350 3550 0    50   Input ~ 0
VIDEO
Wire Wire Line
	3550 3750 2750 3750
Connection ~ 2750 3750
Text Notes 3200 3450 0    50   Italic 10
ALSO SYNC-ON-GREEN
Wire Wire Line
	3250 2700 3350 2700
Wire Wire Line
	3250 2800 3600 2800
$Comp
L 74xx:74LS367 U530
U 1 1 61283F21
P 2750 2900
F 0 "U530" H 2500 3550 50  0000 C CNN
F 1 "74HC367" H 2500 3450 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 2750 2900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS367" H 2750 2900 50  0001 C CNN
	1    2750 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 2900 3250 2800
Connection ~ 3250 2800
Wire Wire Line
	3250 3000 3350 3000
Wire Wire Line
	3350 3000 3350 2700
Connection ~ 3350 2700
Wire Wire Line
	3350 2700 3600 2700
Text Label 3750 4700 0    50   ~ 0
BA4
Text Notes 3950 4700 3    50   ~ 0
=~BWR
Wire Wire Line
	1200 1750 1200 2150
Wire Wire Line
	1200 2150 1350 2150
Wire Wire Line
	1200 1750 2750 1750
Wire Wire Line
	2750 1750 2750 2200
Wire Wire Line
	850  5100 1350 5100
Wire Bus Line
	4050 4400 4050 4900
Wire Bus Line
	3700 2150 3700 2700
Wire Bus Line
	2300 5200 2300 5700
Wire Bus Line
	2450 4400 2450 5750
Wire Bus Line
	900  2150 900  5700
Wire Bus Line
	750  2150 750  5750
Connection ~ 1200 1750
$EndSCHEMATC
