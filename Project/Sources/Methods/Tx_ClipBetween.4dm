//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/25/08, 01:21:06
// ----------------------------------------------------
// Method: Tx_ClipBetween
// Description
// 
//
// Parameters
//$1 inbound text
//$2 leading text
//$3 trailing text
//$0 returned text
// ----------------------------------------------------


//Tx_ClipBetween
//clip between trailing string $3 and leading string $2
C_TEXT:C284($0; $1; $2; $3; $workText)
//
C_LONGINT:C283($p; $pSep)
C_TEXT:C284($begText; $endText)
$p:=Position:C15($2; $1)  //"zzzClip";[WorkOrder]Description)
If ($p>0)
	//if(substring($2;Length($2))="~")
	//$1:=Substring($1;$p+Length($2))
	//Else 
	$1:=Substring:C12($1; $p+Length:C16($2))
	//end if
	$p:=Position:C15($3; $1)  //"zzzClip";[WorkOrder]Description)
	If ($p>0)
		$0:=Substring:C12($1; 1; $p-1)
	Else 
		$0:=Substring:C12($1; 1; $p-1)
	End if 
Else 
	$0:=$1
End if 