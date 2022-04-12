//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Tx_ClipForward(text;what;startcnt;numchars)
	//Date: 03/11/03
	//Who: Bill
	//Returns from the delimiter: 
End if 
C_TEXT:C284($0; $1; $2)
//
C_LONGINT:C283($p; $pSep; $3; $4)
C_TEXT:C284($begText)
$workText:=$1
$p:=Position:C15($2; $1)  //"zzzClip";[WorkOrder]Description)
If ($p>0)
	$0:=Substring:C12($workText; $p-1+Length:C16($2)+$3; $4)
Else 
	$0:=""
End if 
