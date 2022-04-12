C_LONGINT:C283($i; $k)
C_LONGINT:C283(vilo1)
KeyModifierCurrent
$k:=Size of array:C274(aQaAnswrLns)
If ($k>0)
	If (CmdKey=0)
		CONFIRM:C162("Set group to "+String:C10(vilo1))
	Else 
		OK:=1
	End if 
	If (OK=1)
		For ($i; 1; $k)
			aQaGroup{aQaAnswrLns{$i}}:=vilo1
		End for 
		doSearch:=1
	Else 
		BEEP:C151
		BEEP:C151
	End if 
End if 