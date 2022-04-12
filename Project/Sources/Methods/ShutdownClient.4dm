//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/12/19, 20:22:05
// ----------------------------------------------------
// Method: ShutdownClient
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TIME:C306(vhDelayShutdown; 1)

If (Count parameters:C259=1)
	
	vhDelayShutdown:=$1
	
Else 
	vhDelayShutdown:=?00:05:00?  // default client shutdown delay
End if 

$viReference:=Open form window:C675("shutdown"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("Shutdown")