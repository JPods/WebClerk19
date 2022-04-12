//%attributes = {"publishedWeb":true}
//Procedure: TIOO_ReadFile

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/01/16, 15:22:06
// ----------------------------------------------------
// Method: TIOO_ReadFile
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160201_1522 commented out test for document type


C_POINTER:C301($1)  //pointer to text: path to file to read (Parse and Run)
C_POINTER:C301($2)  //Ptr to Text: Destination Folder Path
C_BOOLEAN:C305($isText)

//If (Is macOS)
//$isText:=(Document type($1->)="TEXT")
//Else 
//$isText:=True  //can't tell, don't really care that much anyway
//End if 


//If ($isText)
TIO_InitGlobals($1; $2)
If (TIOO_Parse($1; True:C214)=1)
	If (<>viDebugMode>=3)  // ### jwm ### 20170329_1300 pause after reading file when debugging
		TRACE:C157
	End if 
	TIOO_CreateOutp
End if 
TIO_InitGlobals(<>cptNilPoint; <>cptNilPoint)
//End if 