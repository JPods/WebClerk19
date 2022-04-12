//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/27/18, 17:29:43
// ----------------------------------------------------
// Method: Tag_jit_FromNames
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($1; $tableName; $2; $fieldName)
C_TEXT:C284($3; $tagPurpose)
C_TEXT:C284($4; $format)

C_LONGINT:C283($tableNum; $fieldNum; $myOK)
If (Count parameters:C259<2)
	$0:="noValues"
Else 
	$0:="InvalidNames"
	$myOK:=0
	$tableName:=$1
	$tableNum:=STR_GetTableNumber($tableName)
	If ($tableNum>0)
		$fieldName:=$2
		$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
		If ($fieldNum>0)
			$tagPurpose:="_jit_"
			If (Count parameters:C259>2)
				$tagPurpose:=$3  //  "rjit_"
				If (Count parameters:C259>3)
					$format:=$4
				End if 
			End if 
			C_LONGINT:C283($typeFld; $lenField; $numFld; $k; $w; $tableNum)
			C_BOOLEAN:C305($indexed; $isUnique; $isInvisible)
			GET FIELD PROPERTIES:C258($tableNum; $fieldNum; $typeFld; $lenField; $indexed)  // file #, field #, type, length, index    
			Case of 
				: ($typeFld=Is picture:K8:10)
					$0:="Picture-noTag"
				: ($typeFld=Is BLOB:K8:12)  // no blobs or pictures
					$0:="Blob-noTag"
				Else 
					$0:=$tagPurpose+$tableName+"_"+$fieldName
					If (Length:C16($format)>0)
						// add formating tag
						$0:=$0+$format
					End if 
					$0:=$0+"jj"
			End case 
		End if 
	End if 
End if 
