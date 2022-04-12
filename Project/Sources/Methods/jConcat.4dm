//%attributes = {"publishedWeb":true}
//Method: jConcat
C_TEXT:C284($0; $1; $2)
If (Count parameters:C259=1)  //Concat  $0 = $1 + $2 if $1 # "" else $0 = space | $2
	$0:=Num:C11(Length:C16($1)#0)*($1+" ")
Else 
	$0:=Num:C11(Length:C16($1)#0)*($1+$2)
End if 