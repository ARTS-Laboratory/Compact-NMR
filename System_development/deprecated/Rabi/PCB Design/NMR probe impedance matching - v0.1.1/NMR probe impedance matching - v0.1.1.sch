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
U 1 1 5F88A2B3
P 6500 3600
F 0 "L1" H 6553 3646 50  0000 L CNN
F 1 "L" H 6553 3555 50  0000 L CNN
F 2 "L_Coil:L_Coil" H 6500 3600 50  0001 C CNN
F 3 "~" H 6500 3600 50  0001 C CNN
	1    6500 3600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 5F88B6DA
P 6250 3600
F 0 "C4" H 6150 3700 50  0000 L CNN
F 1 "C" H 6300 3500 50  0000 L CNN
F 2 "Capacitor_SMD:C_1210_3225Metric_Pad1.33x2.70mm_HandSolder" H 6288 3450 50  0001 C CNN
F 3 "~" H 6250 3600 50  0001 C CNN
	1    6250 3600
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Variable C3
U 1 1 5F88D25D
P 6000 3600
F 0 "C3" H 5900 3700 50  0000 L CNN
F 1 "C_Variable" H 5550 3500 50  0000 L CNN
F 2 "C_Trim_AP55HV:C_Trim_AP55HV" H 6000 3600 50  0001 C CNN
F 3 "~" H 6000 3600 50  0001 C CNN
	1    6000 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 3450 6000 3450
Wire Wire Line
	6500 3450 6250 3450
Connection ~ 6250 3450
Wire Wire Line
	6500 3750 6250 3750
Wire Wire Line
	6250 3750 6000 3750
Connection ~ 6250 3750
Connection ~ 6000 3750
Wire Wire Line
	6000 3750 5100 3750
$Comp
L power:GND #PWR01
U 1 1 5F899138
P 5100 3750
F 0 "#PWR01" H 5100 3500 50  0001 C CNN
F 1 "GND" H 5105 3577 50  0000 C CNN
F 2 "" H 5100 3750 50  0001 C CNN
F 3 "" H 5100 3750 50  0001 C CNN
	1    5100 3750
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J1
U 1 1 5F895230
P 5100 3450
F 0 "J1" V 5350 3550 50  0000 C CNN
F 1 "Conn_Coaxial" V 5250 3550 50  0000 C CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 5100 3450 50  0001 C CNN
F 3 " ~" H 5100 3450 50  0001 C CNN
	1    5100 3450
	-1   0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5F91F270
P 5600 3150
F 0 "C1" V 5550 3050 50  0000 C CNN
F 1 "C" V 5550 3250 50  0000 C CNN
F 2 "Capacitor_SMD:C_1210_3225Metric_Pad1.33x2.70mm_HandSolder" H 5638 3000 50  0001 C CNN
F 3 "~" H 5600 3150 50  0001 C CNN
	1    5600 3150
	0    1    1    0   
$EndComp
$Comp
L Device:C_Variable C2
U 1 1 5F88DBD1
P 5600 3450
F 0 "C2" V 5450 3450 50  0000 C CNN
F 1 "C_Variable" V 5700 3450 50  0000 C CNN
F 2 "C_Trim_5501:C_Trim_5501" H 5600 3450 50  0001 C CNN
F 3 "~" H 5600 3450 50  0001 C CNN
	1    5600 3450
	0    1    1    0   
$EndComp
Wire Wire Line
	5100 3650 5100 3750
Connection ~ 5100 3750
Wire Wire Line
	5750 3450 6000 3450
Connection ~ 6000 3450
Wire Wire Line
	5450 3450 5300 3450
Wire Wire Line
	5450 3150 5450 3450
Connection ~ 5450 3450
Wire Wire Line
	5750 3150 5750 3450
Connection ~ 5750 3450
$EndSCHEMATC
