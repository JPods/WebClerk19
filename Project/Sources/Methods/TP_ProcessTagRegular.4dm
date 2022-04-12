//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/12/17, 08:37:24
// ----------------------------------------------------
// Method: TP_ProcessTag
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
// $0 is a chunk of text that has been parsed and is returned up to AZM_ProcessTags
// ----------------------------------------------------

// ******************************************* //
// **** TYPE AND INITIALIZE ALL VARIABLES **** //
// ******************************************* //

// RETURN VARIABLE
C_TEXT:C284($0)
$0:=""

// PARAMETER 1 IS THE PARSED TAG WHICH NEEDS TO BE PROCESSED
C_OBJECT:C1216($1)

// SPLIT THE PARSED TAG OUT OF AN OBJECT INTO THREE TEXT
// TEXT VARIABLES, FOR READABILITY
C_TEXT:C284($vtTextPreceeding; $vtTableNum; $vtFieldNum; $vtOutputFormat)
$vtTextPreceeding:=(OB Get:C1224($1; "TextPreceeding"))
$vtTableNum:=(OB Get:C1224($1; "TableNum"))
$vtFieldNum:=(OB Get:C1224($1; "FieldNum"))
$vtOutputFormat:=(OB Get:C1224($1; "OutputFormat"))

// echo_t. THIS VARIABLE HOLDS THE VALUE OF EVERYTHING
// PLACED INTO AN echo() FUNCTION INSIDE THE CURRENT -6 SCRIPT
C_TEXT:C284(echo_t)
echo_t:=""

// $vtTextFinal. A TEXT VARIABLE WHICH IS THE FINAL PROCESSED
// TEXT. THIS MAY BE RETURNED AS AN EMPTY STRING IF THE TAG IS
// A SCRIPT TAG
C_TEXT:C284($vtTextFinal)
$vtTextFinal:=""

// $viTableNum. 
C_LONGINT:C283($viTableNum)
$viTableNum:=Num:C11($vtTableNum)

// ******************************************** //
// ** CONFIRM THAT WE HAVE A <>WebRealFormat ** //
// ******************************************** //

If (<>WebRealFormat="")
	<>vlWebRealPr:=2
	<>WebRealFormat:=("###,###,###,##0.00")
End if 

// ******************************************** //
// ** PROCESS THE TAG, DEPENDING ON THE TYPE ** //
// ******************************************** //

If ($vtTableNum#"")
	
	Case of 
		: ($viTableNum=-6)  //page executable
			echo_t:=""
			ExecuteText(0; $vtFieldNum)
			$vtTextFinal:=echo_t
			echo_t:=""
		: ($viTableNum=-3)  //page executable
			$vtTextFinal:=PageGetObject($vtFieldNum)
			$vtTextFinal:=TP_TagsToText($vtTextFinal)
		: ($viTableNum=-2)  //array elements
			$vtTextFinal:=TP_GetValueFromArray($vtFieldNum; $vtOutputFormat)
		: ($viTableNum=0)  //Variables
			$vtTextFinal:=TP_GetValueFromVar($vtFieldNum; $vtOutputFormat)
		: ($viTableNum>0)
			$vtTextFinal:=TP_GetValueFromCurRec($vtTableNum; $vtFieldNum; $vtOutputFormat)
		Else 
			$vtTextFinal:="Error: Unable to process the tag: _jit_"+$vtTableNum+"_"+$vtFieldNum+"jj"
	End case 
	
End if 

// RETURN PROCESSED TEXT

$0:=$vtTextPreceeding+$vtTextFinal