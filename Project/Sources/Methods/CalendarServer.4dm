//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/21/06, 10:39:21
// ----------------------------------------------------
// Method: Method: CalendarServer
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)
C_POINTER:C301($2)
C_TEXT:C284($iCal)
//
$c:=$1
vResponse:="Incorrect Calendar Command"
//$remoteUser:=Http_SrchUserOnly($1; ->vText11)
$doPage:=WC_DoPage("Error.html"; "")
$vbSendPage:=True:C214
Case of 
	: (vText11="Post /Calendar_@")
		
		//WccSaveRecord 
		//WC_Parse ($tableNum;$2;True)
		
	: (voState.url="/Calendar_Load@")
		$iCal:=CalendarOut($1; $2)
		
	: (voState.url="/Calendar_EmployeesList@")
		CalendarListEmployees($1; $2)
		$vbSendPage:=False:C215
	: (voState.url="/Calendar_SaveRecord@")
		CalendarSaveRecord($1; $2)
		$vbSendPage:=False:C215
	: (voState.url="/Calendar_Record@")
		CalendarRecord($1; $2)
		$vbSendPage:=False:C215
	Else 
		
End case 
If ($vbSendPage)
	Http_SendWWWHd($1; "text/html"; Length:C16($iCal))
	$err:=TCP Send($1; $iCal)
End if 

//