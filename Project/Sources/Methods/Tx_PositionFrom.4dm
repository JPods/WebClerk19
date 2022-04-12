//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $2; $3)
C_LONGINT:C283($0)
//
C_LONGINT:C283($p; $incStr; $len)
C_TEXT:C284($testText)
$len:=Length:C16($3)
$p:=Position:C15($2; $1)
$0:=0
If ($p>0)
	$incStr:=$p
	Repeat 
		$incStr:=$incStr-1
		If ($incStr>0)
			$testText:=$1[[$incStr]]+$testText
			If ($3=Substring:C12($testText; 1; $len))
				$0:=$p-$incStr
				$incStr:=0
			End if 
		End if 
	Until ($incStr=0)
End if 