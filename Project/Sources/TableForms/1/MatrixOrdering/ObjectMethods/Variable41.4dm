C_LONGINT:C283($w)
If (<>aPrsName>0)
	If ((Size of array:C274(<>aItemLines)>0) & (Size of array:C274(<>aLsSrRec)>0))
		$w:=Find in array:C230(<>aPrsName; <>aPrsName{<>aPrsName})
		<>bQQAddItems:=True:C214
		POST OUTSIDE CALL:C329(<>aPrsNum{$w})
	End if 
Else 
	<>aPrsName:=1
End if 