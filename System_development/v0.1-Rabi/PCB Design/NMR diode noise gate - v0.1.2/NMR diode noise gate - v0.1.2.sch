EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Diode Gate 3"
Date ""
Rev "v01"
Comp ""
Comment1 "ARTS Lab"
Comment2 "University of South Carolina"
Comment3 "Jacob Martin"
Comment4 ""
$EndDescr
$Comp
L Diode:1N4148 D1
U 1 1 5F7D32C9
P 5100 3500
F 0 "D1" H 5100 3716 50  0000 C CNN
F 1 "1N4148" H 5100 3625 50  0000 C CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 5100 3325 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5100 3500 50  0001 C CNN
	1    5100 3500
	1    0    0    -1  
$EndComp
$Comp
L Diode:1N4148 D2
U 1 1 5F7D502D
P 5100 3700
F 0 "D2" H 5000 3650 50  0000 C CNN
F 1 "1N4148" H 5100 3800 50  0000 C CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 5100 3525 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5100 3700 50  0001 C CNN
	1    5100 3700
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D4
U 1 1 5F7D5698
P 5700 3700
F 0 "D4" H 5800 3650 50  0000 C CNN
F 1 "1N4148" H 5650 3800 50  0000 C CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 5700 3525 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5700 3700 50  0001 C CNN
	1    5700 3700
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D3
U 1 1 5F7D7339
P 5700 3500
F 0 "D3" H 5700 3716 50  0000 C CNN
F 1 "1N4148" H 5700 3625 50  0000 C CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 5700 3325 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5700 3500 50  0001 C CNN
	1    5700 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5F7D7E91
P 5400 3850
F 0 "R1" H 5450 3850 50  0000 L CNN
F 1 "10k" V 5400 3800 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5330 3850 50  0001 C CNN
F 3 "~" H 5400 3850 50  0001 C CNN
	1    5400 3850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5F7D9723
P 4750 4100
F 0 "#PWR0101" H 4750 3850 50  0001 C CNN
F 1 "GND" H 4755 3927 50  0000 C CNN
F 2 "" H 4750 4100 50  0001 C CNN
F 3 "" H 4750 4100 50  0001 C CNN
	1    4750 4100
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J1
U 1 1 5F7D9DF6
P 4750 3600
F 0 "J1" H 4900 3600 50  0000 C CNN
F 1 "Conn_Coaxial" H 5050 3500 50  0000 C CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 4750 3600 50  0001 C CNN
F 3 " ~" H 4750 3600 50  0001 C CNN
	1    4750 3600
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J2
U 1 1 5F7DBDE1
P 6050 3600
F 0 "J2" H 6150 3575 50  0000 L CNN
F 1 "Conn_Coaxial" H 6150 3484 50  0000 L CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 6050 3600 50  0001 C CNN
F 3 " ~" H 6050 3600 50  0001 C CNN
	1    6050 3600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5F7DCE58
P 5400 4100
F 0 "#PWR0102" H 5400 3850 50  0001 C CNN
F 1 "GND" H 5405 3927 50  0000 C CNN
F 2 "" H 5400 4100 50  0001 C CNN
F 3 "" H 5400 4100 50  0001 C CNN
	1    5400 4100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5F7DD0BB
P 6050 4100
F 0 "#PWR0103" H 6050 3850 50  0001 C CNN
F 1 "GND" H 6055 3927 50  0000 C CNN
F 2 "" H 6050 4100 50  0001 C CNN
F 3 "" H 6050 4100 50  0001 C CNN
	1    6050 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 3800 4750 4100
Wire Wire Line
	4950 3600 4950 3500
Wire Wire Line
	4950 3700 4950 3600
Connection ~ 4950 3600
Wire Wire Line
	5850 3500 5850 3600
Wire Wire Line
	5850 3700 5850 3600
Connection ~ 5850 3600
Wire Wire Line
	5400 4000 5400 4100
Wire Wire Line
	6050 3800 6050 4100
Wire Wire Line
	5250 3500 5250 3600
Wire Wire Line
	5550 3500 5550 3600
Wire Wire Line
	5250 3600 5400 3600
Wire Wire Line
	5400 3600 5400 3700
Connection ~ 5250 3600
Wire Wire Line
	5250 3600 5250 3700
Wire Wire Line
	5400 3600 5550 3600
Connection ~ 5400 3600
Connection ~ 5550 3600
Wire Wire Line
	5550 3600 5550 3700
$EndSCHEMATC
