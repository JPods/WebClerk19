//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/28/18, 01:14:57
// ----------------------------------------------------
// Method: jsonHeaderFormat
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $1; $data; $2; $purpose; $3; $buildReply)
ARRAY TEXT:C222($aheadvalues; 0)

C_TEXT:C284($headparts)
If ($1#"")
	Txt_2Array($1; ->$aheadvalues; ",")
	C_LONGINT:C283($incRay; $cntRay)
	$headparts:=""
	$cntRay:=Size of array:C274($aheadvalues)
	For ($incRay; 1; $cntRay)
		ARRAY TEXT:C222($aPairs; 0)
		Txt_2Array($aheadvalues{$incRay}; ->$aPairs; ":")
		If (Size of array:C274($aPairs)=2)
			$headparts:=$headparts+"\""+$aPairs{1}+"\": "+$aPairs{2}
			If ($incRay<$cntRay)
				$headparts:=$headparts+"\",\r"
			Else 
				$headparts:=$headparts+"\""
			End if 
		End if 
	End for 
	$headparts:=$headparts+"\r},"
End if 

