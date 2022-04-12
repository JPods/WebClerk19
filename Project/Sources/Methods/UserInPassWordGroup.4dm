//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 14:25:27
// ----------------------------------------------------
// Method: UserInPassWordGroup
//   Changed To:  UserInPassWordGroup 
// Description
// Modified: 03/28/14
// Structure: CEv13_131005
// access test
// password test
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
C_BOOLEAN:C305($doChange; $0)
Case of 
	: (Application type:C494<3)  // Volume or LocalMode
		$doChange:=True:C214
	: ((Current user:C182="Admin@") | (Current user:C182="jitCorp") | (Current user:C182="Designer"))
		$doChange:=True:C214
	: (True:C214)  // by pass the password groups at this time
		$doChange:=True:C214
	Else 
		$doChange:=User in group:C338(Current user:C182; $1)
		If (Not:C34($doChange))
			If ($1#"VeryLimited")  // no cancel or alert if not in Verylimited group. 
				//Make sure Admin is not in this group
				If (allowAlerts_boo=False:C215)
					// do nothing
				Else 
					ALERT:C41("User: "+Current user:C182+" is not in password group: "+$1)
				End if 
				CANCEL:C270
			End if 
		End if 
End case 
$0:=$doChange
