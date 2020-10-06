EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Diode Gate 2"
Date ""
Rev "v01"
Comp ""
Comment1 ""
Comment2 "ARTS Lab"
Comment3 "University of South Carolina"
Comment4 "Jacob Martin"
$EndDescr
$Comp
L Diode:1N4148 D2
U 1 1 5F7C0D01
P 6050 3700
F 0 "D2" V 6000 3750 50  0000 L CNN
F 1 "1N4148" V 5800 3550 50  0000 L CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 6050 3525 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 6050 3700 50  0001 C CNN
	1    6050 3700
	0    1    1    0   
$EndComp
$Comp
L Diode:1N4148 D1
U 1 1 5F7C1B2E
P 5850 3700
F 0 "D1" V 5900 3850 50  0000 R CNN
F 1 "1N4148" V 5550 3800 50  0000 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 5850 3525 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5850 3700 50  0001 C CNN
	1    5850 3700
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5F7C3264
P 6400 3850
F 0 "#PWR0101" H 6400 3600 50  0001 C CNN
F 1 "GND" H 6405 3677 50  0000 C CNN
F 2 "" H 6400 3850 50  0001 C CNN
F 3 "" H 6400 3850 50  0001 C CNN
	1    6400 3850
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J2
U 1 1 5F7C379F
P 6400 3550
F 0 "J2" H 6500 3525 50  0000 L CNN
F 1 "Conn_Coaxial" H 6500 3434 50  0000 L CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 6400 3550 50  0001 C CNN
F 3 " ~" H 6400 3550 50  0001 C CNN
	1    6400 3550
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J1
U 1 1 5F7C529E
P 5500 3550
F 0 "J1" H 5428 3788 50  0000 C CNN
F 1 "Conn_Coaxial" H 5428 3697 50  0000 C CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 5500 3550 50  0001 C CNN
F 3 " ~" H 5500 3550 50  0001 C CNN
	1    5500 3550
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5F7C60F9
P 5500 3850
F 0 "#PWR0102" H 5500 3600 50  0001 C CNN
F 1 "GND" H 5505 3677 50  0000 C CNN
F 2 "" H 5500 3850 50  0001 C CNN
F 3 "" H 5500 3850 50  0001 C CNN
	1    5500 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 3550 5850 3550
Wire Wire Line
	5850 3550 6050 3550
Connection ~ 5850 3550
Wire Wire Line
	6050 3550 6200 3550
Connection ~ 6050 3550
Wire Wire Line
	6400 3750 6400 3850
Wire Wire Line
	6050 3850 6400 3850
Connection ~ 6400 3850
Wire Wire Line
	6050 3850 5850 3850
Connection ~ 6050 3850
Wire Wire Line
	5500 3850 5850 3850
Connection ~ 5850 3850
Wire Wire Line
	5500 3850 5500 3750
Connection ~ 5500 3850
$EndSCHEMATC
