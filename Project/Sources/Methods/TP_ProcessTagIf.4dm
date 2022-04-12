//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/12/17, 08:37:24
// ----------------------------------------------------
// Method: TP_ProcessIf
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
// $1 is an object that contains the number of the table (in string format)
// that is being looped through, the content that we are parsing, and the
// format.
// 
// Return:
//
// $0 is a chunk of text that has been parsed.
// ----------------------------------------------------

// ******************************************* //
// **** TYPE AND INITIALIZE ALL VARIABLES **** //
// ******************************************* //

// PARAMETER 1 (AN OBJECT CONTAINING THE PARSED LOOP TAG)
C_OBJECT:C1216($1)
C_TEXT:C284($vtTextPreceeding; $vtConditionVariableName; $vtConditionalText; $vtTextFinal)
$vtTextPreceeding:=(OB Get:C1224($1; "TextPreceeding"))
$vtConditionVariableName:=(OB Get:C1224($1; "TableNum"))
$vtConditionalText:=(OB Get:C1224($1; "FieldNum"))
$vtConditionVariableName:=Replace string:C233($vtConditionVariableName; "if_"; "")

// $vtTextFinal IS THE FINAL BLOCK OF TEXT THAT HAS BEEN
// PROCESS, WHICH WE ARE GOING TO RETURN UP
$vtTextFinal:=""

// GET A POINTER TO THE CONDITION

C_POINTER:C301($vpCondition)
$vpCondition:=Get pointer:C304($vtConditionVariableName)

// IF THE CONDITION IS TRUE, INSERT PROCESS AND INSERT THE TEXT BETWEEN BEGIN AND END IF TAGS

If ($vpCondition->)
	
	$vtTextFinal:=TP_TagsToText($vtConditionalText)
	
End if 

$0:=$vtTextPreceeding+$vtTextFinal

