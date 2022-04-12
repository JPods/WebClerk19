//KeyModifierCurrent 
//OK:=CmdKey
//If (OK=0)
//CONFIRM("There is NO 'UnDo' for this action")
//End if 
//If (OK=1)
//
//If (Records in set("UserSet")=0)
//ALERT("There must be records HIGHLIGHTED to identify the ones to be
// CHANGED.")
//$doThis:=False
//Else 
//CREATE SET(ptCurTable->;"Current")
//USE SET("UserSet")//select the highlighted records
//$doThis:=True
//End if 
//If ($doThis)
//C_LONGINT($i;$k)
//FIRST RECORD(ptCurTable->)
//$k:=Records in selection(ptCurTable->)
//ThermoInitExit ("Processing records";$k;True)
//For ($i;1;$k)
//ThermoUpdate ($i)
//If (<>thermoAbort)
//$i:=$k
//End if 
//If (Locked(ptCurTable->))
//BEEP
//BEEP
//MESSAGE("Record is locked.")
//Else 
//Field(ptCurTable;
//SAVE RECORD(ptCurTable->)
//End if 
//NEXT RECORD(ptCurTable->)
//End for 
//ThermoClose 
//End if 
//USE SET("Current")
//CLEAR SET("Current")//don't let the set hang around unnecessarily      
//  
//End if 
//
//
//
//End if 