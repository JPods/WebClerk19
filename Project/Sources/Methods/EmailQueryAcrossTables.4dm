//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-10-08T00:00:00, 23:05:45
// ----------------------------------------------------
// Method: EmailQueryAcrossTables
// Description
// Modified: 10/08/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $userEmailSrch)
C_LONGINT:C283($0; $cnt)
C_BOOLEAN:C305($bTesting)
$bTesting:=False:C215
vResponse:=""
If (Count parameters:C259=1)
	$userEmailSrch:=$1
Else 
	$userEmailSrch:="bill@jit.cc"
	$deleteMessage_t:="delete selection"
	$bTesting:=True:C214
End if 
READ ONLY:C145([RemoteUser:57])
READ ONLY:C145([Customer:2])
READ ONLY:C145([Contact:13])
READ ONLY:C145([Rep:8])
READ ONLY:C145([Vendor:38])
$cnt:=EmailQuery(->[RemoteUser:57]email:14; $userEmailSrch; ->vResponse)
$cnt:=$cnt+EmailQuery(->[Customer:2]email:81; $userEmailSrch; ->vResponse)
$cnt:=$cnt+EmailQuery(->[Contact:13]email:35; $userEmailSrch; ->vResponse)
$cnt:=$cnt+EmailQuery(->[Rep:8]email:22; $userEmailSrch; ->vResponse)
$cnt:=$cnt+EmailQuery(->[Vendor:38]email:59; $userEmailSrch; ->vResponse)
If ($bTesting)
	$cnt:=$cnt+EmailQuery(->[EventLog:75]email:56; $userEmailSrch; ->vResponse)
End if 
If (<>viDebugMode>410)
	ConsoleLog($userEmailSrch+": "+vResponse)
End if 

READ WRITE:C146([RemoteUser:57])
READ WRITE:C146([Customer:2])
READ WRITE:C146([Contact:13])
READ WRITE:C146([Rep:8])
READ WRITE:C146([Vendor:38])
C_TEXT:C284($deleteMessage_t)
If ($deleteMessage_t="delete selection")
	If (UserInPassWordGroup("EditReportScript"))
		If ($bTesting)
			OK:=1
		Else 
			CONFIRM:C162("Delete all records with email address "+$userEmailSrch+"?"+"\r"+vResponse)
		End if 
		If (OK=1)
			If ($bTesting)
				OK:=1
			Else 
				CONFIRM:C162("Delete all records, no undo: "+$userEmailSrch+"!"+"\r"+vResponse)
			End if 
			If (OK=1)
				$cnt:=EmailQuery(->[RemoteUser:57]email:14; $userEmailSrch; ->vResponse)
				DELETE SELECTION:C66([RemoteUser:57])
				$cnt:=$cnt+EmailQuery(->[Customer:2]email:81; $userEmailSrch; ->vResponse)
				DELETE SELECTION:C66([Customer:2])
				$cnt:=$cnt+EmailQuery(->[Contact:13]email:35; $userEmailSrch; ->vResponse)
				DELETE SELECTION:C66([Contact:13])
				$cnt:=$cnt+EmailQuery(->[Rep:8]email:22; $userEmailSrch; ->vResponse)
				DELETE SELECTION:C66([Rep:8])
				$cnt:=$cnt+EmailQuery(->[Vendor:38]email:59; $userEmailSrch; ->vResponse)
				DELETE SELECTION:C66([Vendor:38])
				If ($bTesting)
					$cnt:=$cnt+EmailQuery(->[EventLog:75]email:56; $userEmailSrch; ->vResponse)
					DELETE SELECTION:C66([EventLog:75])
				End if 
				
				$cnt:=EmailQuery(->[RemoteUser:57]email:14; $userEmailSrch; ->vResponse)
				$cnt:=$cnt+EmailQuery(->[Customer:2]email:81; $userEmailSrch; ->vResponse)
				$cnt:=$cnt+EmailQuery(->[Contact:13]email:35; $userEmailSrch; ->vResponse)
				$cnt:=$cnt+EmailQuery(->[Rep:8]email:22; $userEmailSrch; ->vResponse)
				$cnt:=$cnt+EmailQuery(->[Vendor:38]email:59; $userEmailSrch; ->vResponse)
			End if 
		End if 
	Else 
		ALERT:C41("Not in password group \"EditReportScript\"")
	End if 
End if 
$deleteMessage_t:=""
$0:=$cnt
// example
// $deleteMessage_t:="delete selection"
// EmailQueryAcrossTables("bill@jit.cc")