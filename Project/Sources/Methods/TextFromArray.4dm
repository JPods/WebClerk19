//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-27T00:00:00, 02:11:12
// ----------------------------------------------------
// Method: TextFromArray
// Description
// Modified: 08/27/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptArray)
C_TEXT:C284($vtDelimiter)
$vtDelimiter:="\r"
If (Count parameters:C259>=2)
	C_TEXT:C284($2)
	$vtDelimiter:=$2
End if 
C_LONGINT:C283($i; $k)
C_TEXT:C284($outPut; $line)
$ptArray:=$1
$k:=Size of array:C274($ptArray->)
For ($i; 1; $k)
	$line:=$ptArray->{$i}
	$outPut:=$outPut+$line+$vtDelimiter
End for 
$0:=$outPut