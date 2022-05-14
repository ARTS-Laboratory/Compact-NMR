EESchema Schematic File Version 4
EELAYER 30 0
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
L Device:L L1
U 1 1 5FC9829B
P 5200 3600
F 0 "L1" V 5390 3600 50  0000 C CNN
F 1 "L" V 5299 3600 50  0000 C CNN
F 2 "Inductor_THT:L_Axial_L5.3mm_D2.2mm_P7.62mm_Horizontal_Vishay_IM-1" H 5200 3600 50  0001 C CNN
F 3 "~" H 5200 3600 50  0001 C CNN
	1    5200 3600
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C1
U 1 1 5FC9899A
P 4850 3750
F 0 "C1" H 4965 3796 50  0000 L CNN
F 1 "C" H 4965 3705 50  0000 L CNN
F 2 "Capacitor_SMD:C_1210_3225Metric_Pad1.33x2.70mm_HandSolder" H 4888 3600 50  0001 C CNN
F 3 "~" H 4850 3750 50  0001 C CNN
	1    4850 3750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5FC9982A
P 5550 3750
F 0 "C2" H 5665 3796 50  0000 L CNN
F 1 "C" H 5665 3705 50  0000 L CNN
F 2 "Capacitor_SMD:C_1210_3225Metric_Pad1.33x2.70mm_HandSolder" H 5588 3600 50  0001 C CNN
F 3 "~" H 5550 3750 50  0001 C CNN
	1    5550 3750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5FC99FAF
P 5200 3900
F 0 "#PWR0101" H 5200 3650 50  0001 C CNN
F 1 "GND" H 5205 3727 50  0000 C CNN
F 2 "" H 5200 3900 50  0001 C CNN
F 3 "" H 5200 3900 50  0001 C CNN
	1    5200 3900
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J2
U 1 1 5FC9AC20
P 6500 3600
F 0 "J2" H 6600 3575 50  0000 L CNN
F 1 "Conn_Coaxial" H 6600 3484 50  0000 L CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 6500 3600 50  0001 C CNN
F 3 " ~" H 6500 3600 50  0001 C CNN
	1    6500 3600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J1
U 1 1 5FC9CEE4
P 4400 3600
F 0 "J1" H 4328 3838 50  0000 C CNN
F 1 "Conn_Coaxial" H 4328 3747 50  0000 C CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 4400 3600 50  0001 C CNN
F 3 " ~" H 4400 3600 50  0001 C CNN
	1    4400 3600
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4400 3800 4400 3900
Wire Wire Line
	4400 3900 4850 3900
Wire Wire Line
	4850 3900 5200 3900
Connection ~ 4850 3900
Wire Wire Line
	5200 3900 5550 3900
Connection ~ 5200 3900
Wire Wire Line
	5350 3600 5550 3600
Wire Wire Line
	5050 3600 4850 3600
Wire Wire Line
	4600 3600 4850 3600
Connection ~ 4850 3600
Wire Wire Line
	6500 3800 6500 3900
Connection ~ 5550 3900
Connection ~ 5550 3600
$Comp
L Diode:1N4148 D1
U 1 1 5FCA388A
P 5850 3750
F 0 "D1" V 5804 3830 50  0000 L CNN
F 1 "1N4148" V 5895 3830 50  0000 L CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 5850 3575 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5850 3750 50  0001 C CNN
	1    5850 3750
	0    1    1    0   
$EndComp
$Comp
L Diode:1N4148 D2
U 1 1 5FCA4757
P 6100 3750
F 0 "D2" V 6146 3670 50  0000 R CNN
F 1 "1N4148" V 6055 3670 50  0000 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 6100 3575 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 6100 3750 50  0001 C CNN
	1    6100 3750
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5550 3900 5850 3900
Wire Wire Line
	5550 3600 5850 3600
Connection ~ 5850 3600
Wire Wire Line
	5850 3600 6100 3600
Connection ~ 5850 3900
Wire Wire Line
	5850 3900 6100 3900
Connection ~ 6100 3900
Wire Wire Line
	6100 3900 6500 3900
Connection ~ 6100 3600
Wire Wire Line
	6100 3600 6300 3600
$EndSCHEMATC
