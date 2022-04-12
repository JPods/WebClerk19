//%attributes = {"publishedWeb":true}
//Method: Qx_SetGroups
C_LONGINT:C283($pT; $pP; $k; $i; $p)
C_TEXT:C284($1; $0)
$p:=Position:C15("<&g("; $1)
$workingText:=$1
While ($p>0)
	$workingText:=Tx_ClipArround($workingText; "&g("; "<"; ">")
	$p:=Position:C15("<&g("; $workingText)
End while 
$0:=$workingText
Tx_FindFirst($workingText; "<&tbu2"; "<&pbu2"; ->v1; ->vi2)
$cntGrp:=0
While (vi2>0)
	$cntGrp:=$cntGrp+1
	$workingText:=Substring:C12($workingText; vi2+1)
	Tx_FindFirst($workingText; "<&tbu2"; "<&pbu2"; ->v1; ->vi2)
End while 
$grpText:=""
If ($cntGrp>1)
	$grpText:="<&g("
	Repeat 
		$grpText:=$grpText+String:C10($cntGrp)
		If ($cntGrp>1)
			$grpText:=$grpText+","
		End if 
		$cntGrp:=$cntGrp-1
	Until ($cntGrp=0)
	$grpText:=$grpText+")>"
	$0:=$0+$grpText
End if 
