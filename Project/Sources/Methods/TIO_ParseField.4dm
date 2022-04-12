//%attributes = {"publishedWeb":true}
C_POINTER:C301($0)  //Resulting pointer to a field
C_POINTER:C301($1)  //pointer to Info from a Field Row of a TextOut Doc
C_LONGINT:C283($Pos; $FileNum; $FieldNum)
$0:=<>cptNilPoint
$Pos:=Position:C15("]"; $1->)
If ($Pos>0)
	C_TEXT:C284($File; $Field)
	$File:=Substring:C12($1->; 2; $Pos-2)
	$Field:=Substring:C12($1->; $Pos+1)
	$FileNum:=Find in array:C230(<>aTIOTableNames; $File)
	If ($FileNum>0)
		$FileNum:=<>aTIOTableNums{$FileNum}
		//StructureFields ($FileNum)
		C_LONGINT:C283($numFields; $index)
		$numFields:=Get last field number:C255($FileNum)
		ARRAY TEXT:C222($aFields; $numFields)
		For ($index; 1; $numFields)  //Loop for fields
			$aFields{$index}:=Field name:C257($FileNum; $index)  //fill in field and type arrays
		End for 
		$FieldNum:=Find in array:C230($aFields; $Field)
		If ($FieldNum>0)
			C_POINTER:C301($FieldPtr)
			$FieldPtr:=Field:C253($FileNum; $FieldNum)
			C_LONGINT:C283($Type)
			$Type:=Type:C295($FieldPtr->)
			If ((($Type#3) & ($Type#5) & ($Type#7) & ($Type<13)) | ($Type=24))
				$0:=$FieldPtr
			End if 
		End if 
	End if 
End if 