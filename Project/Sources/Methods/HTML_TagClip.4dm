//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HTML_TagClip (ptText) ->next content text
	//Date: 07/01/02
	//Who: Bill
	//Description: Parse the tag
End if 
//
ARRAY TEXT:C222(aWebTags; 0)
C_POINTER:C301($1)
C_LONGINT:C283($0; $nextText)
C_LONGINT:C283($2; $3)
C_TEXT:C284($tagBegin; $tagTable; $tagField; $tagFormat)
//
ARRAY TEXT:C222(aWebTags; 7)
C_LONGINT:C283($p; $pEnd; $err)
$0:=0
//$p:=Position(<>jitTag;$1->)
//If ($3=1)
//$pEnd:=Position(<>refTag;$1->)
//Case of 
//: (($p<$pEnd)&($p>0))
////let $p be used
//: (($p>$pEnd)&($pEnd>0))
//$p:=$pEnd
//: (($pEnd>0)&($p=0))
//$p:=$pEnd
//End case 
//End if 
$p:=Position:C15("jit_"; $1->)
If ($p>0)
	$0:=1
	$tagBegin:=Substring:C12($1->; $p-1; 5)  //not looking for whole tag
	$theSelect:=Substring:C12($1->; $p+4; 100)
	$1->:=Substring:C12($1->; $p-1+<>lenJitTag)
	//
	$pEnd:=Position:C15(<>endTag; $theSelect)
	If ($pEnd>0)
		$theSelect:=Substring:C12($theSelect; 1; $pEnd-1)
		$p:=Position:C15(<>midTag; $theSelect)
		If ($p=0)
			$err:=-2  //no field tag
			$tagField:="NoFieldTag_"+$theSelect
		Else 
			$err:=1
			$tagTable:=Substring:C12($theSelect; 1; $p-1)
			$tagField:=Substring:C12($theSelect; $p+<>lenMidTag)
			$p:=Position:C15(<>formatTag; $tagField)
			If ($p>0)
				$tagFormat:=Substring:C12($tagField; $p+1)
				$tagField:=Substring:C12($tagField; 1; $p-1)
			End if 
		End if 
		$1->:=Substring:C12($1->; $pEnd+<>lenEndTag)  //clip past the tag to rest of page    
	Else 
		$1->:=Substring:C12($1->; $p-1+<>lenJitTag)  //not looking for whole tag
		$p:=Position:C15(<>midTag; $theSelect)
		If ($p>0)
			$tagTable:=Substring:C12($theSelect; 1; $p-1)
			$tagField:=Substring:C12($theSelect; $p+<>lenMidTag)
			$err:=-1  //has a mid tag, no ending tag
		Else 
			$tagTable:=$theSelect
			$err:=-3  //no ending tag, no midTag
		End if 
	End if 
	//
	aWebTags{1}:=$tagBegin
	aWebTags{2}:=$tagTable
	aWebTags{3}:=$tagField
	aWebTags{4}:=$tagFormat
	aWebTags{5}:=String:C10($err)
Else 
	$0:=0  //no more tags found
End if 