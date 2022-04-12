$errorMessage:=""
If (vbNegScan=0)
	PKBarCodeReceive
Else 
	$errorMessage:="Line with quantity not selected."
	If (Size of array:C274(aLiLoadItemSelect)>0)
		If (Size of array:C274(aLiLineID)>0)
			If (vsBarCdFld=aLiItemNum{aLiLoadItemSelect{1}})
				PKShredItem
			Else 
				$errorMessage:="Item does not match."
			End if 
		End if 
	End if 
End if 
If ($errorMessage#"")
	ALERT:C41($errorMessage)
End if 

