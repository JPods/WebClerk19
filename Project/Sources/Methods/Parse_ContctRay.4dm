//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_TEXT:C284($0)
$0:=""
$i:=6
$k:=Length:C16($1->)
$doLoop:=True:C214
While (($i<=$k) & ($doLoop))
	$deLim:=$i+1
	Case of 
		: ($i=$k)  //last real char
			$doLoop:=False:C215
			$0:=$0+$1->[[$i]]
		: ($1->[[$deLim]]="-")  //seperation character located
			$doLoop:=False:C215
		Else 
			$0:=$0+$1->[[$i]]  //build
	End case 
	$i:=$i+1
End while 