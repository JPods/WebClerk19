If (Size of array:C274(aMatchField)>0)
	Sort_Build
	ExecuteText(0; vText1)
	vText1:=""
	booSorted:=True:C214
	CANCEL:C270
	myOK:=1
Else 
	ALERT:C41("Set Sort Criteria")
End if 