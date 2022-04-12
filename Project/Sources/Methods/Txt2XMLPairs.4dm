//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: TextToArray 
	//Date: 07/01/02
	//Who: Bill
	//Description: Block of text to an array
End if 

C_TEXT:C284($1; $theText)
C_POINTER:C301($2; $3; $4)  //three arrays for name, tableNum, FieldNum
ARRAY TEXT:C222($2->; 0)
ARRAY LONGINT:C221($3->; 0)
ARRAY LONGINT:C221($4->; 0)
$theText:=$1
If (Count parameters:C259=6)
	$theDelim:=$5
	$fldDelim:=$6
Else 
	$theDelim:="\r"
	$fldDelim:=";"
End if 

vText11:=WC_jitNum2Name(vText11; "Numbered")




$lenDelim:=Length:C16($theDelim)
Repeat 
	$p:=Position:C15($theDelim; $theText)
	$theString:=""
	If ($p>0)
		$theString:=Substring:C12($theText; 1; $p-1)
		$theText:=Substring:C12($theText; $p+$lenDelim)
	Else 
		If (Length:C16($theText)>0)
			$theString:=$theText
			$theText:=""
		End if 
	End if 
	If ($theString#"")
		$w:=Size of array:C274($2->)+1
		INSERT IN ARRAY:C227($2->; $w; 1)
		$2->{$w}:=TxtStripLineFeed($theString)
	End if 
Until ($theText="")
//