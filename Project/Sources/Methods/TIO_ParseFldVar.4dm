//%attributes = {"publishedWeb":true}
C_POINTER:C301($0)  //Resulting pointer to a Variable/Field
C_POINTER:C301($1)  //pointer to Info from a Row of a TextIO Doc
$0:=<>cptNilPoint
Case of 
	: ($1->[[1]]="[")  //field
		$0:=TIO_ParseField($1)
	Else   //assume variable    
		$0:=TIO_ParseVar($1)
End case 