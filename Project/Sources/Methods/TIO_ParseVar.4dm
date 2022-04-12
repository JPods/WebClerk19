//%attributes = {"publishedWeb":true}
C_POINTER:C301($0)  //Resulting pointer to a Variable
C_POINTER:C301($1; $VarPtr)  //pointer to Info from a Variable Row of a TextOut Doc
$0:=<>cptNilPoint
C_LONGINT:C283($len; $IPVar)
$len:=Length:C16($1->)
$IPVar:=Num:C11($1->[[1]]="<>")+1  //((0 or1)+1)=1 or 2: 1st char of var name
If ($len-$IPVar<=10)  //$len-((0 or1)+1)<=11-1: is len <= 11 or len <= 12 and is IP
	If (($1->[[$IPVar]]>="A") & ($1->[[$IPVar]]<="Z"))
		$VarPtr:=Get pointer:C304($1->)
		If (Not:C34(Is nil pointer:C315($VarPtr)))
			If (Is a variable:C294($VarPtr))
				C_LONGINT:C283($Type)
				$Type:=Type:C295($VarPtr->)
				If ((($Type#3) & ($Type#5) & ($Type#7) & ($Type<13)) | ($Type=24))
					$0:=$VarPtr
				End if 
			End if 
		End if 
	End if 
End if 