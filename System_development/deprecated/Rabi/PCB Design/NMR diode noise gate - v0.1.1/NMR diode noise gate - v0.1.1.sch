EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Diode Noise Gate (Series Connection)"
Date ""
Rev "v01"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 "Author: Jacob Martin"
$EndDescr
$Comp
L Diode:1N4148 D1
U 1 1 5F765E51
P 5450 3800
F 0 "D1" H 5450 4016 50  0000 C CNN
F 1 "1N4148" H 5450 3925 50  0000 C CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 5450 3625 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5450 3800 50  0001 C CNN
	1    5450 3800
	1    0    0    -1  
$EndComp
$Comp
L Diode:1N4148 D2
U 1 1 5F76783E
P 5450 4050
F 0 "D2" H 5450 4150 50  0000 C CNN
F 1 "1N4148" H 5450 4250 50  0000 C CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 5450 3875 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5450 4050 50  0001 C CNN
	1    5450 4050
	-1   0    0    1   
$EndComp
$Comp
L Connector:Conn_Coaxial J1
U 1 1 5F7689B5
P 4950 4050
F 0 "J1" H 4878 4288 50  0000 C CNN
F 1 "Conn_Coaxial" H 4878 4197 50  0000 C CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 4950 4050 50  0001 C CNN
F 3 " ~" H 4950 4050 50  0001 C CNN
	1    4950 4050
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J2
U 1 1 5F76AB86
P 5950 4050
F 0 "J2" H 6050 4025 50  0000 L CNN
F 1 "Conn_Coaxial" H 6050 3934 50  0000 L CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132203-12_Horizontal" H 5950 4050 50  0001 C CNN
F 3 " ~" H 5950 4050 50  0001 C CNN
	1    5950 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 4050 5300 4050
Wire Wire Line
	5300 3800 5300 4050
Connection ~ 5300 4050
Wire Wire Line
	5600 3800 5600 4050
Wire Wire Line
	5600 4050 5750 4050
Connection ~ 5600 4050
$Comp
L power:GND #PWR0101
U 1 1 5F7BFC7F
P 4950 4350
F 0 "#PWR0101" H 4950 4100 50  0001 C CNN
F 1 "GND" H 4955 4177 50  0000 C CNN
F 2 "" H 4950 4350 50  0001 C CNN
F 3 "" H 4950 4350 50  0001 C CNN
	1    4950 4350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5F7C0354
P 5950 4350
F 0 "#PWR0102" H 5950 4100 50  0001 C CNN
F 1 "GND" H 5955 4177 50  0000 C CNN
F 2 "" H 5950 4350 50  0001 C CNN
F 3 "" H 5950 4350 50  0001 C CNN
	1    5950 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4950 4250 4950 4350
Wire Wire Line
	5950 4250 5950 4350
$EndSCHEMATC
