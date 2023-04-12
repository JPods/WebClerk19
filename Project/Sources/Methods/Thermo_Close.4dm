//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/04/11, 20:17:45
// ----------------------------------------------------
// Method: Thermo_Close
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($ReturnedThermoCount; $FailSafe)
C_LONGINT:C283($start; $elapsed)

Case of 
	: (allowAlerts_boo=False:C215)
		//no action
	: (Application type:C494=4D Server:K5:6)  //04/29/03.prf
		
		
	: (Application type:C494#4D Server:K5:6)  //04/29/03.prf
		
		$ReturnedThermoCount:=0
		$FailSafe:=0
		
		If (<>ProcThermoProcess>0)
			$start:=Milliseconds:C459
			$elapsed:=Milliseconds:C459-$start
			// 10 second time out for testing
			While ((Process state:C330(<>ProcThermoProcess)#Aborted:K13:1) & ($elapsed<10000) & (<>ThermoAbort=False:C215))
				SET PROCESS VARIABLE:C370(<>ProcThermoProcess; vNewThermometer; -2)
				//setting vNewThermometer to -2 in the Thermo window cancel the window and closes the process
				POST OUTSIDE CALL:C329(<>ProcThermoProcess)
				DELAY PROCESS:C323(Current process:C322; 6)  // pause to allow Thermo to close
				IDLE:C311
				//$FailSafe:=$FailSafe+1
			End while 
			
			//If (Process state(<>ProcThermoProcess)=Aborted)
			//Console_Log ("Thermo Process Aborted")
			//Else 
			//Console_Log ("ERROR: Thermo Process NOT Aborted")
			//End if 
		End if 
End case 
