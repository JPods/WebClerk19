//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/04/11, 08:04:40
// ----------------------------------------------------
// Method: Thermo_Process
// Description
// 

// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; vNewThermoTitle)
vNewThermoTitle:=$1
C_LONGINT:C283(Thermometer; vNewThermometer)
Thermometer:=0
vNewThermometer:=0
C_BOOLEAN:C305(<>ThermoAbort; vNewThermoAbort)
<>ThermoAbort:=False:C215
vNewThermoAbort:=False:C215
//jCenterWindow (400;52;-1984;"Progress";"Wind_CloseBox")
$windH:=50

// Center
//size of thermometer form 
$viWinWidth:=410
$viWinHeight:=50
$viCenterHeight:=Screen height:C188/2
$viCenterWidth:=Screen width:C187/2
$viLeft:=$viCenterWidth-($viWinWidth/2)
$viRight:=$viLeft+$viWinWidth
$viTop:=$viCenterHeight-($viWinHeight/2)
$viBottom:=$viTop+$viWinHeight
viWinProgress:=Open window:C153($viLeft; $viTop; $viRight; $viBottom; 1984; "Progress"; "Wind_CloseBox")


//viWinThermo:=Open form window([Control];"Thermo";Palette form window;Horizontally centered;Vertically centered)

// Top Right
//Open window(Screen width-420;40;Screen width-10;$windH+40;-1984;"Messaging";"Wind_CloseBox")
DIALOG:C40([Control:1]; "Thermo"; *)

