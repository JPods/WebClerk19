//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 04/11/20, 09:02:25
// ----------------------------------------------------
// Method: USR_IsAllowedTo
//
// Description:
// 
// This method is sent the name of a permission group, and
// returns either true or false, depending if teh current
// user is a member of that group. If the current user is
// WebClerk, it loads the current RemoteUser.
// 

// ********************************************************************************************  //
// ** TYPE AND INITIALIZE PARAMETERS **********************************************************  //
// ********************************************************************************************  //

// RETURN VARIABLE
C_BOOLEAN:C305($0; $vbUserIsAllowedToTakeAction)
$vbUserIsAllowedToTakeAction:=False:C215

// PARAMETER 1 IS THE NAME OF THE PERMISSION GROUP
C_TEXT:C284($1; $vtAction)  // CreateRecord|EditRecord|ViewRecord|ViewRecords|ViewResourceSummary|ViewPage
$vtAction:=$1

// PARAMETER 1 IS THE NAME OF THE PERMISSION GROUP
C_TEXT:C284($2; $vtResourceNameOrURLFrag)  // customers|contacts|etc ... or /search/
$vtResourceNameOrURLFrag:=$2

// PARAMETER 1 IS THE NAME OF THE PERMISSION GROUP
C_TEXT:C284($vtUniqueID)
$vtUniqueID:=""
If (Count parameters:C259>=3)
	C_TEXT:C284($3)
	$vtUniqueID:=$3
End if 

C_OBJECT:C1216($voUserDefinition)
If (Count parameters:C259>=4)
	C_OBJECT:C1216($4)
	$voUserDefinition:=$4
Else 
	$voUserDefinition:=USR_GetUserDefinition
End if 

// ********************************************************************************************  //
// ** TYPE AND INITIALIZE LOCAL VARIABLES *****************************************************  //
// ********************************************************************************************  //

C_OBJECT:C1216($voPermissions)
C_OBJECT:C1216($voRoute)
C_LONGINT:C283($viPermissionUserHas; $viPermissionUserNeeds)
C_TEXT:C284($vtAllowedUserType; $vtAllowedUserGroup)
C_TEXT:C284($vtUserGroup)

// ********************************************************************************************  //
// *** LOAD USER PERMISSIONS ******************************************************************  //
// ********************************************************************************************  //

$viPermissionUserHas:=0
$viPermissionUserNeeds:=1

// ********************************************************************************************  //
// *** DETERMINE WHAT ACTION IS BEING TAKEN ***************************************************  //
// ********************************************************************************************  //

If ($vtAction="ViewPage")
	
	$voPermissions:=$voUserDefinition.permissions.pages
	
	$voRoute:=WC_FindMatchingRoute($vtResourceNameOrURLFrag)
	
	$vbUserIsAllowedToTakeAction:=True:C214
	
	If ($voRoute.accessLimits.userTypes.length>0)
		
		$vbUserIsAllowedToTakeAction:=False:C215
		
		If ($voRoute.accessLimits.userTypes.indexOf($voUserDefinition.type)>-1)
			
			$vbUserIsAllowedToTakeAction:=True:C214
			
		End if 
		
	End if 
	
	If ($voRoute.accessLimits.userGroups.length>0)
		
		$vbUserIsAllowedToTakeAction:=False:C215
		
		For each ($vtUserGroup; $voUserDefinition.permissionGroups)
			
			If ($voRoute.accessLimits.userGroups.indexOf($vtUserGroup)>-1)
				
				$vbUserIsAllowedToTakeAction:=True:C214
				
			End if 
			
		End for each 
		
	End if 
	
Else 
	
	$voPermissions:=$voUserDefinition.permissions.resources
	
	If ((WCR_IsResource($vtResourceNameOrURLFrag)) & (OB Is defined:C1231($voPermissions; $vtResourceNameOrURLFrag)))
		
		// DETERMINE WHAT PERMISSION THE USER NEEDS TO COMPLETE ACTION
		
		If (($vtAction="ViewRecord") | ($vtAction="EditRecord"))
			
			$viPermissionUserNeeds:=2
			
			If (USR_DoesRecordBelongTo($vtResourceNameOrURLFrag; $vtUniqueID; $voUserDefinition))
				
				$viPermissionUserNeeds:=1
				
			End if 
			
			$vtAction:=$vtAction+"s"
			
		End if 
		
		// DETERMINE WHAT PERMISSION THE USER HAS
		
		$voPermissions:=$voPermissions[$vtResourceNameOrURLFrag]
		
		If (OB Is defined:C1231($voPermissions; $vtAction))
			
			$viPermissionUserHas:=$voPermissions[$vtAction]
			
		End if 
		
		// CHECK IF USER HAS PERMISSION THAT IS REQUIRED
		
		If ($viPermissionUserHas>=$viPermissionUserNeeds)
			
			$vbUserIsAllowedToTakeAction:=True:C214
			
		End if 
		
	End if 
	
End if 

// USE OVERRIDE FOR USERS IN GROUP "SystemAdmins" 

If ($voUserDefinition.permissionGroups.indexOf("SystemAdmins")>-1)
	
	$vbUserIsAllowedToTakeAction:=True:C214
	
End if 

// ********************************************************************************************  //
// ** RETURN THE VALUE ************************************************************************  //
// ********************************************************************************************  //

$0:=$vbUserIsAllowedToTakeAction
