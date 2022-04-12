//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2)
C_LONGINT:C283($diffLen; $w; $len)
C_TEXT:C284($mainNum)
KeyModifierCurrent
If ((OptKey=0) & ($2->#""))
	$w:=Position:C15("ext"; $1->)
	If ($w>0)
		$mainNum:=Substring:C12($1->; 1; $w-1-Num:C11($1->[[$w-1]]=" "))
	Else 
		$mainNum:=$1->
	End if 
	$diffLen:=Length:C16($mainNum)-Length:C16($2->)
	If ($diffLen>0)
		$2->:=Substring:C12($1->; 1; $diffLen)+$2->
	End if 
End if 
