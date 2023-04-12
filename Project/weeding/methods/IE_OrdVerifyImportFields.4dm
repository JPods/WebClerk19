//%attributes = {"publishedWeb":true}
//Method: PM:  IE_OrdVerifyImportFields
//Noah Dykoski   May 3, 2000 / 11:48 PM
C_BOOLEAN:C305($0)  //true if all names verified
C_TEXT:C284($1; $HeaderRow)  //tab delimited text with field and special names
$HeaderRow:=$1
C_LONGINT:C283($2; $ImportTableNum)
$ImportTableNum:=$2
C_POINTER:C301($3; $FieldArrayPtr)  //the resulting field and special vars that go with each name in the header
$FieldArrayPtr:=$3
C_POINTER:C301($4; $SpecialNamesArrayPtr)  //list of names that can appear in the header that are not field names
$SpecialNamesArrayPtr:=$4
C_POINTER:C301($5; $SpecialVarsArrayPtr)  //list of variable pointers that map one to one with each special name
$SpecialVarsArrayPtr:=$5

ARRAY TEXT:C222($asFieldNames; 0)

If ($HeaderRow#"")
	
	$iImportFieldCount:=Txt_GetCharacterCount($HeaderRow; Char:C90(9))+1  //count the tabs in this chunk of text
	
	C_LONGINT:C283($i)
	For ($i; 1; $iImportFieldCount)
		
		INSERT IN ARRAY:C227($asFieldNames; $i)
		
		If ($i=$iImportFieldCount)
			$asFieldNames{$i}:=$HeaderRow
		Else 
			$asFieldNames{$i}:=Substring:C12($HeaderRow; 1; Position:C15(Char:C90(Tab:K15:37); $HeaderRow)-1)
		End if 
		
		$HeaderRow:=Substring:C12($HeaderRow; Position:C15(Char:C90(Tab:K15:37); $HeaderRow)+1)  //delete section from full text                    
		
	End for 
	
	C_LONGINT:C283($soa)
	$soa:=Size of array:C274($asFieldNames)
	ARRAY POINTER:C280($FieldArrayPtr->; $soa)
	
	$0:=True:C214
	C_TEXT:C284(vtFieldName)
	For ($i; 1; $soa)
		$fia:=Find in array:C230($SpecialNamesArrayPtr->; $asFieldNames{$i})
		If ($fia=-1)
			vtFieldName:="["+Table name:C256($ImportTableNum)+"]"+$asFieldNames{$i}
			$FieldArrayPtr->{$i}:=TIO_ParseField(->vtFieldName)
		Else 
			$FieldArrayPtr->{$i}:=$SpecialVarsArrayPtr->{$fia}
		End if 
		If (Is nil pointer:C315($FieldArrayPtr->{$i}))
			$i:=999999999  //terminate
			$0:=False:C215
		End if 
	End for 
	
End if   //Clipped text not empty