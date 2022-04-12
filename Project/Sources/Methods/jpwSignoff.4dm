//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
booOK:=True:C214
Error:=0
$4->:=0
If ((Current user:C182="James Technologies") | (Current user:C182="Admin"))
	$4->:=1
Else 
	TRACE:C157
	ON ERR CALL:C155("jOECpwSignOff")
	CHANGE CURRENT USER:C289
	If ((Current user:C182#"") & (booOK) & (OK=1))
		$2->:=Current user:C182
		$4->:=1
	Else 
		$2->:=Old:C35($2->)
		If (Count parameters:C259=5)
			$5->:=Old:C35($5->)
		End if 
		$4->:=0
	End if 
	ON ERR CALL:C155("")
End if 