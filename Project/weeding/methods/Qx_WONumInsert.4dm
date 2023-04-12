//%attributes = {"publishedWeb":true}
C_TEXT:C284($curWOStr; $findStr)
//C_TEXT($1;$0)
C_LONGINT:C283($p)
$p:=Position:C15("jitWO="; [WorkOrder:66]Description:3)
If ($p=0)
	$curWOStr:=Char:C90(34)+"jitWO="+String:C10([WorkOrder:66]woNum:29)+Char:C90(34)+")>"
	$findStr:=Char:C90(34)+Char:C90(34)+")>"
	[WorkOrder:66]Description:3:=Replace string:C233([WorkOrder:66]Description:3; $findStr; $curWOStr)
End if 
//