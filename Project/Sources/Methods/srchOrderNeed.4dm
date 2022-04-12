//%attributes = {"publishedWeb":true}
jBetweenDates("Enter period for Order Need Dates.")
C_LONGINT:C283(vHere)
C_POINTER:C301(ptCurTable)
If (Is nil pointer:C315(ptCurTable))
	ptCurTable:=(->[Order:3])
End if 
If (OK=1)  //Only allow at vHere=0
	If (vHere>=2)
		If (Modified record:C314(ptCurTable->))  //NO CANCEL
			myCycle:=6
			jAcceptButton
		End if 
	End if 
	QUERY:C277([Order:3]; [Order:3]dateNeeded:5>=vdDateBeg; *)
	QUERY:C277([Order:3];  & [Order:3]dateNeeded:5<=vdDateEnd)
	ProcessTableOpen(->[Order:3])
End if 