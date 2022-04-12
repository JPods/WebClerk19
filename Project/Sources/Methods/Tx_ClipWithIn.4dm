//%attributes = {"publishedWeb":true}
//Tx_ClipWithIn
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/25/08, 01:17:33
// ----------------------------------------------------
// Method: Tx_ClipWithIn
// Description
// 
//
// Parameters
//$1 is incoming text
//$2 is lead paramter
//$3 is the trailing parameter

// ----------------------------------------------------

C_TEXT:C284($0; $1; $2; $3; $4)
//
If (Count parameters:C259#4)
	BEEP:C151
Else 
	C_LONGINT:C283($p; $pSep)
	C_TEXT:C284($begText; $endText)
	$p:=Position:C15($2; $1)  //"zzzClip";[WorkOrder]Description)
	If ($p>0)
		$pSep:=Tx_PositionFrom($1; $2; $3)  //[WorkOrder]Description;"jitQty";"<&t")
		If ($pSep>0)
			$workText:=Substring:C12($1; $p-$pSep)  //
			$p:=Position:C15($4; $workText)  //"<&te>";$workText)
			If ($p>0)
				$workText:=Substring:C12($workText; 1; $p+Length:C16($4)-1)
			End if 
			$0:=$workText
		Else 
			$0:=Substring:C12($1; $p+1)
		End if 
	Else 
		$0:=$1
	End if 
End if 