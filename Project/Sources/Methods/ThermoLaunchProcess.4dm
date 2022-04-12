//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-09T00:00:00, 10:45:08
// ----------------------------------------------------
// Method: ProgressThermoLaunch
// Description
// Modified: 01/09/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

<>vConnectionStatus:="Checking heart_beat"
vWindowCurrent:=Current form window:C827
<>ProcThermoProcess:=New process:C317("Thermo_Process"; 16*1024; "Progress"; <>vConnectionStatus)
SET PROCESS VARIABLE:C370(<>ProcThermoProcess; vNewThermometerTitle; <>vConnectionStatus)
POST OUTSIDE CALL:C329(<>ProcThermoProcess)

