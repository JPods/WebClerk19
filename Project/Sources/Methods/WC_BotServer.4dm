//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/24/20, 01:41:04
// ----------------------------------------------------
// Method: WC_BotServer
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($vbSendConsole)
$vbSendConsole:=True:C214

C_LONGINT:C283($1; $socket)
$socket:=voState.socket

C_TEXT:C284($vtjson; $vtPod)
C_LONGINT:C283($viTableNum)

If (Macintosh command down:C546)
	
End if 
Case of 
	: ((voState.url="/Bots/watchdog@") | (voState.url="/Bots/pod@"))
		
		vResponse:=JSON Stringify:C1217(voState)
		ConsoleLog(vResponse)
		
	: (voState.url="/Bots/MapMyStation@")
		vResponse:="Error: None, Stations Mapped"
		
		OB SET:C1220([EventLog:75]obGeneral:58; "MapMyStations"; voState)
		[EventLog:75]status:48:="MapMyStation"
		[EventLog:75]source:29:=voState.request.headers.Host
		[EventLog:75]dateCreated:50:=Current date:C33
		[EventLog:75]dtEvent:1:=DateTime_DTTo
		SAVE RECORD:C53([EventLog:75])
		
	Else 
		vResponse:="Error: No axaj handler: "+Substring:C12(voState.url; 1; 40)
End case 


