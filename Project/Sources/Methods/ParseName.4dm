//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-02-01T06:00:00Z)
// Method: ParseName
// Description
// Parameters
// ----------------------------------------------------
// MustFixQQQZZZ: Bill James (2022-02-01T06:00:00Z)
// crude

var $1; $working : Text
var $0; $entryEntity : Object
var $c : Collection
var $p : Integer
$0:=New object:C1471("first"; ""; "last"; ""; "title"; ""; "suffix"; ""; "middel"; ""; "original"; "")
//Note this is a chan
$working:=$1
If ($working#"")
	$p:=Position:C15(","; $working)
	If ($p>0)
		$c:=Split string:C1554($1; ",")
		If ($c[0]#Null:C1517)
			$0.nameLast:=$c[0]
		End if 
		If ($c[1]#Null:C1517)
			$0.nameFirst:=$c[1]
		End if 
	Else 
		$c:=Split string:C1554($1; " ")
		If ($c[0]#Null:C1517)
			$0.nameFirst:=$c[0]
		End if 
		If ($c[1]#Null:C1517)
			$0.nameLast:=$c[1]
		End if 
	End if 
End if 

//if(false)
//var $v1; $v2; $v3; $v4 : Text
//var $ii; $kk; $vi1; $vi2; $vi3 : Integer
//var $endRead; $endWord; $nextWord : Boolean
//$endRead:=False
//$endWord:=False
//$nextWord:=False
//$kk:=Length($1->)
//If (Character code($1->)>0)
//$vi1:=0
//$vi2:=0
//$vi3:=0
//$v1:=""
//$v2:=""
//$v3:=""
//$v4:=$1->
//$ii:=0
//Repeat   // Read to the first non-space
//$ii:=$ii+1
//If ($ii>$kk)
//$endRead:=True
//Else 
//If ($v4[[$ii]]#" ")
//$nextWord:=True
//End if 
//End if 
//Until (($endRead) | ($nextWord))
//$nextWord:=False
//If (False)
//$v4:=Txt_TrimLeadingSpaces($v4)
//$endRead:=($v4="")
//End if 
//If (Not($endRead))
//Repeat 
//If ($v4[[$ii]]#" ")  // read until a space and fill into $v1
//$v1:=$v1+$v4[[$ii]]
//$ii:=$ii+1
//Else 
//$nextWord:=True
//End if 
//If ($ii>$kk)  // at the end of actual text with the last character a space
//$endRead:=True
//End if 
//Until (($endRead) | ($nextWord))

//If (False)
//$firstword:=""
//Txt_ReadOneWord(->$v4; ->$firstword; " ")
//End if 


//If ($nextWord)
//$nextWord:=False
//Repeat   // Read to the first non-space
//$ii:=$ii+1
//If ($ii>$kk)
//$endRead:=True
//Else 
//If ($v4[[$ii]]#" ")
//$nextWord:=True
//End if 
//End if 
//Until (($endRead) | ($nextWord))
//If ($nextWord)
//$nextWord:=False
//Repeat 
//If ($v4[[$ii]]#" ")  // read until a space and fill into $v1
//$v2:=$v2+$v4[[$ii]]
//$ii:=$ii+1
//Else 
//$nextWord:=True
//End if 
//If ($ii>$kk)  // at the end of actual text with the last character a space
//$endRead:=True
//End if 
//Until (($endRead) | ($nextWord))
//If ($nextWord)
//$nextWord:=False
//Repeat   // Read to the first non-space
//$ii:=$ii+1
//If ($ii>$kk)
//$endRead:=True
//Else 
//If ($v4[[$ii]]#" ")
//$nextWord:=True
//End if 
//End if 
//Until (($endRead) | ($nextWord))
//If (Not($endRead))
//$v3:=Substring($v4; $ii; $kk)
//End if 
//End if 
//End if 
//End if 

//End if 
//If ($v1#$v4)  //First name is equal to the original input
//If ($v3="")
//$2->:=$v1  //First Name
//$3->:=$v2  //Last Name
//Else 
//$2->:=$v1+" "+$v2  //First Name
//$3->:=$v3  //multi part last name
//End if 
//End if 
//End if 
//If (($2->="") & ($3->="") & ($1->#""))
//$3->:=$1->
//End if 
////Note this is a change from the original utility. to support Service Cal Screen 6
//End if 



// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-07-21T00:00:00, 19:41:58
// ----------------------------------------------------
// Method: ParseNameLastComma
// Description
// Modified: 07/21/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

//C_TEXT($1; $nameworking)
//C_LONGINT($pComma; $pSpace)
//$pComma:=Position(","; $1)
//[Customer]nameLast:=Substring($1; 1; $pComma-1)
//$nameworking:=Substring($1; $pComma+2)  // clear ", "
//$pSpace:=Position(" "; $nameworking)
//If ($pSpace>1)
//[Customer]nameFirst:=Substring($nameworking; $pSpace-1)
//Else 
//[Customer]nameFirst:=Substring($nameworking; 1)
//End if 
//[Customer]comment:="Original , Name: "+$1+"\r"+[Customer]comment