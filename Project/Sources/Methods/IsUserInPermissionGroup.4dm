//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 08/15/19, 13:02:25
// ----------------------------------------------------
// Method: IsUserInPermissionGroup
//
// Description:
// 
// This method is sent the name of a permission group, and
// returns either true or false, depending if teh current
// user is a member of that group. If the current user is
// WebClerk, it loads the current RemoteUser.
// 

// ***************************************************************** //
// *** TYPE AND INITIALIZE PARAMETERS ****************************** //
// ***************************************************************** //

// RETURN VARIABLE
C_BOOLEAN:C305($0; $vbUserIsInGroup)
$0:=False:C215
$vbUserIsInGroup:=False:C215

// PARAMETER 1 IS THE NAME OF THE PERMISSION GROUP
C_TEXT:C284($1; $vtPermissionGroup)
$vtPermissionGroup:=$1

// PARAMETER 2 IS A BOOLEAN THAT SPECIFIES WHETHER OR NOT TO
// ALLOW THE SPECIAL "SystemAdmins" GROUP TO ACT AS AN OVERRIDE
C_BOOLEAN:C305($vbAllowAdminOverride)
$vbAllowAdminOverride:=True:C214
If (Count parameters:C259>=2)
	C_BOOLEAN:C305($2)
	$vbAllowAdminOverride:=$2
End if 

// $$vtPermissionGroupsUserIsIn IS A SPACE DELIMITED LIST
// OF GROUPS THAT THE USER IS A MEMBER OF
C_TEXT:C284($vtPermissionGroupsUserIsIn)
$vtPermissionGroupsUserIsIn:=""



// ***************************************************************** //
// *** LOAD THE CURRENT USER'S PERMISSION GROUPS ******************* //
// ***************************************************************** //

// IF THE USER IS NOT WEBCLERK, THEN LOAD THE CURRENT USER'S
// [RemoteUser] RECORD. IF THE CURRENT 4D USER IS WEBCLERK, THEN
// THERE SHOULD BE A [RemoteUser] RECORD ALREADY LOADED

If (Current user:C182#"WebClerk")
	QUERY:C277([RemoteUser:57]; [RemoteUser:57]customerid:10=Current user:C182)
End if 

// LOAD ALL PERMISSION GROUPS FROM THE [RemoteUser] RECORD

If (Records in selection:C76([RemoteUser:57])>0)
	$vtUserPermissionGroups:=[RemoteUser:57]groups:28
Else 
	$vtUserPermissionGroups:=""
End if 

If (Current user:C182#"WebClerk")
	UNLOAD RECORD:C212([RemoteUser:57])
End if 

// IF THE SPECIFIED GROUP IS IN THE GROUPS LOADED FROM THE
// [RemoteUser] RECORD

If ($vtUserPermissionGroups%$vtPermissionGroup)
	
	$vbUserIsInGroup:=True:C214
	
End if 

// IF THE SPECIAL "SystemAdmins" OVERRIDE GROUP  IS IN THE
// GROUPS LOADED FROM THE [RemoteUser] RECORD

If (($vbAllowAdminOverride=True:C214) & ($vtUserPermissionGroups%"SystemAdmins"))
	
	$vbUserIsInGroup:=True:C214
	
End if 

// RETURN THE RESULT

$0:=$vbUserIsInGroup
