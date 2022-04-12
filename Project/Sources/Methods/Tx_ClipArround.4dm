//%attributes = {"publishedWeb":true}
//Tx_ClipArround
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/25/08, 01:33:34
// ----------------------------------------------------
// Method: Tx_ClipArround
// Returns the incoming text with the unwanted text clipped out
// 
//$1 inbound text
//$2 leading delimiter
//$3 trailing delimiter
//$4 ?????????
// Parameters
// ----------------------------------------------------

//
C_TEXT:C284($0; $1; $2; $3; $4)
//
C_LONGINT:C283($p; $pSep)
C_TEXT:C284($begText; $endText)
$p:=Position:C15($2; $1)  //"zzzClip";[WorkOrder]Description)
If ($p>0)
	$pSep:=Tx_PositionFrom($1; $2; $3)  //[WorkOrder]Description;"zzzClip";"<&t")
	If ($pSep>0)
		$begText:=Substring:C12($1; 1; $p-$pSep-1)  //[WorkOrder]Description;1;$p-$pSep-1)
		$workText:=Substring:C12($1; $p)  //[WorkOrder]Description;$p)
		$p:=Position:C15($4; $workText)  //"<&te>";$workText)
		If ($p>0)
			$endText:=Substring:C12($workText; $p+Length:C16($4))
		End if 
		$0:=$begText+$endText
	Else 
		$0:=Substring:C12($1; 1; $p-1)
	End if 
Else 
	$0:=$1
End if 