//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 07/06/17, 12:42:59
// ----------------------------------------------------
// Method: jpwChange
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($pw1; $pw2)
CHANGE CURRENT USER:C289
If (OK=1)
	C_OBJECT:C1216($obRec)
	$obRec:=ds:C1482.TallyMaster.query("name= :1 purpose= :2"; "ChangePassword"; "Scripts").first()
	If ($obRec#Null:C1517)
		ExecuteText(0; $obRec.script)  //no confirm
	Else 
		// original change password
		CONFIRM:C162("Change Password by entering the Password twice.")
		If (OK=1)
			$pw1:=Request:C163("Enter New Password")
			If (OK=1)
				$pw2:=Request:C163("Confirm password:")
				If ((OK=1) & ($pw1=$pw2))
					CHANGE PASSWORD:C186($pw1)
				Else 
					ALERT:C41("Password entries did not match.  Try again.")
				End if 
			End if 
		End if 
	End if 
	jpwNewUser
End if 
