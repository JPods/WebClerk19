//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_TEXT:C284($strNum)
C_LONGINT:C283($len; $incMea; $0)
$len:=Length:C16($1->)
$strNum:=""
For ($incMea; 1; $len)
	If (($1->[[$incMea]]>="0") & ($1->[[$incMea]]<="9"))
		$strNum:=$strNum+$1->[[$incMea]]
	End if 
End for 
$0:=Num:C11($strNum)
If ($0=0)
	$0:=1
End if 