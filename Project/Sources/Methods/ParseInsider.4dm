//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/15/11, 12:29:56
// ----------------------------------------------------
// Method: ParseInsider
// Description
// 
//
// Parameters
// ----------------------------------------------------
// Matt T Hoover - Insider Parser for 4D methods and objects //
//				- Modified : September 29 2009 //
//				- Modified : December 11 2009 for carriage return //
//				- Modified : December 15 2009 to clean up line characters //
//
vt_Title:="4D Code Parser"
vt_Version:="MTH v1.3"

vCRLF:=Char:C90(13)
vTab:=Char:C90(9)
viLineNum:=0

vtDocPath:=""
vtFileName:=""
vtFolder:=""
vtFileLine:=""
vtCurKeyWord:=""

vtCharClean_1:=Char:C90(8226)  //// replace this char with space
vtCharClean_2:=Char:C90(160)  //// replace this char with tabs
vtCharClean_2:=Char:C90(160)  //// replace this char with space
vtCharClean_2:=Char:C90(160)  //// replace this char with space

vt4DInsider:="4D Insider"
vt4DVersion:="4D Version - "

vtTable:="Table"
vtField:="Field"
vtForm:="Form"
vtProjectMethod:="Project Method"
vtObjectMethod:="Object Method"

ARRAY TEXT:C222(vtaKeywords; 0)
APPEND TO ARRAY:C911(vtaKeywords; "Table")
APPEND TO ARRAY:C911(vtaKeywords; "Field")
APPEND TO ARRAY:C911(vtaKeywords; "Form")
APPEND TO ARRAY:C911(vtaKeywords; "Project Method")
APPEND TO ARRAY:C911(vtaKeywords; "Object Method")
APPEND TO ARRAY:C911(vtaKeywords; "END")


// Define Message Feedback Window Parameters //
vSW:=(Screen width:C187\2)
vSH:=(Screen height:C188\2)
vWW:=375\2
vWH:=200\2
wrWind:=Open window:C153(vSW-vWW; vSH-vWH; vSW+vWW; vSH+vWH; Movable dialog box:K34:7; "Parsing Insider File")

If (OK=0)
	ABORT:C156  // FILE OPEN WAS CANCELED //
End if 


// OPEN THE INSIDER DOCUMENT WITH DIALOG TO GET PATH //
parseDoc:=Open document:C264(""; Get pathname:K24:6)
CLOSE DOCUMENT:C267(parseDoc)

// GET PATH TO FILE SO FOLDERS ARE IN SAME LOCATION //
vtDocPath:=Document

// OPEN FILE IN READ MODE FROM PATH //
parseDoc:=Open document:C264(vtDocPath; "TEXT"; Read mode:K24:5)

vtFolder:=vtDocPath
// REMOVE FILENAME FROM PATH FOR CREATING FOLDERS //
vlLength:=Length:C16(vtDocPath)
For (viY; vlLength; 1; -1)
	If (vtDocPath[[viY]]#Char:C90(58))  // : //
		vtDocPath:=Delete string:C232(vtDocPath; viY; 1)
	Else 
		viY:=0
	End if 
End for 

// EXTRACT FILENAME FROM PATH FOR CREATING FOLDERS //
vlLength:=Length:C16(vtFolder)
For (viY; vlLength; 1; -1)
	If (vtFolder[[viY]]=Char:C90(58))
		vtFolder:=Delete string:C232(vtFolder; 1; viY)
		viY:=0
	End if 
End for 

vtDocPath:=vtDocPath+vtFolder+":"
vtDocPath:=Replace string:C233(vtDocPath; Char:C90(46); Char:C90(95))
CREATE FOLDER:C475(vtDocPath)

// READ A LINE OF TEXT UNTIL CARRIAGE RETURN AND PLACE INTO vtFileLine//
RECEIVE PACKET:C104(parseDoc; vtFileLine; Char:C90(Carriage return:K15:38))
vtFileLine:=Replace string:C233(vtFileLine; "*"; "")
vtFileLine:=Replace string:C233(vtFileLine; Char:C90(202); Char:C90(9))
viLineNum:=viLineNum+1

RECEIVE PACKET:C104(parseDoc; vtFileLine; Char:C90(Carriage return:K15:38))  // 2nd LINE IS VERSION//
vtFileLine:=Replace string:C233(vtFileLine; "*"; "")
vtFileLine:=Replace string:C233(vtFileLine; Char:C90(202); Char:C90(9))
vt4DVersion:=vt4DVersion+vtFileLine
viLineNum:=viLineNum+1

viX:=1
vtCurKeyWord:=vtaKeywords{viX}

Repeat 
	RECEIVE PACKET:C104(parseDoc; vtFileLine; Char:C90(Carriage return:K15:38))
	vtFileLine:=Replace string:C233(vtFileLine; "*"; "")
	vtFileLine:=Replace string:C233(vtFileLine; Char:C90(202); "")
	viLineNum:=viLineNum+1
	
	GOTO XY:C161(1; 3)
	MESSAGE:C88("Searching for Keyword # "+String:C10(viX)+"-"+vtaKeywords{viX})
	GOTO XY:C161(1; 5)
	MESSAGE:C88("File Line # : "+String:C10(viLineNum))
	GOTO XY:C161(1; 9)
	MESSAGE:C88("PRESS SHIT KEY TO ABORT")
	
	If ((Position:C15(vtaKeywords{viX}; vtFileLine)=1) & (vtaKeywords{viX}#"END"))  // FOUND KEYWORD //
		vtCurKeyWord:=vtaKeywords{viX}
		
		GOTO XY:C161(1; 3)
		MESSAGE:C88("Searching for Keyword # "+String:C10(viX)+"-"+vtaKeywords{viX})
		GOTO XY:C161(1; 5)
		MESSAGE:C88("File Line # : "+String:C10(viLineNum))
		GOTO XY:C161(1; 7)
		MESSAGE:C88(vtFileLine)
		GOTO XY:C161(1; 9)
		MESSAGE:C88("PRESS SHIT KEY TO ABORT")
		
		// CREATE SEPARATE FOLDERS PER KEYWORD, FIELD, FORM, OBJECT/PROJECT METHODS //
		CREATE FOLDER:C475(vtDocPath+vtaKeywords{viX})
		
		Repeat 
			
			vtFileName:=vtFileLine
			vtFileLine:=""
			myDoc:=Create document:C266(vtDocPath+vtaKeywords{viX}+":"+vtFileName+".txt")
			
			If (OK=1)
				SEND PACKET:C103(myDoc; vtFileName+vCRLF)  // FILE NAME HEADER
			End if   //
			
			
			While ((((Position:C15(vtaKeywords{viX}; vtFileLine)=0) & (Position:C15(vtaKeywords{viX+1}; vtFileLine)=0)) | (Position:C15(vTab; vtFileLine)=1)) & (OK=1))
				RECEIVE PACKET:C104(parseDoc; vtFileLine; Char:C90(Carriage return:K15:38))
				vtFileLine:=Replace string:C233(vtFileLine; "*"; "")
				vtFileLine:=Replace string:C233(vtFileLine; Char:C90(202); Char:C90(9))
				viLineNum:=viLineNum+1
				
				ERASE WINDOW:C160
				GOTO XY:C161(1; 3)
				MESSAGE:C88("Searching for Keyword # "+String:C10(viX)+"-"+vtaKeywords{viX})
				GOTO XY:C161(1; 5)
				MESSAGE:C88("File Line # : "+String:C10(viLineNum))
				GOTO XY:C161(1; 7)
				MESSAGE:C88(vtFileLine)
				GOTO XY:C161(1; 9)
				MESSAGE:C88("PRESS SHIT KEY TO ABORT")
				
				If (((Position:C15(vtaKeywords{viX}; vtFileLine)#1) & (Position:C15(vtaKeywords{viX+1}; vtFileLine)#1)) & (OK=1))
					SEND PACKET:C103(myDoc; vtFileLine+vCRLF)
				End if 
				
				If (Shift down:C543)
					CLOSE DOCUMENT:C267(parseDoc)
					CLOSE DOCUMENT:C267(myDoc)
					ARRAY TEXT:C222(vtaKeywords; 0)
					ALERT:C41("Parsing Canceled")
					ALERT:C41("OK = "+String:C10(OK))
					ALERT:C41("vtFileLine = "+":"+vtFileLine+":")
					ABORT:C156
				End if 
			End while 
			
			CLOSE DOCUMENT:C267(myDoc)
			
			If (Position:C15(vtaKeywords{viX}; vtFileLine)=1)
				vtCurKeyWord:=vtaKeywords{viX}
			Else 
				vtCurKeyWord:=""
			End if 
			
		Until ((vtCurKeyWord#vtaKeywords{viX}) & (OK=0))
		
		viX:=viX+1
		
		If (OK=1)
			// SET TEXT DOCUMENT POINTER BACK 1 LINE SINCE FOUND NEXT KEYWORD TO USE FOR NEW FILE NAME AND CONTENTS //
			SET DOCUMENT POSITION:C482(parseDoc; (-1-Length:C16(vtFileLine)); 3)
		End if 
		
	End if 
	
	If (Shift down:C543)
		CLOSE DOCUMENT:C267(parseDoc)
		CLOSE DOCUMENT:C267(myDoc)
		ARRAY TEXT:C222(vtaKeywords; 0)
		ALERT:C41("Parsing Canceled")
		ABORT:C156
	End if 
	
Until (OK=0) & (vtaKeywords{viX}#"END")


CLOSE DOCUMENT:C267(parseDoc)
ARRAY TEXT:C222(vtaKeywords; 0)
ALERT:C41("Parsing Complete")
