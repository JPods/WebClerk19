//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($0)  //test string segment matchs buffer string segment
C_POINTER:C301($1)  //pointer to text: Test String Segment
C_LONGINT:C283($2)  //starting position in $1
C_LONGINT:C283($3)  //ending position in $1
C_LONGINT:C283($4)  //starting position in tTIOIBuffer to match w/ $1
C_BOOLEAN:C305($match)
$match:=True:C214
If (($4+($3-$2))<=Length:C16(tTIOIBuffer))
	C_LONGINT:C283($index)
	$index:=$2
	C_LONGINT:C283($BuffIndex)
	$BuffIndex:=$4
	While (($match) & ($index<=$3))
		Case of 
			: ($1->[[$index]]=Char:C90(<>ciTIO1Char))  //any single char
				$match:=True:C214
			: ($1->[[$index]]=Char:C90(<>ciTIO1Num))  //any single number: 0-9
				$match:=((tTIOIBuffer[[$BuffIndex]]>="0") & (tTIOIBuffer[[$BuffIndex]]<="9"))
			: ($1->[[$index]]=Char:C90(<>ciTIO1Alpha))  //any single letter: a-z,A-Z
				$match:=((tTIOIBuffer[[$BuffIndex]]>="a") & (tTIOIBuffer[[$BuffIndex]]<="z"))
			Else 
				$match:=($1->[[$index]]=tTIOIBuffer[[$BuffIndex]])
		End case 
		$index:=$index+1
		$BuffIndex:=$BuffIndex+1
	End while 
	$0:=$match
Else 
	$0:=False:C215  //doesn't match not same length  
End if 