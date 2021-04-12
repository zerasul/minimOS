EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "CPU board for DURANGO computer"
Date "2021-04-12"
Rev ""
Comp "@zuiko21"
Comment1 "(c) 2021 Carlos J. Santisteban"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CPU:MOS6502 U1
U 1 1 60743819
P 1800 2350
F 0 "U1" H 1800 3931 50  0000 C CNN
F 1 "65SC02" H 1800 3840 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm" H 1800 850 50  0001 C CNN
F 3 "http://archive.6502.org/datasheets/rockwell_r650x_r651x.pdf" H 1800 2350 50  0001 C CNN
	1    1800 2350
	1    0    0    -1  
$EndComp
$Comp
L Memory_RAM:62256 U2
U 1 1 6074461F
P 3950 2050
F 0 "U2" H 3950 3431 50  0000 C CNN
F 1 "62256" H 3950 3340 50  0000 C CNN
F 2 "" H 3950 2050 50  0001 C CNN
F 3 "http://www.6502.org/users/alexis/62256.pdf" H 3950 2050 50  0001 C CNN
	1    3950 2050
	1    0    0    -1  
$EndComp
$Comp
L Memory_EPROM:27C128 U3
U 1 1 60745512
P 5700 2000
F 0 "U3" H 5700 3281 50  0000 C CNN
F 1 "27C128" H 5700 3190 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm" H 5700 2000 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/devicedoc/11003L.pdf" H 5700 2000 50  0001 C CNN
	1    5700 2000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U4
U 1 1 6074706A
P 7200 1350
F 0 "U4" H 7200 1717 50  0000 C CNN
F 1 "74HC139" H 7200 1626 50  0000 C CNN
F 2 "" H 7200 1350 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 7200 1350 50  0001 C CNN
	1    7200 1350
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U4
U 2 1 607493A2
P 7200 2200
F 0 "U4" H 7200 2567 50  0000 C CNN
F 1 "74HC139" H 7200 2476 50  0000 C CNN
F 2 "" H 7200 2200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 7200 2200 50  0001 C CNN
	2    7200 2200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U5
U 1 1 60749982
P 7200 3100
F 0 "U5" H 7200 3467 50  0000 C CNN
F 1 "74HC139" H 7200 3376 50  0000 C CNN
F 2 "" H 7200 3100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 7200 3100 50  0001 C CNN
	1    7200 3100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U5
U 2 1 6074A28D
P 7200 3950
F 0 "U5" H 7200 4317 50  0000 C CNN
F 1 "74HC139" H 7200 4226 50  0000 C CNN
F 2 "" H 7200 3950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 7200 3950 50  0001 C CNN
	2    7200 3950
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4040 U10
U 1 1 6074C247
P 1750 5000
F 0 "U10" H 1750 5981 50  0000 C CNN
F 1 "4040" H 1750 5890 50  0000 C CNN
F 2 "" H 1750 5000 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/cd40/cd4020bms-24bms-40bms.pdf" H 1750 5000 50  0001 C CNN
	1    1750 5000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS30 U11
U 1 1 6074DD29
P 2800 5150
F 0 "U11" H 2800 5675 50  0000 C CNN
F 1 "74LS30" H 2800 5584 50  0000 C CNN
F 2 "" H 2800 5150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS30" H 2800 5150 50  0001 C CNN
	1    2800 5150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U6
U 1 1 6074F30E
P 7200 4850
F 0 "U6" H 7200 5217 50  0000 C CNN
F 1 "74HC139" H 7200 5126 50  0000 C CNN
F 2 "" H 7200 4850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 7200 4850 50  0001 C CNN
	1    7200 4850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS139 U6
U 2 1 6074FDAB
P 7250 5650
F 0 "U6" H 7250 6017 50  0000 C CNN
F 1 "74HC139" H 7250 5926 50  0000 C CNN
F 2 "" H 7250 5650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 7250 5650 50  0001 C CNN
	2    7250 5650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC245 U9
U 1 1 60754204
P 2600 6600
F 0 "U9" H 2600 7581 50  0000 C CNN
F 1 "74HC245" H 2600 7490 50  0000 C CNN
F 2 "" H 2600 6600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 2600 6600 50  0001 C CNN
	1    2600 6600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC374 U7
U 1 1 60755513
P 4200 6600
F 0 "U7" H 4200 7581 50  0000 C CNN
F 1 "74HC374" H 4200 7490 50  0000 C CNN
F 2 "" H 4200 6600 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/cd74hct374.pdf" H 4200 6600 50  0001 C CNN
	1    4200 6600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC74 U8
U 1 1 60756402
P 4100 4350
F 0 "U8" H 4100 4831 50  0000 C CNN
F 1 "74HC74" H 4100 4740 50  0000 C CNN
F 2 "" H 4100 4350 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 4100 4350 50  0001 C CNN
	1    4100 4350
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC74 U8
U 2 1 60756EC3
P 4150 5200
F 0 "U8" H 4150 5681 50  0000 C CNN
F 1 "74HC74" H 4150 5590 50  0000 C CNN
F 2 "" H 4150 5200 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 4150 5200 50  0001 C CNN
	2    4150 5200
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 60757DE7
P 5250 4250
F 0 "D1" H 5243 4466 50  0000 C CNN
F 1 "RED LED" H 5243 4375 50  0000 C CNN
F 2 "" H 5250 4250 50  0001 C CNN
F 3 "~" H 5250 4250 50  0001 C CNN
	1    5250 4250
	1    0    0    -1  
$EndComp
$Comp
L Oscillator:ACO-xxxMHz X1
U 1 1 60759190
P 1100 3950
F 0 "X1" H 756 3996 50  0000 R CNN
F 1 "1 MHz" H 756 3905 50  0000 R CNN
F 2 "Oscillator:Oscillator_DIP-14" H 1550 3600 50  0001 C CNN
F 3 "http://www.conwin.com/datasheets/cx/cx030.pdf" H 1000 3950 50  0001 C CNN
	1    1100 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP RN1
U 1 1 60787186
P 5550 5850
F 0 "RN1" H 6138 5877 50  0000 L CNN
F 1 "470" H 6138 5786 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP8" V 6225 5850 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 5550 5850 50  0001 C CNN
	1    5550 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 6079DBE5
P 5600 4400
F 0 "R1" H 5670 4446 50  0000 L CNN
F 1 "R" H 5670 4355 50  0000 L CNN
F 2 "" V 5530 4400 50  0001 C CNN
F 3 "~" H 5600 4400 50  0001 C CNN
	1    5600 4400
	1    0    0    -1  
$EndComp
$EndSCHEMATC
