//%attributes = {"publishedWeb":true}
C_DATE:C307($0)
C_TEXT:C284($1)
C_TEXT:C284($part1; $part2; $temp)
$part1:=Substring:C12($1; 1; 2)
$part2:=Substring:C12($1; 3; 2)
If ((Num:C11($part1)=0) | (Num:C11($part1)>12))
	$temp:=$part1
	$part1:=$part2
	$part2:=$temp
End if 
$0:=Date:C102($part1+"/01/"+$part2)