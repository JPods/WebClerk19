//%attributes = {"publishedWeb":true}
If (aiLineAction>0)
	ptLineRec:=->aiLineAction
	IV_VarRay(False:C215)
	jCenterWindow(550; 590; 1)
	DIALOG:C40([Order:3]; "ItemDetails")
	CLOSE WINDOW:C154
	If (myOK=1)
		IV_VarRay(True:C214)
		vMod:=True:C214
	Else 
		IV_VarRay(False:C215)
	End if 
	vLineMod:=True:C214
	jNxPvButtonSet
Else 
	jAlertMessage(9209)
End if 