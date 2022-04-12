//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/12/17, 08:37:24
// ----------------------------------------------------
// Method: TP_ParseTags
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

// RETURN VARIABLE

ARRAY OBJECT:C1221($aoTags; 0)

// $vtTextOriginal. THIS STARTS OUT AS THE ORIGINAL TEXT, BEFORE IT
// GETS PARSED. AS WE GO, THIS WILL GET SMALLER AND SMALLER. WHEN
// IT IS EMPTY, WE ARE DONE.

C_TEXT:C284($2; $vtTextOriginal)
$vtTextOriginal:=$2

// $1 IS PASSED VIA POINTER, SO WE DON'T NEED TO TYPE IT. THIS IS BECAUSE
// 4D CAN'T PASS ARRAYS VIA PARAMETERS TO USER DEFINED METHODS, AND $1 IS
// AN ARRAY OF OBJECTS. IT IS THE VEHICLE THAT WE USE TO RETURN THE ARRAY
// OF OBJECTS THAT WE ARE BUILDING IN THIS METHOD, BECAUSE 4D ALSO CAN'T
// RETURN ARRAYS.

// ARRAY OBJECT($1;0) .. JUST A FAKE LINE TO HELP REMEMBER WHAT IS HAPPENING


// $vtTextTag. THIS IS THE TEXT THAT WE ARE CURRENTLY PARSING. WE
// SPLIT IT OFF FROM THE PRE-PARSED TEXT CHUNK, PARSE IT, AND APPEND
// IT TO THE FINAL TEXT.

C_TEXT:C284($vtTextTag)
$vtTextTag:=""

// $vbEndLoop. THIS IS A BOOLEAN WHICH IS INITIALLY FALSE. AS LONG AS
// IT IS FALSE, WE WILL CONTINUE THE REPEAT LOOP AND KEEP WALKING
// THROUGH THE BLOCK OF TEXT. IF BECOMES TRUE WHEN THE TEXT BLOCK CONTAINS
// NO MORE JIT TAGS.

C_BOOLEAN:C305($vbEndLoop)
$vbEndLoop:=False:C215


// $voWebTag. THIS IS AN OBJECT THAT WILL BE SET IN EACH LOOP AS THE PARSED
// TAG.

C_OBJECT:C1216($voTag)

// $vtTextPreceeding IS THE RAW TEXT THAT PRECEEDS THE CURRENT TAG.

C_TEXT:C284($vtTextPreceeding)
$vtTextPreceeding:=""

// $vtTableNum. THIS HOLDS THE TABLE NUMBER OF A PARSED TAG. IT WILL
// CHANGE OVER AND OVER AS WE GO THROUGH EACH TAG.

C_TEXT:C284($vtTableNum)
$vtTableNum:=""

// $vtFieldNum. THIS HOLDS THE FIELD NUMBER OF A PARSED TAG. IT WILL
// CHANGE OVER AND OVER AS WE GO THROUGH EACH TAG.

C_TEXT:C284($vtFieldNum)
$vtFieldNum:=""

// $vpBegin and $vpEnd are position tags.

C_LONGINT:C283($viPosEnd; $viPosBegin)

// ******************************************* //
// ***** WALKING THROUGH TEXT AND PARSE ****** //
// ******************************************* //

Repeat 
	
	// GET THE POSITION OF THE EARLIEST JIT TAG IN $vtTextOriginal
	$viPosBegin:=Position:C15(<>jitTag; $vtTextOriginal)  //find the next tag beginning
	
	// IF POSITION IS LESS THAN 0, THERE ARE NO MORE JIT TAGS, SO WE CAN
	// END THE LOOP
	
	If ($viPosBegin<1)
		
		$vbEndLoop:=True:C214
		
	Else 
		
		// THERE IS AT LEAST ONE JIT TAG IN $vtTextOriginal. SO FIRST OFF, WE
		// NEED TO SNIP OFF TEXT FROM THE START OF $vtTextOriginal UP TO THE
		// FIRST JIT TAG. THIS SNIPPED TEXT GOES STRAIGHT INTO $testParsed
		// BECAUSE IT DOESN'T NEED TO BE PARSED.
		
		$vtTextPreceeding:=Substring:C12($vtTextOriginal; 1; $viPosBegin-1)
		$vtTextOriginal:=Substring:C12($vtTextOriginal; $viPosBegin+<>lenJitTag)
		
		// GET THE POSITION OF THE EARLIEST JIT CLOSING TAG
		
		$viPosEnd:=Position:C15(<>endTag; $vtTextOriginal)
		$vtTextTag:=Substring:C12($vtTextOriginal; 1; $viPosEnd-1)
		$vtTextOriginal:=Substring:C12($vtTextOriginal; $viPosEnd+<>lenEndTag)
		
		$voTag:=TP_ParseTag($vtTextPreceeding; $vtTextTag)
		
		// CHECK TO SEE IF THE TAG IS A BEGIN TAG
		
		$vtTableNum:=(OB Get:C1224($voTag; "TableNum"))
		$vtFieldNum:=(OB Get:C1224($voTag; "FieldNum"))
		
		If ($vtTableNum="begin")
			
			$viPosEnd:=Position:C15("_jit_end_jj"; $vtTextOriginal)
			$vtTextTag:=Substring:C12($vtTextOriginal; 1; $viPosEnd-1)
			$vtTextOriginal:=Substring:C12($vtTextOriginal; $viPosEnd+Length:C16("_jit_end_jj"))
			
			OB SET:C1220($voTag; "TableNum"; "begin_"+$vtFieldNum)
			OB SET:C1220($voTag; "FieldNum"; $vtTextTag)
			
		End if 
		
		If ($vtTableNum="if")
			
			$viPosEnd:=Position:C15("_jit_endif_jj"; $vtTextOriginal)
			$vtTextTag:=Substring:C12($vtTextOriginal; 1; $viPosEnd-1)
			$vtTextOriginal:=Substring:C12($vtTextOriginal; $viPosEnd+Length:C16("_jit_endif_jj"))
			
			OB SET:C1220($voTag; "TableNum"; "if_"+$vtFieldNum)
			OB SET:C1220($voTag; "FieldNum"; $vtTextTag)
			
		End if 
		
		APPEND TO ARRAY:C911($aoTags; $voTag)
		
	End if 
	
Until ($vbEndLoop)

// ADD REMAINING TEXT WHICH DOESN'T NEED TO BE PARSED TO THE OUTPUT

$voTag:=TP_ParseTag($vtTextOriginal; "")

APPEND TO ARRAY:C911($aoTags; $voTag)

// RETURN FINAL PARSED TEXT

COPY ARRAY:C226($aoTags; $1->)

