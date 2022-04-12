//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/08/18, 15:55:02
// ----------------------------------------------------
// Method: Profiles_Delete
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (UserInPassWordGroup("UnlockRecord"))
	
	C_LONGINT:C283($selected; $sizeRay; $theline; $err; $viAreaList; $1)
	
	$viAreaList:=$1
	
	//  CHOPPED  $selected:=AL_GetLine($viAreaList)
	viVert:=$selected
	
	GOTO SELECTED RECORD:C245([Profile:59]; $selected)
	
	If (Record number:C243([Profile:59])>-1)
		ConsoleMessage("Deleting Profile - "+[Profile:59]name:4+" - "+[Profile:59]value:5)
	End if 
	
	If (Record number:C243([Profile:59])>-1)
		DELETE RECORD:C58([Profile:59])
		//End if 
		
		Profiles_Relate($viAreaList)
		
		//  --  CHOPPED  AL_UpdateArrays($viAreaList; -2)
		// -- AL_SetLine($viAreaList; viVert)
		// -- AL_SetScroll($viAreaList; viVert; viHorz)
		
	End if 
Else 
	ALERT:C41("Error: Authority \"UnlockRecord\" Required")
End if 
