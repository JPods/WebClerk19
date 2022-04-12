//%attributes = {"publishedWeb":true}
//Procedure: Txt_CaseAll(2;0)
C_TEXT:C284($theResult)
C_POINTER:C301($ptFile)
C_LONGINT:C283($1; $2)
C_TEXT:C284($setCase)
$fileNum:=0
$theCase:=0
Case of 
	: ((Count parameters:C259=0) & (vHere>0))
		$fileNum:=Table:C252(ptCurTable)
		$ptFile:=ptCurTable
	: (Count parameters:C259>0)
		$fileNum:=$1
		$ptFile:=Table:C252($1)
End case 
If (Count parameters:C259<2)
	$theCase:=0
	$setCase:="Sentence Case"
Else 
	$theCase:=$2
	Case of 
		: ($2=1)
			$setCase:="Lower Case"
		: ($2=2)
			$setCase:="Upper Case"
		Else 
			$setCase:="Sentence Case"
	End case 
End if 
C_LONGINT:C283($i; $k; $fieldCnt; $fieldIndex; $theCase; $fileNum; $theType)
If ($fileNum=0)
	ALERT:C41("Set file choice pointer.")
Else 
	CONFIRM:C162("Set all fields "+Table name:C256($fileNum)+" to "+$setCase)
	If (OK=1)
		FIRST RECORD:C50($ptFile->)
		$k:=Records in selection:C76($ptFile->)
		$fieldCnt:=Get last field number:C255($ptFile)
		For ($i; 1; $k)
			For ($fieldIndex; 1; $fieldCnt)
				$theType:=Type:C295(Field:C253($fileNum; $fieldIndex)->)
				If (($theType=0) | ($theType=2))
					Case of 
						: (Field name:C257(Field:C253($fileNum; $fieldIndex))="email")
							Txt_CaseLower(Field:C253($fileNum; $fieldIndex))
						: ($theCase=1)
							Txt_CaseLower(Field:C253($fileNum; $fieldIndex))
						: ($theCase=2)
							Txt_CaseUpper(Field:C253($fileNum; $fieldIndex))
						Else 
							Txt_CaseSentenc(Field:C253($fileNum; $fieldIndex))
					End case 
				End if 
			End for 
			SAVE RECORD:C53($ptFile->)
			NEXT RECORD:C51($ptFile->)
		End for 
	End if 
End if 