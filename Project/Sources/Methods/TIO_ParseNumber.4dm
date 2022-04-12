//%attributes = {"publishedWeb":true}
C_POINTER:C301($0)  //Resulting pointer to a Number Variable/Field/Constant
C_POINTER:C301($1)  //pointer to Info from a Loop Begin Row of a TextIO Doc
C_POINTER:C301($Ptr)
$0:=<>cptNilPoint
Case of 
	: ($1->[[1]]="[")  //field
		$Ptr:=TIO_ParseField($1)
		If (Not:C34(Is nil pointer:C315($Ptr)))
			$Type:=Type:C295($Ptr->)
			If (($Type=1) | ($Type=8) | ($Type=9))
				$0:=$Ptr
			End if 
		End if 
	: (($1->[[1]]>="0") & ($1->[[1]]<="9"))  //Constant
		$soa:=Size of array:C274(aTIOInteger)+1
		INSERT IN ARRAY:C227(aTIOInteger; $soa)
		aTIOInteger{$soa}:=Num:C11($1->)
		$0:=->aTIOInteger{$soa}
	Else   //assume variable    
		$Ptr:=TIO_ParseVar($1)
		If (Not:C34(Is nil pointer:C315($Ptr)))
			$Type:=Type:C295($Ptr->)
			If (($Type=1) | ($Type=8) | ($Type=9))
				$0:=$Ptr
			End if 
		End if 
End case 