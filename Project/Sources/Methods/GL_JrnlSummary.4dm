//%attributes = {"publishedWeb":true}
//type transaction
C_TEXT:C284($6)
C_LONGINT:C283($w)
C_TEXT:C284($2; $1)
C_DATE:C307($3)
C_REAL:C285($4; $5; $diff)
$w:=Find in array:C230(aGLAcct; $1)
If ($w>0)  //Found an account match
	C_BOOLEAN:C305($notDone)
	$notDone:=True:C214
	While ($notDone)
		If (aGLDiv{$w}#$6)  //Check for a Division match
			If ($w+1<Size of array:C274(aGLAcct))
				$w:=Find in array:C230(aGLAcct; $1; $w+1)
				If ($w=-1)
					$notDone:=False:C215  //There is no match
				End if 
			Else 
				$w:=-1  //There is no match
				$notDone:=False:C215
			End if 
		Else 
			$notDone:=False:C215  //found the right one
		End if 
	End while 
End if 
If ($w=-1)
	INSERT IN ARRAY:C227(aGLAcct; 1)
	INSERT IN ARRAY:C227(aGLSource; 1)
	INSERT IN ARRAY:C227(aGLDate; 1)
	INSERT IN ARRAY:C227(aGLDebit; 1)
	INSERT IN ARRAY:C227(aGLCredit; 1)
	INSERT IN ARRAY:C227(aGLDiv; 1)
	$w:=1
	aGLDebit{$w}:=Round:C94(aGLDebit{$w}+$4; <>tcDecimalTt)
	aGLCredit{$w}:=Round:C94(aGLCredit{$w}+$5; <>tcDecimalTt)
Else 
	aGLDebit{$w}:=Round:C94(aGLDebit{$w}+$4; <>tcDecimalTt)
	aGLCredit{$w}:=Round:C94(aGLCredit{$w}+$5; <>tcDecimalTt)
	$diff:=Round:C94(aGLDebit{$w}-aGLCredit{$w}; <>tcDecimalTt)
	If ($diff>0)
		aGLDebit{$w}:=$diff
		aGLCredit{$w}:=0
	Else 
		aGLCredit{$w}:=Abs:C99($diff)
		aGLDebit{$w}:=0
	End if 
End if 
aGLAcct{$w}:=$1
aGLSource{$w}:=$2
aGLDate{$w}:=$3
aGLDiv{$w}:=$6