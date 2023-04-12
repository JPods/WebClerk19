//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/26/16, 15:59:10
// ----------------------------------------------------
// Method: EDI_PackOrder_Client
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Script cleaned 160802
// Script PackOrder OnServer 20160331

// Execute_TallyMaster("PackOrder";"OnServer";3)

// ===================================================
// Client Side Process
// ===================================================

// ===================================================
// Setup & Initialize Variables, Arrays, User Input
// ===================================================
ARRAY LONGINT:C221(alRecords; 0)
// ARRAY TEXT (aText2;0)// initialized in Detail_LX.inc
// ARRAY REAL (aReal1;0)// initialized in Detail_LX.inc
// ARRAY LONGINT (aLongInt1;0)// initialized in Detail_LX.inc

C_LONGINT:C283(viCounter; viReady; viWtPrecision; vlOrderNum; vlProcessID; vlTestID; vlWindowID)
C_REAL:C285(<>vrWeightScale; vr1; vR2; vr3; vrWeightScale)
C_TEXT:C284(vText; vText2; vtStatus; vtTitle; vtTrackingNum)
ConsoleLog("Client Type(vtTitle) = "+String:C10(Type:C295(vtTitle)))

viReady:=0
viCounter:=0
vtStatus:=""
vtTitle:=""
ConsoleLog("Client Type(vtTitle) = "+String:C10(Type:C295(vtTitle)))
iLoInteger1:=0
viWtPrecision:=3
vrWeightScale:=<>vrWeightScale

// ===================================================
// Launch Server Side Process, Status Window
// ===================================================

// Execute on server ( procedure ; stack {; name {; param {; param2 ; ... ; paramN}}}{; *}) -> Function result  
//vlProcessID:=Execute on server("ExecuteText";<>tcPrsMemory;String(Count user processes)+"-OnServer";0;[TallyMaster]Build;*)
vlProcessID:=Execute on server:C373("EDI_PackOrder_Server"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-OnServer"; *)
vlTestID:=Abs:C99(vlProcessID)
DELAY PROCESS:C323(Current process:C322; 30)  // debug test delay allow server process to get started

vlWindowID:=Open window:C153(100; 200; 500; 300; -1984; "Status")
ERASE WINDOW:C160
GOTO XY:C161(3; 3)

// ===================================================
// Wait for Server Process to be Ready
// ===================================================

While ((viReady=0) & (viCounter<18000))  // timeout = 1/2 hour
	DELAY PROCESS:C323(Current process:C322; 6)
	viCounter:=viCounter+1
	GET PROCESS VARIABLE:C371(-vlTestID; viReady; viReady; vtStatus; vtStatus; vtTitle; vtTitle)
	If (vtTitle#"")
		SET WINDOW TITLE:C213(vtTitle; vlWindowID)
	End if 
	If (vtStatus#"")
		ERASE WINDOW:C160
		GOTO XY:C161(3; 3)
		MESSAGE:C88(vtStatus)
	End if 
End while 

// ===================================================
// server ready, load client variables to server
// ===================================================

// variables passed for this script
// should have one Order selected
// SELECTION TO ARRAY([Order];alRecords)
// VARIABLE TO VARIABLE (-vlTestID;alRecords;alRecords)
VARIABLE TO VARIABLE:C635(-vlTestID; aText2; aText2)
VARIABLE TO VARIABLE:C635(-vlTestID; aReal1; aReal1)
VARIABLE TO VARIABLE:C635(-vlTestID; aLongInt1; aLongInt1)
VARIABLE TO VARIABLE:C635(-vlTestID; vrWeightScale; vrWeightScale)
VARIABLE TO VARIABLE:C635(-vlTestID; vr3; vr3)
VARIABLE TO VARIABLE:C635(-vlTestID; vtTrackingNum; vtTrackingNum)
VARIABLE TO VARIABLE:C635(-vlTestID; vlOrderNum; vlOrderNum)

// ===================================================
// set ready = 2 Run Server Process
// ===================================================
viReady:=2
SET PROCESS VARIABLE:C370(-vlTestID; viReady; viReady)

// ===================================================
// Wait for Server Process to Complete, Display Status
// ===================================================

While ((viReady<3) & (viCounter<18000))  // timeout = 1/2 hour
	DELAY PROCESS:C323(Current process:C322; 6)
	viCounter:=viCounter+1
	GET PROCESS VARIABLE:C371(-vlTestID; viReady; viReady; vtStatus; vtStatus; vtTitle; vtTitle)
	If (vtTitle#"")
		SET WINDOW TITLE:C213(vtTitle; vlWindowID)
	End if 
	If (vtStatus#"")
		ERASE WINDOW:C160
		GOTO XY:C161(3; 3)
		MESSAGE:C88(vtStatus)
	End if 
End while 

// ===================================================
// Retrieve Results from Server Process
// ===================================================
// Not passing a SET of Records
// Get PROCESS VARIABLE(-vlTestID;alRecords;alRecords)
// CREATE SET FROM ARRAY ([LoadTag]; alRecords; "myRecords")
// Use Set("myRecords")
// Get PROCESS VARIABLE(-vlTestID;aText1;aText1)


// ===================================================
// Set Ready = 4 Data Retrieval Complete
// ===================================================
viReady:=4
SET PROCESS VARIABLE:C370(-vlTestID; viReady; viReady)

// clean up status window
ERASE WINDOW:C160
CLOSE WINDOW:C154

// ===================================================
// ///////////////////////////////////////////////////
// ===================================================