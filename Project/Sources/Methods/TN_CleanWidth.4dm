//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-08-08T00:00:00, 23:57:27
// ----------------------------------------------------
// Method: TN_CleanWidth
// Description
// Modified: 08/08/18
// Structure: gkgkgk
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $0)

C_LONGINT:C283($p)
C_TEXT:C284($textWorking; $textFinal)


//clear widths
$textWorking:=$1
$p:=Position:C15(" width="; $textWorking)
While ($p>0)
	$textFinal:=$textFinal+Substring:C12($textWorking; 1; $p)
	$textWorking:=Substring:C12($textWorking; $p+1)
	$p:=Position:C15(" "; $textWorking)
	If ($p>0)
		$textWorking:=Substring:C12($textWorking; $p-1)
	End if 
	$p:=Position:C15(" width="; $textWorking)
End while 
$textFinal:=$textFinal+$textWorking  // add the tag end


$textWorking:=$textFinal  // recycle for height

//clear height
$textFinal:=""
$p:=Position:C15(" height="; $textWorking)
While ($p>0)
	$textFinal:=$textFinal+Substring:C12($textWorking; 1; $p)
	$textWorking:=Substring:C12($textWorking; $p+1)
	$p:=Position:C15(" "; $textWorking)
	If ($p>0)
		$textWorking:=Substring:C12($textWorking; $p-1)
	End if 
	$p:=Position:C15(" height="; $textWorking)
End while 
$0:=$textFinal+$textWorking  // add the tag end
