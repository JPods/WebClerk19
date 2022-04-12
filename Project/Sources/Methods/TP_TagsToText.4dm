//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/12/17, 08:37:24
// ----------------------------------------------------
// Method: TP_ParseTags
// --WORKONTHIS--
//  --AskAndy--
//
// Description:
//
// This method is set a chunk of text that may or may not contain
// a random number of jit tags, including varables, fields, objects,
// and "-6" scripts. This method will step through the code, parse
// each tag, and eventually return a chunk of text with all jit tags
// parsed out.
//
// Parameters:
//
// $1 is the chunk of text that needs to be parsed.
// 
// Return:
//
// $0 is a chunk of text that has been parsed.
// ----------------------------------------------------

// ******************************************* //
// **** TYPE AND INITIALIZE ALL VARIABLES **** //
// ******************************************* //

// $vtTextOriginal. THIS STARTS OUT AS THE ORIGINAL TEXT, BEFORE IT
// GETS PARSED. AS WE GO, THIS WILL GET SMALLER AND SMALLER. WHEN
// IT IS EMPTY, WE ARE DONE.

C_TEXT:C284($1; $vtTextOriginal)
$vtTextOriginal:=$1

// $vtTextFinal. THIS WILL HOLD THE FINAL TEXT, AND WILL BE ADDED TO
// AS WE WALK THROUGH THE TEXT

C_TEXT:C284($0; $vtTextFinal)
$vtTextFinal:=""

// $aoTags. THIS IS AN ARRAY OF OBJECTS THAT WILL CONTAIN THE FULLY
// PARSED TAGS AND TEXT

ARRAY OBJECT:C1221($aoTags; 0)

// ****************************************************** //
// *********** WALKING THROUGH TEXT AND PARSE *********** //
// ****************************************************** //

TP_ParseTags(->$aoTags; $vtTextOriginal)

// ****************************************************** //
// **** PROCESS ALL OF THE TAGS AND BUILD FINAL TEXT **** //
// ****************************************************** //

$vtTextFinal:=TP_ProcessTags(->$aoTags)

$0:=Replace string:C233($vtTextFinal; <>refTag; <>jitTag)  //added to put refs into the output
