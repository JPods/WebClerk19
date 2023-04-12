//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2021-12-10T06:00:00Z)
// Method: Dept_Admin
// Description 
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($found)
If (Not:C34(Application type:C494=4D Server:K5:6))
	If (Count parameters:C259=1)
		Process_InitLocal
		var $obWindows : Object
		$obWindows:=WindowCountToShow
		$win_l:=Open form window:C675([Control:1]; "DeptAdmin"; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		DIALOG:C40([Control:1]; "DeptAdmin")
	Else 
		$found:=Prs_CheckRunnin("Dept Admin")
		If ($found>0)
			BRING TO FRONT:C326($found)
			
		Else 
			<>ptCurTable:=ptCurTable
			<>prcControl:=1
			<>processAlt:=New process:C317("Dept_Admin"; 0; "Dept Admin"; "openWindow")
		End if 
	End if 
End if 