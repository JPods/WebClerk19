//%attributes = {"publishedWeb":true}

// ### bj ### 20181204_1111
// what does this do???

C_LONGINT:C283($lenItemNum; $w; $theType)
C_LONGINT:C283($incG)
C_TEXT:C284($1)  //delimiter
C_POINTER:C301($2; $3)  //text to parse  //ptr to receiving array
C_TEXT:C284($splitText)
$theType:=Type:C295($3->)
$lenItemNum:=Length:C16($2->)
$incG:=0
While ($incG<$lenItemNum)
	$w:=Size of array:C274($3->)+1
	INSERT IN ARRAY:C227($3->; $w; 1)
	$exit:=False:C215
	Repeat 
		$incG:=$incG+1
		If (($2->[[$incG]]#$1) & ($incG<=$lenItemNum))
			$splitText:=$splitText+($2->[[$incG]])
		Else 
			$exit:=True:C214
		End if 
	Until ($exit)
	Case of 
		: (($theType=18) | ($theType=21))
			$3->{$w}:=$splitText
		: (($theType=14) | ($theType=15) | ($theType=16))
			$3->{$w}:=Num:C11($splitText)
		: ($theType=17)
			$3->{$w}:=Date:C102($splitText)
		: ($theType=22)
			$3->{$w}:=(($splitText="1") | ($splitText[[1]]="t") | ($splitText[[1]]="y"))
	End case 
	$splitText:=""
End while 
//