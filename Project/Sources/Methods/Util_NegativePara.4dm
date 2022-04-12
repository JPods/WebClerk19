//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/29/11, 20:07:53
// ----------------------------------------------------
// Method: Util_NegativePara
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $num)
C_REAL:C285($0)
$0:=Num:C11($1)
If ((Position:C15("("; $1)>0) & (Position:C15(")"; $1)>0))
	$0:=-$0
End if 