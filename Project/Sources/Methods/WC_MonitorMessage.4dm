//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-03T00:00:00, 14:22:53
// ----------------------------------------------------
// Method: WC_MonitorMessage
// Description
// Modified: 09/03/17
// 
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284(vDebugMessage)
SET PROCESS VARIABLE:C370(<>webMonitorProcess; vDebugMessage; $1)  //send to vDebugDisplay in WebClerkMonitor window
POST OUTSIDE CALL:C329(<>webMonitorProcess)  // vNewThermometer is set to zero
