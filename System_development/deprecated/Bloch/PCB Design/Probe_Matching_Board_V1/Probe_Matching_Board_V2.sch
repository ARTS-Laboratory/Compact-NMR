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
L Device:C_Variable C1
U 1 1 60BAB1FC
P 4750 3350
F 0 "C1" V 4498 3350 50  0000 C CNN
F 1 "C_Variable" V 4589 3350 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L7.0mm_W6.0mm_P5.00mm" H 4750 3350 50  0001 C CNN
F 3 "~" H 4750 3350 50  0001 C CNN
	1    4750 3350
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 60BAEB8D
P 4350 3650
F 0 "#PWR0101" H 4350 3400 50  0001 C CNN
F 1 "GND" H 4355 3477 50  0000 C CNN
F 2 "" H 4350 3650 50  0001 C CNN
F 3 "" H 4350 3650 50  0001 C CNN
	1    4350 3650
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J1
U 1 1 60BAF990
P 4350 3350
F 0 "J1" H 4278 3588 50  0000 C CNN
F 1 "Conn_Coaxial" H 4278 3497 50  0000 C CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 4350 3350 50  0001 C CNN
F 3 " ~" H 4350 3350 50  0001 C CNN
	1    4350 3350
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4350 3650 4350 3550
Wire Wire Line
	4550 3350 4600 3350
Connection ~ 4350 3650
$Comp
L Connector:Conn_Coaxial J2
U 1 1 60BB1BEC
P 6300 3350
F 0 "J2" H 6400 3325 50  0000 L CNN
F 1 "Conn_Coaxial" H 6400 3234 50  0000 L CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 6300 3350 50  0001 C CNN
F 3 " ~" H 6300 3350 50  0001 C CNN
	1    6300 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 3650 6300 3550
$Comp
L c_trim_3_leg:C_Trim_3_Leg C4
U 1 1 60BBC77B
P 5600 3500
F 0 "C4" H 5732 3571 50  0000 L CNN
F 1 "C_Trim_3_Leg" H 5732 3480 50  0000 L CNN
F 2 "C_Trim_GZD10100:C_Trim_GZD10100" H 5650 3600 50  0001 C CNN
F 3 "" H 5650 3600 50  0001 C CNN
	1    5600 3500
	1    0    0    -1  
$EndComp
Connection ~ 5600 3350
Wire Wire Line
	5600 3350 6100 3350
Wire Wire Line
	5550 3600 5550 3650
Connection ~ 5550 3650
Wire Wire Line
	5550 3650 5650 3650
Wire Wire Line
	5650 3600 5650 3650
Connection ~ 5650 3650
Wire Wire Line
	5650 3650 6300 3650
Wire Wire Line
	4900 3350 5600 3350
Wire Wire Line
	4350 3650 5550 3650
$EndSCHEMATC
