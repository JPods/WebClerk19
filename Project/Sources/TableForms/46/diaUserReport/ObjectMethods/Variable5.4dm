//Key_SetEnter 
If (Size of array:C274(aRptLines)>0)
	ACCEPT:C269
	myOK:=1
Else 
	ALERT:C41("You must select the layout to be printed.")
End if 