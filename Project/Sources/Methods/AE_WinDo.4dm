//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-11-21T00:00:00, 09:51:45
// ----------------------------------------------------
// Method: AE_WinDo
// Description
// Modified: 11/21/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $2)  //myApp; myDoc
KeyModifierCurrent
//MyTestAlert ($1+"?begin?"+$2)
If ($1#"")  // Modified by: williamjames (111216 checked for <= length protection)
	$w:=Position:C15(" "; $1)
	If ($w>0)
		If (($1[[1]]#Char:C90(34)) & ($1[[Length:C16($1)]]#Char:C90(34)))
			$1:=Char:C90(34)+$1+Char:C90(34)
		End if 
	End if 
End if 
$w:=Position:C15(" "; $2)
If ($w>0)
	If (($2[[1]]#Char:C90(34)) & ($2[[Length:C16($2)]]#Char:C90(34)))
		$2:=Char:C90(34)+$2+Char:C90(34)
	End if 
End if 
LAUNCH EXTERNAL PROCESS:C811($1+" "+$2)
