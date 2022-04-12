//%attributes = {"publishedWeb":true}
//Procedure: Editor_DupRays
C_LONGINT:C283($found)
$doChange:=(UserInPassWordGroup("UnlockRecord"))
If ($doChange)
	$found:=Prs_CheckRunnin("DuplicateEditor")
	//
	If (Count parameters:C259>0)
		
		//Procedure: Ed_DupOpenWin
		//Monday, November 9, 1998
		TRACE:C157
		C_LONGINT:C283($i)
		C_POINTER:C301($ptVar)
		If (<>prcControl=1)
			<>prcControl:=0
			
			WindowOpenTaskOffSets
			
			
			Process_InitLocal
			ptCurTable:=(->[Control:1])
		End if 
		ControlRecCheck
		
		
		FORM SET INPUT:C55([Control:1]; "DuplicateClean")
		ptCurTable:=(->[Control:1])
		ProcessTableOpen(->[Control:1]; "skip")
		
	Else 
		
		If ($found>0)
			If (Frontmost process:C327#<>aPrsNum{$found})
				BRING TO FRONT:C326(<>aPrsNum{$found})
			End if 
		Else 
			<>ptCurTable:=ptCurTable
			<>prcControl:=1
			<>processAlt:=New process:C317("Editor_DupRays"; <>tcPrsMemory; "DuplicateEditor")
		End if 
	End if 
Else 
	ALERT:C41("Access denied.")
End if 