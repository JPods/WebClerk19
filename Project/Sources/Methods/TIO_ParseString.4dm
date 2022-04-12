//%attributes = {"publishedWeb":true}
C_POINTER:C301($0)  //Resulting pointer to a String Variable/Field/Constant
C_POINTER:C301($1)  //pointer to Info from a Row of a TextIO Doc
C_POINTER:C301($Ptr)
$0:=<>cptNilPoint
Case of 
	: ($1->[[1]]="[")  //[File]Field
		$Ptr:=TIO_ParseField($1)
		If (Not:C34(Is nil pointer:C315($Ptr)))
			$Type:=Type:C295($Ptr->)
			If (($Type=0) | ($Type=2) | ($Type=24))
				$0:=$Ptr
			End if 
		End if 
	: ($1->[[1]]=Char:C90(34))  //Char(34)="; "Constant String"
		C_LONGINT:C283($len)
		$len:=Length:C16($1->)
		If ($1->[[$len]]=Char:C90(34))
			$0:=TIO_ParseText($1)
		End if 
	Else   //assume variable    
		$Ptr:=TIO_ParseVar($1)
		If (Not:C34(Is nil pointer:C315($Ptr)))
			$Type:=Type:C295($Ptr->)
			If (($Type=0) | ($Type=2) | ($Type=24))
				$0:=$Ptr
			End if 
		End if 
End case 