//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/04/15, 15:36:39
// ----------------------------------------------------
// Method: StartupTools
// Description
// Parameters 
// ----------------------------------------------------
// ### jwm ### 20141006_1138  Enable 4D PopUP component
If (Not:C34(Is compiled mode:C492))
	ARRAY TEXT:C222($tTxt_Components; 0)
	COMPONENT LIST:C1001($tTxt_Components)
	If (Find in array:C230($tTxt_Components; "4DPop")>0)
		EXECUTE METHOD:C1007("4DPop_Palette")
	End if 
	// Analysis Component
	EXECUTE METHOD:C1007("CA_ShowQuickLauncher")
End if 