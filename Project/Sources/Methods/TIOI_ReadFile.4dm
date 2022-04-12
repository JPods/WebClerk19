//%attributes = {"publishedWeb":true}
//Procedure: TIOI_ReadFile

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/01/16, 15:27:47
// ----------------------------------------------------
// Method: TIOI_ReadFile
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160201_1527 commented out test for document type

C_LONGINT:C283($0)  //
C_POINTER:C301($1)  //pointer to text: path to TIOI file to run (Parse and Run)
C_POINTER:C301($2)  //pointer to text: path to file to read

// ### jwm ### 20160121_1729 MAY NEED TO REMOVE THIS TEST FOR OS X
C_BOOLEAN:C305($isText)
//If (Is macOS)
//$isText:=(Document type($1->)="TEXT")
//Else 
//$isText:=True  //can't tell, don't really care that much anyway
//End if 
//$isText:=True  // ### jwm ### 20160128_1618
//If ($isText)
TIO_InitGlobals($1; <>cptNilPoint)
//TRACE
If (TIOI_Parse($1; True:C214)=1)
	If (<>viDebugMode>=3)  // ### jwm ### 20170329_1300 pause after reading file when debugging
		TRACE:C157
	End if 
	$0:=TIOI_GetInput($2)
Else 
	$0:=<>ciTIOIParse
End if 
TIO_InitGlobals(<>cptNilPoint; <>cptNilPoint)
//Else 
//$0:=<>ciTIOIFile  //bad Text-In File
//End if 