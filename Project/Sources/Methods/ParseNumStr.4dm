//%attributes = {"publishedWeb":true}
//Procedure: ParseNumStr
C_TEXT:C284($0)
C_POINTER:C301($1)  //pointer to text string
C_LONGINT:C283($2; $Start; $End)  //Middle point of Goal String $1 Text String
$Start:=$2
$End:=$2
$notDone:=True:C214
While ($notDone)
	If ($Start>0)
		If ((($1->[[$Start]]>="0") & ($1->[[$Start]]<="9")) | ($1->[[$Start]]="."))
			$Start:=$Start-1  //will go one to far
		Else 
			$notDone:=False:C215
		End if 
	Else 
		$notDone:=False:C215
	End if 
End while 
$notDone:=True:C214
$len:=Length:C16($1->)
While ($notDone)
	If ($End<=$len)
		If ((($1->[[$End]]>="0") & ($1->[[$End]]<="9")) | ($1->[[$End]]="."))
			$End:=$End+1  //will go one to far
		Else 
			$notDone:=False:C215
		End if 
	Else 
		$notDone:=False:C215
	End if 
End while 
$Start:=$Start+1  //goes one to far
$End:=$End-1  //goes one to far
$0:=Substring:C12($1->; $start; ($End-$start+1))