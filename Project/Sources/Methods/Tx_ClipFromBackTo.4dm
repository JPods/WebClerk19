//%attributes = {"publishedWeb":true}
//Method: Tx_ClipFromBackTo
C_TEXT:C284($0; $1; $2; $3; $workText)
//
C_LONGINT:C283($p; $pSep)
C_TEXT:C284($begText; $endText)
$p:=Position:C15($2; $1)  //"zzzClip";[WorkOrder]Description)
If ($p>0)
	$pSep:=Tx_PositionFrom($1; $2; $3)  //[WorkOrder]Description;"jitQty";"<&t")
	$workText:=Substring:C12($1; 1; $p-1)  //
	If ($pSep>0)
		$0:=Substring:C12($workText; $p-$pSep+Length:C16($3))
	Else 
		$0:=$workText
	End if 
Else 
	//TRACE
	//August 12, 2000, did say    $0:=$workText but $workText not assigned
	$0:=$1
End if 