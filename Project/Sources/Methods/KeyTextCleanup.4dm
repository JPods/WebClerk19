//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/21/17, 16:40:34
// ----------------------------------------------------
// Method: KeyTextCleanup
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($vpKeyText)
$vpKeyText:=OBJECT Get pointer:C1124("SF_Draft")

$myKeyWords:=$vpKeyText->  // ### jwm ### 20160719_1643 clear keywords built below
$myKeyWords:=Replace string:C233($myKeyWords; "\r"; " ")
// ### jwm ### 20160719_1637  parse incoming text using keywords function replaces delimiters with a space
ARRAY TEXT:C222($atMyKeywords; 0)
GET TEXT KEYWORDS:C1141($myKeyWords; $atMyKeywords; *)  //Unique words
$countKeywords:=Size of array:C274($atMyKeywords)
$myKeyWords:=""
For ($incKeywords; 1; $countKeywords)
	$myKeyWords:=$myKeyWords+$atMyKeywords{$incKeywords}+" "
End for 

//$myKeyWords:=Txt_Clean($myKeyWords;" ")
$vpKeyText->:=$myKeyWords
