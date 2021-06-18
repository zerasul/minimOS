EESchema Schematic File Version 4
LIBS:430head-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Transistor_BJT:BC337 Q4
U 1 1 60C899DF
P 3900 1700
F 0 "Q4" H 4091 1746 50  0000 L CNN
F 1 "BC337" H 4091 1655 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 4100 1625 50  0001 L CIN
F 3 "https://diotec.com/tl_files/diotec/files/pdf/datasheets/bc337.pdf" H 3900 1700 50  0001 L CNN
	1    3900 1700
	1    0    0    -1  
$EndComp
$Comp
L Transistor_BJT:BC327 Q5
U 1 1 60C8A648
P 3900 2700
F 0 "Q5" H 4091 2654 50  0000 L CNN
F 1 "BC327" H 4091 2745 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 4100 2625 50  0001 L CIN
F 3 "http://www.onsemi.com/pub_link/Collateral/BC327-D.PDF" H 3900 2700 50  0001 L CNN
	1    3900 2700
	1    0    0    1   
$EndComp
$Comp
L Device:R R10
U 1 1 60C8B32E
P 4000 2050
F 0 "R10" H 4070 2096 50  0000 L CNN
F 1 "1R0" H 4070 2005 50  0000 L CNN
F 2 "" V 3930 2050 50  0001 C CNN
F 3 "~" H 4000 2050 50  0001 C CNN
	1    4000 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 60C8B76C
P 4000 2350
F 0 "R11" H 4070 2396 50  0000 L CNN
F 1 "1R0" H 4070 2305 50  0000 L CNN
F 2 "" V 3930 2350 50  0001 C CNN
F 3 "~" H 4000 2350 50  0001 C CNN
	1    4000 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C5
U 1 1 60C8C644
P 4300 2050
F 0 "C5" H 4418 2096 50  0000 L CNN
F 1 "1000u" H 4418 2005 50  0000 L CNN
F 2 "" H 4338 1900 50  0001 C CNN
F 3 "~" H 4300 2050 50  0001 C CNN
	1    4300 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 60C8D64F
P 4300 2950
F 0 "R7" H 4230 2904 50  0000 R CNN
F 1 "82K" H 4230 2995 50  0000 R CNN
F 2 "" V 4230 2950 50  0001 C CNN
F 3 "~" H 4300 2950 50  0001 C CNN
	1    4300 2950
	-1   0    0    1   
$EndComp
$Comp
L Device:D D1
U 1 1 60C8EDEF
P 3700 1850
F 0 "D1" V 3700 2000 50  0000 R CNN
F 1 "1N4148" V 3600 2150 50  0000 R CNN
F 2 "" H 3700 1850 50  0001 C CNN
F 3 "~" H 3700 1850 50  0001 C CNN
	1    3700 1850
	0    -1   -1   0   
$EndComp
$Comp
L Device:D D2
U 1 1 60C8F21E
P 3700 2550
F 0 "D2" V 3700 2700 50  0000 R CNN
F 1 "1N4148" V 3600 2850 50  0000 R CNN
F 2 "" H 3700 2550 50  0001 C CNN
F 3 "~" H 3700 2550 50  0001 C CNN
	1    3700 2550
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Variable R9
U 1 1 60C901F3
P 3700 2200
F 0 "R9" H 3750 2150 50  0000 L CNN
F 1 "100" H 3750 2050 50  0000 L CNN
F 2 "" V 3630 2200 50  0001 C CNN
F 3 "~" H 3700 2200 50  0001 C CNN
	1    3700 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 2000 3700 2050
Wire Wire Line
	3700 2350 3700 2400
$Comp
L Device:CP C4
U 1 1 60C90DBF
P 3400 2200
F 0 "C4" H 3400 2300 50  0000 L CNN
F 1 "100u" H 3400 2100 50  0000 L CNN
F 2 "" H 3438 2050 50  0001 C CNN
F 3 "~" H 3400 2200 50  0001 C CNN
	1    3400 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 2050 3700 2050
Connection ~ 3700 2050
Wire Wire Line
	3400 2350 3700 2350
Connection ~ 3700 2350
$Comp
L Device:R R8
U 1 1 60C91542
P 3700 1550
F 0 "R8" H 3750 1650 50  0000 L CNN
F 1 "1K8" H 3750 1550 50  0000 L CNN
F 2 "" V 3630 1550 50  0001 C CNN
F 3 "~" H 3700 1550 50  0001 C CNN
	1    3700 1550
	1    0    0    -1  
$EndComp
Connection ~ 3700 1700
$Comp
L Transistor_BJT:BC549 Q3
U 1 1 60C91A08
P 3600 2900
F 0 "Q3" H 3791 2946 50  0000 L CNN
F 1 "BC549" H 3791 2855 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 3800 2825 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/BC550-D.pdf" H 3600 2900 50  0001 L CNN
	1    3600 2900
	1    0    0    -1  
$EndComp
Connection ~ 3700 2700
$Comp
L Device:R R6
U 1 1 60C94BB4
P 4150 3100
F 0 "R6" V 3943 3100 50  0000 C CNN
F 1 "12K" V 4034 3100 50  0000 C CNN
F 2 "" V 4080 3100 50  0001 C CNN
F 3 "~" H 4150 3100 50  0001 C CNN
	1    4150 3100
	0    1    1    0   
$EndComp
$Comp
L Device:R R5
U 1 1 60C95319
P 3250 2900
F 0 "R5" V 3043 2900 50  0000 C CNN
F 1 "4K7" V 3134 2900 50  0000 C CNN
F 2 "" V 3180 2900 50  0001 C CNN
F 3 "~" H 3250 2900 50  0001 C CNN
	1    3250 2900
	0    1    1    0   
$EndComp
$Comp
L Device:CP C3
U 1 1 60C95898
P 2950 2900
F 0 "C3" V 3200 2900 50  0000 C CNN
F 1 "22u" V 3100 2900 50  0000 C CNN
F 2 "" H 2988 2750 50  0001 C CNN
F 3 "~" H 2950 2900 50  0001 C CNN
	1    2950 2900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3700 3100 4000 3100
Wire Wire Line
	4000 2900 4000 3100
Connection ~ 4000 3100
$Comp
L power:GND #PWR0101
U 1 1 60C97C40
P 3700 3100
F 0 "#PWR0101" H 3700 2850 50  0001 C CNN
F 1 "GND" H 3705 2927 50  0000 C CNN
F 2 "" H 3700 3100 50  0001 C CNN
F 3 "" H 3700 3100 50  0001 C CNN
	1    3700 3100
	1    0    0    -1  
$EndComp
Connection ~ 3700 3100
Wire Wire Line
	3400 2900 3400 3350
Wire Wire Line
	3400 3350 4300 3350
Wire Wire Line
	4300 3350 4300 3100
Connection ~ 3400 2900
Connection ~ 4300 3100
Wire Wire Line
	4000 2200 4300 2200
Connection ~ 4000 2200
Wire Wire Line
	4300 2200 4300 2800
Connection ~ 4300 2200
Wire Wire Line
	3700 1400 4300 1400
Wire Wire Line
	4300 1400 4300 1900
$Comp
L Device:CP C6
U 1 1 60C989FF
P 3400 1450
F 0 "C6" H 3500 1450 50  0000 L CNN
F 1 "470u" H 3400 1350 50  0000 L CNN
F 2 "" H 3438 1300 50  0001 C CNN
F 3 "~" H 3400 1450 50  0001 C CNN
	1    3400 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 1300 4000 1500
$Comp
L power:+12V #PWR0102
U 1 1 60C99DF7
P 4000 1300
F 0 "#PWR0102" H 4000 1150 50  0001 C CNN
F 1 "+12V" H 4015 1473 50  0000 C CNN
F 2 "" H 4000 1300 50  0001 C CNN
F 3 "" H 4000 1300 50  0001 C CNN
	1    4000 1300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 60C9A1D8
P 3400 1600
F 0 "#PWR0103" H 3400 1350 50  0001 C CNN
F 1 "GND" H 3405 1427 50  0000 C CNN
F 2 "" H 3400 1600 50  0001 C CNN
F 3 "" H 3400 1600 50  0001 C CNN
	1    3400 1600
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C2
U 1 1 60C9C132
P 3100 2400
F 0 "C2" H 3200 2350 50  0000 L CNN
F 1 "22u" H 3150 2500 50  0000 L CNN
F 2 "" H 3138 2250 50  0001 C CNN
F 3 "~" H 3100 2400 50  0001 C CNN
	1    3100 2400
	-1   0    0    1   
$EndComp
Wire Wire Line
	3400 1300 4000 1300
Connection ~ 4000 1300
$Comp
L Transistor_BJT:BC549 Q2
U 1 1 60CA16F3
P 2700 2000
F 0 "Q2" H 2891 2046 50  0000 L CNN
F 1 "BC549" H 2891 1955 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 2900 1925 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/BC550-D.pdf" H 2700 2000 50  0001 L CNN
	1    2700 2000
	1    0    0    -1  
$EndComp
$Comp
L Transistor_BJT:BC559 Q1
U 1 1 60CA3E65
P 2400 2200
F 0 "Q1" H 2591 2154 50  0000 L CNN
F 1 "BC559" H 2550 2250 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 2600 2125 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/BC556BTA-D.pdf" H 2400 2200 50  0001 L CNN
	1    2400 2200
	1    0    0    1   
$EndComp
$Comp
L Device:R R3
U 1 1 60CA539A
P 2500 1850
F 0 "R3" H 2550 1950 50  0000 L CNN
F 1 "390K" H 2550 1850 50  0000 L CNN
F 2 "" V 2430 1850 50  0001 C CNN
F 3 "~" H 2500 1850 50  0001 C CNN
	1    2500 1850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 60CA59E9
P 2200 1850
F 0 "R1" H 2270 1896 50  0000 L CNN
F 1 "2M2" H 2270 1805 50  0000 L CNN
F 2 "" V 2130 1850 50  0001 C CNN
F 3 "~" H 2200 1850 50  0001 C CNN
	1    2200 1850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 60CA6423
P 2200 2400
F 0 "R2" H 2270 2446 50  0000 L CNN
F 1 "1M8" H 2270 2355 50  0000 L CNN
F 2 "" V 2130 2400 50  0001 C CNN
F 3 "~" H 2200 2400 50  0001 C CNN
	1    2200 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 60CA6963
P 2050 2100
F 0 "C1" V 1798 2100 50  0000 C CNN
F 1 "15n" V 1889 2100 50  0000 C CNN
F 2 "" H 2088 1950 50  0001 C CNN
F 3 "~" H 2050 2100 50  0001 C CNN
	1    2050 2100
	0    1    1    0   
$EndComp
Wire Wire Line
	2200 2000 2200 2100
Connection ~ 2200 2100
Wire Wire Line
	2200 2100 2200 2200
Wire Wire Line
	2800 1800 2800 1700
Wire Wire Line
	2800 1300 3400 1300
Connection ~ 3400 1300
Wire Wire Line
	2200 1700 2500 1700
Connection ~ 2800 1700
Wire Wire Line
	2800 1700 2800 1300
Connection ~ 2500 1700
Wire Wire Line
	2500 1700 2800 1700
Wire Wire Line
	2200 2550 2500 2550
Wire Wire Line
	2500 2550 2500 2400
Connection ~ 2500 2000
Connection ~ 2200 2200
$Comp
L Device:R R4
U 1 1 60CA9D7E
P 2800 2400
F 0 "R4" H 2650 2450 50  0000 L CNN
F 1 "4K7" H 2600 2350 50  0000 L CNN
F 2 "" V 2730 2400 50  0001 C CNN
F 3 "~" H 2800 2400 50  0001 C CNN
	1    2800 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 2200 2200 2250
Wire Wire Line
	2500 2550 2800 2550
Connection ~ 2500 2550
$Comp
L power:GND #PWR0104
U 1 1 60CADB65
P 2200 2550
F 0 "#PWR0104" H 2200 2300 50  0001 C CNN
F 1 "GND" H 2050 2450 50  0000 C CNN
F 2 "" H 2200 2550 50  0001 C CNN
F 3 "" H 2200 2550 50  0001 C CNN
	1    2200 2550
	1    0    0    -1  
$EndComp
Connection ~ 2200 2550
Wire Wire Line
	1900 2100 1900 3600
$Comp
L Transistor_BJT:BC337 Q24
U 1 1 60CF6F10
P 3900 4100
F 0 "Q24" H 4091 4146 50  0000 L CNN
F 1 "BC337" H 4091 4055 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 4100 4025 50  0001 L CIN
F 3 "https://diotec.com/tl_files/diotec/files/pdf/datasheets/bc337.pdf" H 3900 4100 50  0001 L CNN
	1    3900 4100
	1    0    0    -1  
$EndComp
$Comp
L Transistor_BJT:BC327 Q25
U 1 1 60CF6F1A
P 3900 5100
F 0 "Q25" H 4091 5054 50  0000 L CNN
F 1 "BC327" H 4091 5145 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 4100 5025 50  0001 L CIN
F 3 "http://www.onsemi.com/pub_link/Collateral/BC327-D.PDF" H 3900 5100 50  0001 L CNN
	1    3900 5100
	1    0    0    1   
$EndComp
$Comp
L Device:R R30
U 1 1 60CF6F24
P 4000 4450
F 0 "R30" H 4070 4496 50  0000 L CNN
F 1 "1R0" H 4070 4405 50  0000 L CNN
F 2 "" V 3930 4450 50  0001 C CNN
F 3 "~" H 4000 4450 50  0001 C CNN
	1    4000 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R31
U 1 1 60CF6F2E
P 4000 4750
F 0 "R31" H 4070 4796 50  0000 L CNN
F 1 "1R0" H 4070 4705 50  0000 L CNN
F 2 "" V 3930 4750 50  0001 C CNN
F 3 "~" H 4000 4750 50  0001 C CNN
	1    4000 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C25
U 1 1 60CF6F38
P 4300 4450
F 0 "C25" H 4418 4496 50  0000 L CNN
F 1 "1000u" H 4418 4405 50  0000 L CNN
F 2 "" H 4338 4300 50  0001 C CNN
F 3 "~" H 4300 4450 50  0001 C CNN
	1    4300 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R27
U 1 1 60CF6F42
P 4300 5350
F 0 "R27" H 4230 5304 50  0000 R CNN
F 1 "82K" H 4230 5395 50  0000 R CNN
F 2 "" V 4230 5350 50  0001 C CNN
F 3 "~" H 4300 5350 50  0001 C CNN
	1    4300 5350
	-1   0    0    1   
$EndComp
$Comp
L Device:D D21
U 1 1 60CF6F4C
P 3700 4250
F 0 "D21" V 3700 4450 50  0000 R CNN
F 1 "1N4148" V 3600 4550 50  0000 R CNN
F 2 "" H 3700 4250 50  0001 C CNN
F 3 "~" H 3700 4250 50  0001 C CNN
	1    3700 4250
	0    -1   -1   0   
$EndComp
$Comp
L Device:D D22
U 1 1 60CF6F56
P 3700 4950
F 0 "D22" V 3700 5150 50  0000 R CNN
F 1 "1N4148" V 3600 5250 50  0000 R CNN
F 2 "" H 3700 4950 50  0001 C CNN
F 3 "~" H 3700 4950 50  0001 C CNN
	1    3700 4950
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Variable R29
U 1 1 60CF6F60
P 3700 4600
F 0 "R29" H 3750 4550 50  0000 L CNN
F 1 "100" H 3750 4450 50  0000 L CNN
F 2 "" V 3630 4600 50  0001 C CNN
F 3 "~" H 3700 4600 50  0001 C CNN
	1    3700 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 4400 3700 4450
Wire Wire Line
	3700 4750 3700 4800
$Comp
L Device:CP C24
U 1 1 60CF6F6C
P 3400 4600
F 0 "C24" H 3400 4700 50  0000 L CNN
F 1 "100u" H 3400 4500 50  0000 L CNN
F 2 "" H 3438 4450 50  0001 C CNN
F 3 "~" H 3400 4600 50  0001 C CNN
	1    3400 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 4450 3700 4450
Connection ~ 3700 4450
Wire Wire Line
	3400 4750 3700 4750
Connection ~ 3700 4750
$Comp
L Device:R R28
U 1 1 60CF6F7A
P 3700 3950
F 0 "R28" H 3750 4050 50  0000 L CNN
F 1 "1K8" H 3750 3950 50  0000 L CNN
F 2 "" V 3630 3950 50  0001 C CNN
F 3 "~" H 3700 3950 50  0001 C CNN
	1    3700 3950
	1    0    0    -1  
$EndComp
Connection ~ 3700 4100
$Comp
L Transistor_BJT:BC549 Q23
U 1 1 60CF6F85
P 3600 5300
F 0 "Q23" H 3791 5346 50  0000 L CNN
F 1 "BC549" H 3791 5255 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 3800 5225 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/BC550-D.pdf" H 3600 5300 50  0001 L CNN
	1    3600 5300
	1    0    0    -1  
$EndComp
Connection ~ 3700 5100
$Comp
L Device:R R26
U 1 1 60CF6F90
P 4150 5500
F 0 "R26" V 3943 5500 50  0000 C CNN
F 1 "12K" V 4034 5500 50  0000 C CNN
F 2 "" V 4080 5500 50  0001 C CNN
F 3 "~" H 4150 5500 50  0001 C CNN
	1    4150 5500
	0    1    1    0   
$EndComp
$Comp
L Device:R R25
U 1 1 60CF6F9A
P 3250 5300
F 0 "R25" V 3043 5300 50  0000 C CNN
F 1 "4K7" V 3134 5300 50  0000 C CNN
F 2 "" V 3180 5300 50  0001 C CNN
F 3 "~" H 3250 5300 50  0001 C CNN
	1    3250 5300
	0    1    1    0   
$EndComp
$Comp
L Device:CP C23
U 1 1 60CF6FA4
P 3100 3250
F 0 "C23" H 3200 3350 50  0000 C CNN
F 1 "22u" H 3200 3150 50  0000 C CNN
F 2 "" H 3138 3100 50  0001 C CNN
F 3 "~" H 3100 3250 50  0001 C CNN
	1    3100 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 5500 4000 5500
Wire Wire Line
	4000 5300 4000 5500
Connection ~ 4000 5500
$Comp
L power:GND #PWR0105
U 1 1 60CF6FB1
P 3700 5500
F 0 "#PWR0105" H 3700 5250 50  0001 C CNN
F 1 "GND" H 3705 5327 50  0000 C CNN
F 2 "" H 3700 5500 50  0001 C CNN
F 3 "" H 3700 5500 50  0001 C CNN
	1    3700 5500
	1    0    0    -1  
$EndComp
Connection ~ 3700 5500
Wire Wire Line
	3400 5300 3400 5750
Wire Wire Line
	3400 5750 4300 5750
Wire Wire Line
	4300 5750 4300 5500
Connection ~ 3400 5300
Connection ~ 4300 5500
Wire Wire Line
	4000 4600 4300 4600
Connection ~ 4000 4600
Wire Wire Line
	4300 4600 4300 5200
Connection ~ 4300 4600
Wire Wire Line
	3700 3800 4300 3800
Wire Wire Line
	4300 3800 4300 4300
$Comp
L Device:CP C26
U 1 1 60CF6FC7
P 3400 3850
F 0 "C26" H 3500 3850 50  0000 L CNN
F 1 "470u" H 3400 3750 50  0000 L CNN
F 2 "" H 3438 3700 50  0001 C CNN
F 3 "~" H 3400 3850 50  0001 C CNN
	1    3400 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 3700 4000 3900
$Comp
L power:+12V #PWR0106
U 1 1 60CF6FD2
P 4000 3700
F 0 "#PWR0106" H 4000 3550 50  0001 C CNN
F 1 "+12V" H 4015 3873 50  0000 C CNN
F 2 "" H 4000 3700 50  0001 C CNN
F 3 "" H 4000 3700 50  0001 C CNN
	1    4000 3700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 60CF6FDC
P 3400 4000
F 0 "#PWR0107" H 3400 3750 50  0001 C CNN
F 1 "GND" H 3405 3827 50  0000 C CNN
F 2 "" H 3400 4000 50  0001 C CNN
F 3 "" H 3400 4000 50  0001 C CNN
	1    3400 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C22
U 1 1 60CF6FE6
P 2950 3950
F 0 "C22" H 2650 4050 50  0000 L CNN
F 1 "22u" H 2650 3950 50  0000 L CNN
F 2 "" H 2988 3800 50  0001 C CNN
F 3 "~" H 2950 3950 50  0001 C CNN
	1    2950 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 3700 4000 3700
Connection ~ 4000 3700
Wire Wire Line
	4000 3700 4300 3700
$Comp
L Transistor_BJT:BC549 Q22
U 1 1 60CF700B
P 2700 4400
F 0 "Q22" H 2891 4446 50  0000 L CNN
F 1 "BC549" H 2850 4350 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 2900 4325 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/BC550-D.pdf" H 2700 4400 50  0001 L CNN
	1    2700 4400
	1    0    0    -1  
$EndComp
$Comp
L Transistor_BJT:BC559 Q21
U 1 1 60CF7015
P 2400 4600
F 0 "Q21" H 2591 4554 50  0000 L CNN
F 1 "BC559" H 2550 4650 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 2600 4525 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/BC556BTA-D.pdf" H 2400 4600 50  0001 L CNN
	1    2400 4600
	1    0    0    1   
$EndComp
$Comp
L Device:R R23
U 1 1 60CF701F
P 2500 4250
F 0 "R23" H 2550 4350 50  0000 L CNN
F 1 "390K" H 2550 4250 50  0000 L CNN
F 2 "" V 2430 4250 50  0001 C CNN
F 3 "~" H 2500 4250 50  0001 C CNN
	1    2500 4250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R21
U 1 1 60CF7029
P 2200 4250
F 0 "R21" H 2270 4296 50  0000 L CNN
F 1 "2M2" H 2270 4205 50  0000 L CNN
F 2 "" V 2130 4250 50  0001 C CNN
F 3 "~" H 2200 4250 50  0001 C CNN
	1    2200 4250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R22
U 1 1 60CF7033
P 2200 4800
F 0 "R22" H 2270 4846 50  0000 L CNN
F 1 "1M8" H 2270 4755 50  0000 L CNN
F 2 "" V 2130 4800 50  0001 C CNN
F 3 "~" H 2200 4800 50  0001 C CNN
	1    2200 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C21
U 1 1 60CF703D
P 2050 4500
F 0 "C21" V 1798 4500 50  0000 C CNN
F 1 "15n" V 1889 4500 50  0000 C CNN
F 2 "" H 2088 4350 50  0001 C CNN
F 3 "~" H 2050 4500 50  0001 C CNN
	1    2050 4500
	0    1    1    0   
$EndComp
Wire Wire Line
	2200 4400 2200 4500
Connection ~ 2200 4500
Wire Wire Line
	2200 4500 2200 4600
Wire Wire Line
	2800 4200 2800 4100
Wire Wire Line
	2800 3700 3400 3700
Connection ~ 3400 3700
Wire Wire Line
	2200 4100 2500 4100
Connection ~ 2800 4100
Wire Wire Line
	2800 4100 2800 3700
Connection ~ 2500 4100
Wire Wire Line
	2500 4100 2800 4100
Wire Wire Line
	2200 4950 2500 4950
Wire Wire Line
	2500 4950 2500 4800
Connection ~ 2500 4400
Connection ~ 2200 4600
$Comp
L Device:R R24
U 1 1 60CF7056
P 2800 4800
F 0 "R24" H 2870 4846 50  0000 L CNN
F 1 "4K7" H 2870 4755 50  0000 L CNN
F 2 "" V 2730 4800 50  0001 C CNN
F 3 "~" H 2800 4800 50  0001 C CNN
	1    2800 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 4600 2200 4650
Wire Wire Line
	2500 4950 2800 4950
Connection ~ 2500 4950
$Comp
L power:GND #PWR0108
U 1 1 60CF7066
P 2200 4950
F 0 "#PWR0108" H 2200 4700 50  0001 C CNN
F 1 "GND" H 2205 4777 50  0000 C CNN
F 2 "" H 2200 4950 50  0001 C CNN
F 3 "" H 2200 4950 50  0001 C CNN
	1    2200 4950
	1    0    0    -1  
$EndComp
Connection ~ 2200 4950
Wire Wire Line
	1900 4500 1900 3800
$Comp
L Connector_Generic:Conn_01x03 J1
U 1 1 60D2E079
P 1700 3700
F 0 "J1" H 1700 4050 50  0000 C CNN
F 1 "PHONO" H 1650 3950 50  0000 C CNN
F 2 "" H 1700 3700 50  0001 C CNN
F 3 "~" H 1700 3700 50  0001 C CNN
	1    1700 3700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2800 3700 2500 3700
Connection ~ 2800 3700
$Comp
L Connector_Generic:Conn_01x03 J4
U 1 1 60D48F20
P 4500 3700
F 0 "J4" H 4580 3742 50  0000 L CNN
F 1 "SPEAKER" H 4580 3651 50  0000 L CNN
F 2 "" H 4500 3700 50  0001 C CNN
F 3 "~" H 4500 3700 50  0001 C CNN
	1    4500 3700
	1    0    0    -1  
$EndComp
Connection ~ 4300 3800
Wire Wire Line
	4300 3600 4300 3450
Wire Wire Line
	4300 3450 4550 3450
Wire Wire Line
	4550 3450 4550 1400
Wire Wire Line
	4550 1400 4300 1400
Connection ~ 4300 1400
$Comp
L Connector_Generic:Conn_01x03 J2
U 1 1 60D842CA
P 2200 3000
F 0 "J2" H 2300 2900 50  0000 C CNN
F 1 "LINE OUT" H 2200 2800 50  0000 C CNN
F 2 "" H 2200 3000 50  0001 C CNN
F 3 "~" H 2200 3000 50  0001 C CNN
	1    2200 3000
	-1   0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x05 J3
U 1 1 60DF561F
P 2800 3000
F 0 "J3" H 2650 2700 50  0000 L CNN
F 1 "VOLUME" H 2600 2600 50  0000 L CNN
F 2 "" H 2800 3000 50  0001 C CNN
F 3 "~" H 2800 3000 50  0001 C CNN
	1    2800 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 2900 2600 2900
Wire Wire Line
	3100 3100 2600 3100
Wire Wire Line
	2600 3000 2500 3000
Wire Wire Line
	2500 3000 2500 3700
Connection ~ 2500 3700
Wire Wire Line
	2500 3700 1900 3700
Wire Wire Line
	2400 3000 2500 3000
Connection ~ 2500 3000
Wire Wire Line
	2400 3100 2400 3200
Wire Wire Line
	2400 3200 2600 3200
Wire Wire Line
	2400 2900 2400 2800
Wire Wire Line
	2400 2800 2600 2800
Wire Wire Line
	3100 3400 3100 5300
Wire Wire Line
	2950 4100 2950 4600
Wire Wire Line
	2950 4600 2800 4600
Wire Wire Line
	2800 4600 2800 4650
Connection ~ 2800 4600
Wire Wire Line
	2800 2200 2800 2250
Wire Wire Line
	2800 2250 3100 2250
Connection ~ 2800 2250
Wire Wire Line
	3100 2550 3100 2800
Wire Wire Line
	3100 2800 2600 2800
Connection ~ 2600 2800
Wire Wire Line
	2600 3200 2950 3200
Wire Wire Line
	2950 3200 2950 3800
Connection ~ 2600 3200
$EndSCHEMATC
