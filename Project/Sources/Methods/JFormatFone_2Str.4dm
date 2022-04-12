//%attributes = {"publishedWeb":true}
//Method: Format_Phone
C_TEXT:C284($1; $0)
C_LONGINT:C283($w; $len)
C_TEXT:C284($ext)
$w:=Position:C15("ext"; $1)
//TRACE
If ($w>1)
	If ($1[[($w-1)]]=" ")
		$w:=$w-1
	End if 
	$len:=$w-1  //get to befor the first letter of ext
	$ext:=Substring:C12($1; $w; Length:C16($1))
Else 
	$len:=Length:C16($1)
	$ext:=""
End if 
Case of 
	: ($len=0)
		$0:=""
	: (Position:C15("("; $1)>0)
		$0:=$1
	: (Position:C15("-"; $1)>0)
		$0:=$1
	: (Position:C15("."; $1)>0)
		$0:=$1
	: ((<>vbIgnoreFone=True:C214) | (Substring:C12($1; 1; 3)="011"))
		$0:=$1
	: ($len=7)
		$0:=Substring:C12($1; 1; 3)+"-"+Substring:C12($1; 4; 4)+$ext
	: ($len=10)
		$0:="("+Substring:C12($1; 1; 3)+") "+Substring:C12($1; 4; 3)+"-"+Substring:C12($1; 7; 4)+$ext
	Else 
		C_TEXT:C284($tempStr)
		C_LONGINT:C283($index; $index2)
		$index:=1
		$index2:=1
		While ($index<=Length:C16(<>vAltFoneFor))
			If (<>vAltFoneFor[[$index]]="#")
				If ($index2<=$len)
					$tempStr:=$tempStr+$1[[$index2]]
					$index2:=$index2+1
				Else 
					$index:=32000  //terminate
				End if 
			Else 
				$tempStr:=$tempStr+<>vAltFoneFor[[$index]]
			End if 
			$index:=$index+1
		End while 
		If ($index2<=$len)  //$index2 is 1 greater then the number used so far
			$tempStr:=$tempStr+Substring:C12($1; $index2; ($len-$index2)+1)
		End if 
		$0:=$tempStr+$ext
End case 