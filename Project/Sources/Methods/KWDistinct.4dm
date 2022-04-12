//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: KWDistinct
	//Date: 07/01/02
	//Who: Bill
	//Description: Find Unique Values in lists
End if 

C_TEXT:C284($1; $2; $0)
C_POINTER:C301($3)
$0:=""
C_TEXT:C284($theText; $theDelim)
ARRAY TEXT:C222($aText; 0)
If (Count parameters:C259=0)
	$theText:=Get text from pasteboard:C524
	$theDelim:=", "
Else 
	$theText:=$1
	$theDelim:=$2
End if 
C_LONGINT:C283($p; $w)
$theText:=Replace string:C233($theText; Char:C90(10); "")
$theText:=Replace string:C233($theText; "; "; ", ")
Repeat 
	$p:=Position:C15("\r"; $theText)
	$testStr:=""
	If ($p>0)
		$testStr:=Substring:C12($theText; 1; $p-1)
		$theText:=Substring:C12($theText; $p+1)
	Else 
		If (Length:C16($theText)>0)
			$testStr:=$theText
			$theText:=""
		End if 
	End if 
	If ($testStr#"")
		$w:=Find in array:C230($aText; $testStr)
		If ($w<0)
			INSERT IN ARRAY:C227($aText; 1; 1)
			$aText{1}:=$testStr
		End if 
	End if 
Until ($p=0)
$k:=Size of array:C274($aText)
$theText:=""
If ($k>0)
	SORT ARRAY:C229($aText)
	If (Count parameters:C259=3)
		C_POINTER:C301($3)
		COPY ARRAY:C226($aText; $3->)
	Else 
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274($aText)
		For ($i; 1; $k)
			$theText:=$theText+$aText{$i}+"\r"
		End for 
		$0:=$theText
		If (Count parameters:C259=0)
			SET TEXT TO PASTEBOARD:C523($theText)
		End if 
	End if 
Else 
	$0:="No values"
End if 