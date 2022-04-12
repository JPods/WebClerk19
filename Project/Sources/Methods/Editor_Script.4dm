//%attributes = {"publishedWeb":true}
//Procedure: Editor_Script
//TRACE
C_LONGINT:C283($found)
$doChange:=(UserInPassWordGroup("UnlockRecord"))
If ($doChange)
	If (False:C215)  // allow multiple windows
		$found:=Prs_CheckRunnin("ScriptEditor")
		//
		
		// Modified by: William James (2013-12-14T00:00:00)
		// Changed to allow multiple ScriptEditors.
		$found:=0
		
		
		If ($found>0)
			If (Frontmost process:C327#<>aPrsNum{$found})
				BRING TO FRONT:C326(<>aPrsNum{$found})
			End if 
		Else 
		End if 
	End if 
	
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	//If (<>WriteHere)
	<>processAlt:=New process:C317("Ed_ScrptOpenWin"; <>tcPrsMemory; "ScriptEditor")
	
Else 
	ALERT:C41("Access denied.")
End if 