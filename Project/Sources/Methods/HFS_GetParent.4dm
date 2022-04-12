//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $0)
C_LONGINT:C283($i; $k; $mark)
$k:=Length:C16($1)
If ($k>0)  // Modified by: williamjames (111216 checked for <= length protection)
	$i:=$k
	If (Is macOS:C1572)
		$theChar:=":"
	Else 
		$theChar:="\\"
	End if 
	Repeat 
		$i:=$i-1
	Until (($1[[$i]]=$theChar) | ($i=1))
	$0:=Substring:C12($1; 1; $i)
End if 