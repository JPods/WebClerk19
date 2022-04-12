//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/17/20, 23:50:47
// ----------------------------------------------------
// Method: DuplicatesBuild
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptTable; $2; $ptField; $3; $ptAField; $4; $ptARecNum; $5; $6; $7; $8; $9; $10; $11; $12)
$ptTable:=$1
$ptField:=$2
$ptAField:=$3
$ptARecNum:=$4

C_LONGINT:C283($incMore; $cntMore; $found)

$cntMore:=Records in selection:C76($ptTable->)

If ($cntMore>5)
	
	
End if 

C_LONGINT:C283($viRaySize)

If ($cntMore>0)
	FIRST RECORD:C50($ptTable->)
	For ($incMore; 1; $cntMore)
		If (Find in array:C230($ptARecNum->; Record number:C243($ptTable->))<1)
			APPEND TO ARRAY:C911($ptAField->; $ptField->)
			APPEND TO ARRAY:C911($ptARecNum->; Record number:C243($ptTable->))
			If (Count parameters:C259>5)
				APPEND TO ARRAY:C911($6->; $5->)
				If (Count parameters:C259>7)
					APPEND TO ARRAY:C911($8->; $7->)
					If (Count parameters:C259>9)
						APPEND TO ARRAY:C911($10->; $9->)
						If (Count parameters:C259>7)
							APPEND TO ARRAY:C911($12->; $11->)
						End if 
					End if 
				End if 
			End if 
		End if 
		NEXT RECORD:C51($ptTable->)
	End for 
End if 