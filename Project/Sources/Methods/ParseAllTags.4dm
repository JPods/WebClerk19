//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 05/08/19, 14:02:25
// ----------------------------------------------------
// Method: ParseAllTags
// Description
// 
// --WORKONTHIS--
//
// Parameters
// ----------------------------------------------------

// ******************************************* //
// ** TYPE AND INITIALIZE ALL VARIABLES ****** //
// ******************************************* //

// $vtTextOriginal. THIS STARTS OUT AS THE ORIGINAL TEXT

C_TEXT:C284($1; $vtTextOriginal)
$vtTextOriginal:=$1

// $vtTextFinal. THIS WILL HOLD THE FINAL TEXT

C_TEXT:C284($0; $vtTextFinal)
$vtTextFinal:=""

// ******************************************* //
// *** PARSE ANY TAGS, REGARDLESS OF FORMAT ** //
// ******************************************* //

Case of 
		
	: (Position:C15("<!--#4D"; $vtTextOriginal)>0)
		
		PROCESS 4D TAGS:C816($vtTextOriginal; $vtTextFinal)
		
	: (Position:C15("_jit"; $vtTextOriginal)>0)
		
		$vtTextFinal:=TagsToText($vtTextOriginal)
		
	Else 
		
		$vtTextFinal:=$vtTextOriginal
		
End case 

// ******************************************* //
// *** RETURN PARSED TAG ********************* //
// ******************************************* //

$0:=$vtTextFinal