//%attributes = {"publishedWeb":true}
If (UserInPassWordGroup("Control"))
	C_LONGINT:C283($found)
	$found:=Prs_CheckRunnin("Time_Review")
	//
	If ($found>0)
		If (Frontmost process:C327#<>aPrsNum{$found})
			BRING TO FRONT:C326(<>aPrsNum{$found})
		End if 
		If (vHere=0)  //calling menu doubles the menus
			//MENU BAR(7;<>aPrsNum{$found})
		End if 
	Else 
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("TC_ReviewWindow"; <>tcPrsMemory; "Time_Review")
	End if 
	
	If (False:C215)
		jsetDefaultFile(->[Item:4])
		C_LONGINT:C283($viProcess)
		$viProcess:=Current process:C322
		SET MENU BAR:C67(splashMenu; $viProcess; *)
		jSetAutoReMenus
		MESSAGES ON:C181
	End if 
	
End if 




