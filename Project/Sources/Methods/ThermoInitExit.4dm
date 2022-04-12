//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/04/11, 08:32:11
// ----------------------------------------------------
// Method: ThermoInitExit
// Description
// 
//
// Parameters
//02/19/03.prf
//removed plugin ThermoSet
//TCStrong_prf_v144_ThermoSet 
//TCStrong_prf_v144_ThermoSRetok 
//04/29/03.prf
//added 4D Server protection
// ----------------------------------------------------
// Modified by: williamjames (110704) fixed <>ThermoAbort

C_TEXT:C284($1; $Message; $msgTop)
$Message:=$1
C_LONGINT:C283($2; vNewThermoTotal; vOldThermometer)
vNewThermoTotal:=$2
vOldThermometer:=0
<>ThermoAbort:=False:C215
C_BOOLEAN:C305($3; $FirstOne; $tryThis)
C_BOOLEAN:C305(vNewThermoAbort)
vNewThermoAbort:=False:C215
$newThermo:=$3
C_BOOLEAN:C305(allowAlerts_boo)  //must be set regardless
C_LONGINT:C283(<>ProcThermoProcess)
Case of 
	: (allowAlerts_boo=False:C215)
		//no action
	: (Application type:C494=4D Server:K5:6)  //04/29/03.prf
		C_LONGINT:C283(vlserverCount; vlserverIncrement)
		C_LONGINT:C283(vlserverReady)  // 0 nothing, 1 ready, 2 inprocess, 3 complete
		// the server starts at not ready 0
		// the server process launched and  ready 1
		// the server process running 2
		// the server process complete 3
		C_TEXT:C284(vtserverStatus)
	Else 
		
		//: (Application type#4D Server)  //04/29/03.prf
		If (vNewThermoTotal>2)  //ignor if there are very few records to cycle
			$vlProcessState:=Process state:C330(<>ProcThermoProcess)
			Thermometer:=0  //reset the counter to zero
			// ### jwm ### 20151001_1650 begin
			vifound:=Prs_CheckRunnin("Progress")
			If (vifound=0)
				$vlProcessState:=-1
			End if 
			// ### jwm ### 20151001_1650 end
			If ($vlProcessState>0)  //The process is already running, reset to zero and call it forward
				BRING TO FRONT:C326(<>ProcThermoProcess)
				POST OUTSIDE CALL:C329(<>ProcThermoProcess)
			Else 
				$msgTop:=$Message+":  "+String:C10(vNewThermoTotal)  //Top Message  
				<>ProcThermoProcess:=New process:C317("Thermo_Process"; 16*1024; "Progress"; $msgTop)
			End if 
			
		End if 
End case 


If (False:C215)
	
	Case of 
		: (allowAlerts_boo=False:C215)
			//no action
		: (Application type:C494#4D Server:K5:6)  //04/29/03.prf
			
			$vlProcessState:=Process state:C330(<>ProcThermoProcess)
			If ($vlProcessState>0)
				
			End if 
			If (vNewThermoTotal>5)  //must be here to clear an open thermo
				$msgTop:=$Message+":  Total "+String:C10(vNewThermoTotal)  //Top Message  
				If ($vlProcessState>0)
					BRING TO FRONT:C326(<>ProcThermoProcess)
					POST OUTSIDE CALL:C329(<>ProcThermoProcess)
				Else 
					<>ProcThermoProcess:=New process:C317("NewThermoProcess"; 16*1024; "ThermoProcess"; $msgTop)
				End if 
			End if 
			
	End case 
	
End if 





//C_TEXT($1;$msgTop;$msgBottom)
//C_LONGINT($2)
//C_BOOLEAN($3)
//C_LONGINT(thermoColor;thermoFill;thermoCan;thermoCtr;thermoIcon)
//C_BOOLEAN(thermoAbort)
//thermoColor:=8//0-8, black, red, green, blue, cyan, megenta, yellow, gray
// on blue, sys 7
//thermoFill:=1//0-1, 50% or 100% fill
//thermoCan:=0
//thermoCtr:=Current process
//
//If (Not($3))//must be here to clear an open external
//ThermoClose 
//End if 
//Tot:=$2//Records in selection([Invoice])  
//Ttl:=$1
//$msgTop:=$1+":  Total "+String($2)//Top Message  
//
////$msgBottom:="Press command-period to cancel"
//ThermoInit ($2;$msgTop)