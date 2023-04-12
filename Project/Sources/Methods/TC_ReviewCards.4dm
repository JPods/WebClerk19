//%attributes = {"publishedWeb":true}
If (UserInPassWordGroup("Control"))
	C_LONGINT:C283($found)
	$found:=Prs_CheckRunnin("Time_Review")
	//
	If ($found>0)
		BRING TO FRONT:C326($found)
		
		If (vHere=0)  //calling menu doubles the menus
			//MENU BAR(7;<>aPrsNum{$found})
		End if 
	Else 
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("TC_ReviewWindow"; <>tcPrsMemory; "Time_Review")
	End if 
	
	
End if 




