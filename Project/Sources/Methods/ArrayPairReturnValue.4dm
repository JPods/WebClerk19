//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/27/19, 10:54:23
// ----------------------------------------------------
// Method: ArrayPairReturnValue
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $vtFind)
C_POINTER:C301($2; ptaName; $3; ptaValues; $4; ptVariable)
C_LONGINT:C283($fia)
ptaName:=$2
ptaValues:=$3
ptVariable:=$4
$fia:=Find in array:C230(ptaName->; $vtFind)
If ($fia>0)
	ptVariable->:=ptaValues->{$fia}
End if 