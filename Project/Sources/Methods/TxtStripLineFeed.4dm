//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/07/09, 15:50:17
// ----------------------------------------------------
// Method: TxtStripLineFeed
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $0; $incoming; $outgoing)
$incoming:=$1
C_LONGINT:C283($incLetter; $cntLetter)
$cntLetter:=Length:C16($incoming)
For ($incLetter; $cntLetter; 1; -1)
	If ((Character code:C91($incoming[[$incLetter]])>31) | (Character code:C91($incoming[[$incLetter]])=9))
		$outgoing:=$incoming[[$incLetter]]+$outgoing
	End if 
End for 
$0:=$outgoing
//
