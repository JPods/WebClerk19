//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 09:10:08
// ----------------------------------------------------
// Method: TallyAdEffects
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("AdminControl"))
	//tallyAdEffects
	C_REAL:C285($amt)
	
	CONFIRM:C162("Tallying Sources will take a while.  Do you wish to proceed.")
	If (OK=1)
		//jBetweenDates ("Enter Period for Sales by Lead Source.")
		//If (OK=1)
		TallyAdLoop
		//End if 
	End if 
End if 