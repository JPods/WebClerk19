//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/12/17, 08:37:24
// ----------------------------------------------------
// Method: TP_ProcessLoop
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
C_TEXT:C284($vtTextPreceeding; $vtTableNum; $vtFieldNum; $vtOutputFormat)
$vtTextPreceeding:=(OB Get:C1224($1; "TextPreceeding"))
$vtTableNum:=(OB Get:C1224($1; "TableNum"))
$vtFieldNum:=(OB Get:C1224($1; "FieldNum"))
$vtOutputFormat:=(OB Get:C1224($1; "OutputFormat"))

$vtTableNum:=Replace string:C233($vtTableNum; "begin_"; "")

// $viCount IS THE NUMBER OF TIMES WE ARE GOING TO LOOP. IT
// IS EITHER THE NUMBER OF RECORDS ON HAND, OR THE LENGTH
// OF THE ARRAY
C_LONGINT:C283($viCount)
$viCount:=0

// $vtTextFinal IS THE FINAL BLOCK OF TEXT THAT HAS BEEN
// PROCESS, WHICH WE ARE GOING TO RETURN UP
$vtTextFinal:=""

// $viTableNum IS THE INTEGER FORM OF THE TABLE NUMBER, WHICH
// IS PASSED TO THIS METHOD AS A STRING. IF IT IS -6, WE ARE
// LOOPING THROUGH AN ARRAY. IF IT IS A POSITION NUMBER, WE ARE
// LOOPING THROUGH A SET OF RECORDS.
C_LONGINT:C283($viTableNum)
$viTableNum:=Num:C11($vtTableNum)


ARRAY OBJECT:C1221($aoTags; 0)

TP_ParseTags(->$aoTags; $vtFieldNum)  // PASSING IN A POINTER BECAUSE 4D IS A RETARDED LANGUAGE THAT CAN'T RETURN ARRAYS


// ***************************************************** //
// ******* BEGIN LOOP AND RUN A NEW INSTANCE OF ******** //
// ******** AZM_ProcessTags ON THE PASSED TEXT ********* //
// ***************************************************** //

Case of 
		
		// TABLE NUM BEING GREATER THAN 0 MEANS WE ARE LOOPING THROUGH
		// THE RECORDS ON HAND
		
	: ($viTableNum>0)
		
		$tableName:=Table name:C256($viTableNum)
		$viCount:=Records in selection:C76(Table:C252($viTableNum)->)
		
		If (<>viMaxShow=0)
			<>viMaxShow:=1000
		End if 
		If ($viCount><>viMaxShow)
			REDUCE SELECTION:C351(Table:C252($viTableNum)->; <>viMaxShow)
			$viCount:=Records in selection:C76(Table:C252($viTableNum)->)
		End if 
		
		// LOOP THROUGH RECORDS IN SELECTION
		
		FIRST RECORD:C50(Table:C252($viTableNum)->)
		For ($viIncrementor; 1; $viCount)
			
			// RUN SPECIAL LOGIC FOR SPECIAL VARIABLES
			If ($viTableNum=4)
				If ([Item:4]specid:62#"")
					QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]specid:62)
				Else 
					QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]itemNum:1)
				End if 
				ItemKeyPathVariables  // need to fill in variables and pricing.
			End if 
			
			$vtTextFinal:=$vtTextFinal+TP_ProcessTags(->$aoTags)
			NEXT RECORD:C51(Table:C252($viTableNum)->)
		End for 
		
		// TABLE NUM BEING -6 MEANS THAT WE ARE LOOPING THROUGH AN ARRAY
		
	: ($viTableNum=-6)
		
		$vtArrayName:=$vtOutputFormat
		$vpArray:=Get pointer:C304($vtArrayName)
		$viCount:=Size of array:C274($vpArray->)
		
		For ($viIncrementor; 1; $viCount)
			$vtTextFinal:=$vtTextFinal+TP_ProcessTags(->$aoTags)
		End for 
		
End case 

$0:=$vtTextPreceeding+$vtTextFinal

