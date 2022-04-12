//%attributes = {"publishedWeb":true}
If (aoLineAction>0)
	ptLineRec:=->aoLineAction
	OR_VarRay(False:C215)
	$dateOrdd:=1
	jCenterWindow(550; 610; 1)
	DIALOG:C40([Order:3]; "ItemDetails")
	CLOSE WINDOW:C154
	If (myOK=1)
		OR_VarRay(True:C214)
		vMod:=True:C214
	Else 
		OR_VarRay(False:C215)
	End if 
	<>aTypeSale:=1
	pComment:=""
	vLineMod:=True:C214
	jNxPvButtonSet
Else 
	jAlertMessage(9209)
End if 