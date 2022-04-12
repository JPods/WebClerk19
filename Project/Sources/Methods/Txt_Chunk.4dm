//%attributes = {"publishedWeb":true}

If (False:C215)
	//Method: Txt_Chunk
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
	//vi9:=Txt_Chunk (->vText1;->vText2;->aText1{11};"";"\t";"";"";0)
	//$1 pointer to inbound text and returned trailing text
	//$2 pointer to outbound leading text
	//$3 pointer to clipped out text
	//$4 before delimiter
	//$5 after delimiter
	//$6  grab # of extra characters from the beginning
	//$7  grab # of extra characters from the end
	//$8    //??????
	//$0 Status
End if 

C_LONGINT:C283($0)
C_POINTER:C301($1; $2; $3)  //inputText_2_beforeText;  trailingText; value
C_TEXT:C284($4; $5)  //stringBeginFind; stringEndFind
C_LONGINT:C283($6; $7)  //grab more begin and end
C_LONGINT:C283($8; $clipDelimiter)
//
C_TEXT:C284($theText)
C_LONGINT:C283($i; $p; $w; $myOK)
C_LONGINT:C283($lenLead; $lenTrail)
C_LONGINT:C283($p; $pend)
$myOK:=0
$foundBegin:=False:C215
$foundEnd:=False:C215
$lenBegin:=Length:C16($4)
$lenEnd:=Length:C16($5)
$clipDelimiter:=0
If ($4="")  //if empty clip from beginning
	$p:=1
Else 
	$p:=Position:C15($4; $1->)
End if 
$2->:=""
$3->:=""
$grabMoreBegin:=0
$grabMoreEnd:=0
If (Count parameters:C259>5)
	$grabMoreBegin:=$6
	If (Count parameters:C259>6)
		$grabMoreEnd:=$7
		If (Count parameters:C259>7)
			$clipDelimiter:=Num:C11($8=1)
		End if 
	End if 
End if 
Case of 
	: (($lenBegin=0) & ($lenEnd=0))
		$0:=-3
	: ($p=0)
		$0:=-1
	Else 
		If ($p=1)
			$beforeTxt:=""
			$remainTxt:=$1->
		Else 
			$beforeTxt:=Substring:C12($1->; 1; $p+$lenBegin-1-$grabMoreBegin)
			$remainTxt:=Substring:C12($1->; $p+$lenBegin)
		End if 
		If ($5="")  //empty string clip to the end of input
			$pEnd:=Length:C16($remainTxt)
			$foundEnd:=True:C214
		Else 
			$pEnd:=Position:C15($5; $remainTxt)
		End if 
		If ($pEnd=0)
			If ($remainTxt#"")
				$3->:=$remainTxt
				$1->:=""
				$2->:=$beforeTxt
				$0:=-4
			Else 
				$0:=-2
			End if 
		Else 
			$3->:=Substring:C12($remainTxt; 1; $pEnd-$clipDelimiter+$grabMoreEnd-1)
			$1->:=Substring:C12($remainTxt; $pEnd+$grabMoreEnd)
			$2->:=$beforeTxt
			$0:=1
		End if 
End case 





//If (False)
////Method: Txt_Chunk
////Date: 07/01/02
////Who: Bill
////Description: List of structure
//End if 
//
//C_Longint($0)
//C_POINTER($1;$2;$3)//inputText_2_beforeText;  trailingText; value
//C_TEXT($4;$5)//stringBeginFind; stringEndFind
//C_Longint($6;$7)//grab more begin and end
////
//C_TEXT($theText)
//C_LONGINT($i;$p;$w;$myOK)
//C_LONGINT($lenLead;$lenTrail)
//$myOK:=0
//$foundBegin:=False
//$foundEnd:=False
//$lenBegin:=Length($4)
//$lenEnd:=Length($5)
//If ($4="")//if empty clip from beginning
//$p:=1
//Else 
//$p:=Position($4;$1->)
//End if 
//$2->:=""
//$3->:=""
//$grabMoreBegin:=0
//$grabMoreEnd:=0
//If (Count parameters>5)
//$grabMoreBegin:=$6
//If (Count parameters>6)
//$grabMoreEnd:=$7
//End if 
//End if 
//Case of 
//: (($lenBegin=0)&($lenEnd=0))
//$0:=-3
//: ($p=0)
//$0:=-1
//Else 
//If ($5="")//empty string clip to the end of input
//$pEnd:=Length($remainTxt)
//$foundEnd:=True
//End if 
//If ($p=1)
//$beforeTxt:=""
//Else 
//$beforeTxt:=Substring($1->;1;$p-1-$grabMoreBegin)
//$remainTxt:=Substring($1->;$p)
//$pEnd:=Position($5;$remainTxt)
//End if 
//If ($pEnd=0)
//$0:=-2
//Else 
//$3->:=Substring($remainTxt;1;$pEnd+$lenEnd+$grabMoreEnd)
//$1->:=Substring($remainTxt;1+$pEnd+$lenEnd+$grabMoreEnd)
//$2->:=$beforeTxt
//$0:=1
//End if 
//End case 
//