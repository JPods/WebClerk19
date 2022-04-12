//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-06-24T00:00:00, 12:09:20
// ----------------------------------------------------
// Method: Key_Pairs
// Description
// Modified: 06/24/13
// 
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20200519_0010
//DETELTETHIS


C_TEXT:C284($1; $keyPairs; $pairOne; $pairTwo)
C_POINTER:C301($2)  //THE TABLE
C_POINTER:C301($3)  //THE FIELD
C_LONGINT:C283($4)  //the cycle
C_LONGINT:C283($5)  //must be 1 if not called first in seach sequence
$cycleCnt:=$4
C_TEXT:C284($wildCard; $6)  //"@"
$wildCard:=$6

C_LONGINT:C283($p; $cycleCnt)
C_TEXT:C284($testWord)
$keyPairs:=Replace string:C233($1; ", "; "; ")
Repeat 
	$p:=Position:C15("; "; $keyPairs)
	If ($p>0)
		$testWord:=Substring:C12($keyPairs; 1; $p-1)
		$keyPairs:=Substring:C12($keyPairs; $p+2)
	Else 
		$testWord:=$keyPairs
	End if 
	
	Case of 
		: ($cycleCnt=0)
			QUERY:C277([Word:99]; [Word:99]WordCombined:5=$testWord+$wildCard; *)
			
		: ($testWord="")
		Else 
			QUERY:C277([Word:99];  & [Word:99]WordCombined:5=$testWord+$wildCard; *)
	End case 
	$cycleCnt:=1
Until ($p=0)