//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/04/11, 08:07:45
// ----------------------------------------------------
// Method: Thermo_Update
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20180629_1147 added the ability to pass vNewThemoTitle
//  // ### jwm ### 20180629_1148 removed limit on thermo updates


Case of 
	: (allowAlerts_boo=False:C215)
		//no action
	: (Application type:C494=4D Server:K5:6)  //04/29/03.prf
		
	: (Application type:C494#4D Server:K5:6)  //04/29/03.prf
		
		C_LONGINT:C283($1; $NewThermoCount; $ReturnedThermoCount; $FailSafe; $NewThermometer; $test; $Increment)
		C_BOOLEAN:C305(vNewThermoAbort; $ThermoAbort)
		C_TEXT:C284($2; $vNewThermoTitle)
		
		If (Count parameters:C259>=2)
			$vNewThermoTitle:=$2
		Else 
			$vNewThermoTitle:=""
		End if 
		
		
		$NewThermoCount:=$1
		$ReturnedThermoCount:=0
		$FailSafe:=0
		$viProgress:=0
		
		$NewThermometer:=Round:C94(($NewThermoCount/vNewThermoTotal*100); 0)
		$Increment:=0  //update increment (out of 100), smaller number = more thermo updates
		//$NewThermometer:=($NewThermoCount*100)/vNewThermoTotal  //vNewThermoTotal is set in ThermoInitExit to determine the total to be used.
		$test:=vOldThermometer+$Increment  //vOldThermometer is initialized in ThermoInitExit
		If ($NewThermometer>$test)
			
			If (<>ProcThermoProcess>0)
				SET PROCESS VARIABLE:C370(<>ProcThermoProcess; vNewThermometer; $NewThermometer)
				// if new title is passed in update the title    // ### jwm ### 20180629_1147
				If ($vNewThermoTitle#"")
					SET PROCESS VARIABLE:C370(<>ProcThermoProcess; vNewThermoTitle; $vNewThermoTitle)
				End if 
				//SET PROCESS VARIABLE (process; dstVar; expr{; dstVar2; expr2; ...; dstVarN; exprN})
				//vNewThermometer in the remote process, <>ProcThermoProcess (Thermometer dialog) is changed by $NewThermometer in this process
				POST OUTSIDE CALL:C329(<>ProcThermoProcess)  // vNewThermometer is set to zero
				
				If (True:C214)  /// test 
					While (($ReturnedThermoCount#-1) & ($FailSafe<1000) & (<>ThermoAbort=False:C215))
						GET PROCESS VARIABLE:C371(<>ProcThermoProcess; vNewThermometer; $ReturnedThermoCount; vNewThermoAbort; $ThermoAbort)
						//vNewThermometer in the  remote process changes $ReturnedThermoCount to -1 in this process of communications was completed
						//GET PROCESS VARIABLE (process; srcVar; dstVar{; srcVar2; dstVar2; ...; srcVarN; dstVarN})
						//example of passing variables between processes
						IDLE:C311
						DELAY PROCESS:C323(Current process:C322; 2)  // Pause
						$FailSafe:=$FailSafe+1
					End while 
					ConsoleMessage("FaileSafe: "+String:C10($FailSafe))
				End if 
				
			End if 
			vOldThermometer:=$NewThermometer  //reset the old counter value to the new marker on the Thermometer
		End if 
End case 
