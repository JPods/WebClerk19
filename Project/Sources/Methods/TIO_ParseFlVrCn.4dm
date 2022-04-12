//%attributes = {"publishedWeb":true}
C_POINTER:C301($0)  //Resulting pointer to a Variable/Field/String Constant
C_POINTER:C301($1)  //pointer to Info from a Row of a TextIO Doc
$0:=<>cptNilPoint
Case of 
	: ($1->[[1]]="[")  //field
		$0:=TIO_ParseField($1)
	: ($1->[[1]]=Char:C90(34))  //Char(34)="; "Constant String"
		C_LONGINT:C283($len)
		$len:=Length:C16($1->)
		If ($1->[[$len]]=Char:C90(34))
			$0:=TIO_ParseText($1)
		End if 
	Else   //assume variable    
		$0:=TIO_ParseVar($1)
End case 