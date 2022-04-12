//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/28/09, 03:38:10
// ----------------------------------------------------
// Method: TIO_InitGlobals
// Description
// Reason:  Token and Picture Array Type
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)  //pointer to text: path to file to read (Parse and Run)
//
ARRAY LONGINT:C221(aTIOTypeCd; 0)  //Type Codes for each line
ARRAY POINTER:C280(aTIOTypePtr; 0)  //pointer to lines info
ARRAY LONGINT:C221(aTIOTyIndex; 0)  //index relating to a command
ARRAY LONGINT:C221(aTIOTyRData; 0)  //runtime data, temp copies of data like loop iterators
//token
ARRAY TEXT:C222(aTIOText; 0)  //Text pointed to by aTOutTypePt
//ARRAY PICTURE(aTIOPicture;0)//Pictures pointed to by aTOutTypePt   version 2004
ARRAY TEXT:C222(aTIOPicture; 0)  //Pictures pointed to by aTOutTypePt   version 11  
ARRAY LONGINT:C221(aTIOInteger; 0)  //Integers pointed to by aTOutTypePt
ARRAY LONGINT:C221(aTIORStack; 0)  //return stack
C_LONGINT:C283(iTIORStkHd)  //Return Stack Head
iTIORStkHd:=1  //First elem is the next elem availiable
ARRAY LONGINT:C221(aTIOExStack; 0)  //Exit Loop stack
C_LONGINT:C283(iTIOExStkHd)  //Exit Stack Head
iTIOExStkHd:=1  //First elem is the next elem availiable
ARRAY LONGINT:C221(aTIOIsStack; 0)  //Is List stack
C_LONGINT:C283(iTIOIsStkHd)  //Is Stack Head
iTIOIsStkHd:=1  //First elem is the next elem availiable
ARRAY LONGINT:C221(aTIOIXStack; 0)  //Is List Exit stack
C_LONGINT:C283(iTIOIXStkHd)  //Is Stack Head
iTIOIXStkHd:=1  //First elem is the next elem availiable
C_LONGINT:C283(iTIONameBgn; iTIONameEnd)  //File Name Starting and End Indexes
iTIONameBgn:=0
iTIONameEnd:=0
C_LONGINT:C283(iTIOProgCtr)  //Program Counter: the current aTIOTypeCd/Ptr elem to run
C_LONGINT:C283(iTIOPCLast)  //Points to Command executed last cycle, = last of value of iTIOProgCtr
C_TEXT:C284(tPlugInPath)  //Path to the Plug-In File
C_TEXT:C284(tTIODstPath)  //Path to place Resulting Files
C_TEXT:C284(tTIOTxtData)  //used in TIOx_Parse, TIOO_CreateOutp
C_TEXT:C284(tTIOPath)  //used in TIOx_ParseInLn
//TIOI Globals
C_TIME:C306(tmFileID)  //used in TIOI_GetInput
C_TEXT:C284(tTIOIBuffer)
C_TEXT:C284(tTIOIUnRead)
C_BOOLEAN:C305(bTIOIError)
C_BOOLEAN:C305(bTIOIAtEOF)
C_LONGINT:C283(lTIOIErrNum)
C_BOOLEAN:C305(bTIOLogEvnt)  //If true diagnostic events are logged to [EventLog]
bTIOLogEvnt:=False:C215  //by default do not log debug events
//
If (Not:C34(Is nil pointer:C315($1)))
	tPlugInPath:=Util_GetParentName($1->)
	If (Not:C34(Is nil pointer:C315($2)))
		tTIODstPath:=$2->
	Else 
		tTIODstPath:=tPlugInPath
	End if 
Else 
	CLEAR VARIABLE:C89(tPlugInPath)
	CLEAR VARIABLE:C89(tTIODstPath)
	CLEAR VARIABLE:C89(tTIOIBuffer)
	CLEAR VARIABLE:C89(tTIOIUnRead)
End if 