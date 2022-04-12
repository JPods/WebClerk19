//%attributes = {}
If (False:C215)
	//KennyBCookies_mb_v100
	//2/14/2008.new.
End if 
C_LONGINT:C283($0)
$0:=-1

C_TEXT:C284($1)

C_LONGINT:C283($pos1; $pos2)

$pos1:=Position:C15("RESULT="; $1)

If ($pos1>0)
	$pos2:=Position:C15("&"; $1)
	$0:=Num:C11(Substring:C12($1; 8; $pos2-8))
End if 

