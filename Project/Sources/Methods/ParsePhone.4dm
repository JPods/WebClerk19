//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/02/10, 14:03:32
// ----------------------------------------------------
// Method: ParsePhone
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $3; $Code)
C_LONGINT:C283($i; $k)
C_POINTER:C301($2)
$k:=Length:C16($1)
$Code:=""
For ($i; 1; $k)
	If ((Character code:C91($1[[$i]])>=48) & (Character code:C91($1[[$i]])<=57))  //Must be a number
		$Code:=$Code+$1[[$i]]
	End if 
End for 
If (Length:C16($Code)=7)
	$2->:=$3+$Code
Else 
	$2->:=$Code
End if 