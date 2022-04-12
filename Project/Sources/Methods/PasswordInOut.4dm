//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/25/09, 11:28:10
// ----------------------------------------------------
// Method: PasswordInOut
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("AdminControl"))
	TRACE:C157
	C_LONGINT:C283($1; $inAction)
	C_BOOLEAN:C305($noUsers)
	If (Count parameters:C259=1)
		$inAction:=$1
	Else 
		$inAction:=0
	End if 
	QUERY:C277([UserReport:46]; [UserReport:46]name:2="Passwords_Saved")
	If (Records in selection:C76([UserReport:46])=0)
		CREATE RECORD:C68([UserReport:46])
		
		[UserReport:46]name:2:="Passwords_Saved"
		[UserReport:46]why:9:="Backup of Passwords"
		[UserReport:46]tableNum:3:=1
		[UserReport:46]tableName:47:="Control"
		SAVE RECORD:C53([UserReport:46])
		$noUsers:=True:C214
	End if 
	If ($inAction=0)
		VTIME1:=Create document:C266("")
		If (OK=1)
			CLOSE DOCUMENT:C267(VTIME1)
			USERS TO BLOB:C849(iLoBlob1)
			BLOB TO DOCUMENT:C526(document; iLoBlob1)
			If (False:C215)
				VTIME1:=Open document:C264("")
				If (OK=1)
					CLOSE DOCUMENT:C267(VTIME1)
					SET BLOB SIZE:C606(iLoBlob1; 0)
					DOCUMENT TO BLOB:C525(document; iLoBlob1)
				End if 
			End if 
			[UserReport:46]reportBlob:27:=iLoBlob1
			SAVE RECORD:C53([UserReport:46])
			ALERT:C41("Users saved.")
		Else 
			ALERT:C41("Users did not save.")
		End if 
	Else 
		If ($noUsers)
			ALERT:C41("There were no saved UserNames")
		Else 
			BLOB TO USERS:C850([UserReport:46]reportBlob:27)
			ALERT:C41("Users saved.")
		End if 
	End if 
	UNLOAD RECORD:C212([UserReport:46])
	
End if 