//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $r; $fieldNum)
C_TEXT:C284(vText1; $theField)
vText1:=""
//TRACE
$k:=Size of array:C274(aMatchField)
If ($k>0)
	$sortFile:="["+Table name:C256(curTableNum)+"]"
	vText1:="Order By("+$sortFile  //change 'Sort Selection' to 'Order By'
	For ($i; 1; $k)
		$r:=Find in array:C230(theFields; aMatchField{$i})
		If ($r#-1)
			$fieldNum:=theFldNum{$r}
			$theField:=Field name:C257(Field:C253(curTableNum; $fieldNum))
			If (aMatchType{$i}="A")  //Assending order
				vText1:=vText1+";"+$sortFile+$theField+";>"
			Else 
				vText1:=vText1+";"+$sortFile+$theField+";<"
			End if 
		End if 
	End for 
	vText1:=vText1+")"
End if 