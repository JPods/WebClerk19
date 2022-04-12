
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 07/20/18, 14:29:29
// ----------------------------------------------------
// Method: On Exit
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)
	C_LONGINT:C283($k; $incRec)
	$k:=60
	//ThermoInitExit ("Closing";$k;True)
	$viProgressID:=Progress New
	
	For ($incRec; 1; $k)
		//Thermo_Update ($incRec)
		ProgressUpdate($viProgressID; $incRec; $k; "Closing")
		DELAY PROCESS:C323(Current process:C322; 60)
	End for 
	
	Progress QUIT($viProgressID)
	
End if 
