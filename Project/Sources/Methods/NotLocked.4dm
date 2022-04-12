//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-10-16T00:00:00, 10:36:34
// ----------------------------------------------------
// Method: NotLocked
// Description
// Modified: 10/16/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// ----------------------------------------------------

// pass if not locked
// take action based on locked record, current user, and type of process

C_POINTER:C301($1)
C_BOOLEAN:C305($0)
$0:=False:C215
If (Locked:C147($1->)=False:C215)
	$0:=True:C214
Else 
	$0:=False:C215
	C_LONGINT:C283($Process)
	C_TEXT:C284($User; $Machine; $Name; $processname)
	LOCKED BY:C353($1->; $Process; $User; $Machine; $Name)
	C_LONGINT:C283($tasks; $Process; $state; $tics)
	PROCESS PROPERTIES:C336($Process; $processname; $state; $tics)
	
	Case of 
		: ($Process=0)
			//pass through
		: ($processname="@http@")
			// skip if a web process
			
		: (($Process#0) & (($Machine="") | ($Machine=Current system user:C484)))
			BRING TO FRONT:C326($Process)
			CANCEL:C270
			$0:=False:C215
		: (($Process=0) & (($Machine="") | ($Machine=Current system user:C484)))
			If (allowAlerts_boo)
				CONFIRM:C162("Open, but record is locked by User: "+$User+", on Machine: "+$Machine+", in Process: "+$Name)
				If (Ok=1)
					CANCEL:C270
					$0:=False:C215
				End if 
			End if 
	End case 
End if 
