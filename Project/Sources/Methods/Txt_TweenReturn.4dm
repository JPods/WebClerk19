//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/23/20, 21:10:42
// ----------------------------------------------------
// Method: Txt_TweenReturn
// Description
// 
//
// Parameters
// ----------------------------------------------------
// returns text between two delimiters
// adjust to the size of the delimiters

C_TEXT:C284($1; $2; $3; $vtIncoming; $vtDelimBegin; $vtDelimEnd; $vtFinal)
C_LONGINT:C283($lenLead; $lenTrail; $p)
C_TEXT:C284($0)
//
If (False:C215)  // testing
	$vtIncoming:="style=\"color:red; background-color:fff176\""
	$vtDelimBegin:="\""
	$vtDelimEnd:="\""
Else 
	$vtIncoming:=$1
	$vtDelimBegin:=$2
	$vtDelimEnd:=$3
End if 


$lenLead:=Length:C16($vtDelimBegin)
$lenTrail:=Length:C16($vtDelimEnd)
C_TEXT:C284($theText)
$myOK:=0
$p:=Position:C15($vtDelimBegin; $vtIncoming)
If ($p>0)
	$theText:=Substring:C12($vtIncoming; $p+$lenLead)
	$p:=Position:C15($vtDelimEnd; $theText)
	If ($p>0)
		$vtFinal:=Substring:C12($theText; 1; $p-1)
	Else 
		$vtFinal:=$theText
	End if 
Else 
	$vtFinal:=$vtIncoming
End if 
$0:=$vtFinal