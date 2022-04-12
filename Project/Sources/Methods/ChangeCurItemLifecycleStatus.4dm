//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/04/19, 11:55:51
// ----------------------------------------------------
// Method: SetProductLifecycleStatus
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ********************************************************* //
// ** TYPE AND INITIALIZE PARAMETERS *********************** //
// ********************************************************* //

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_TEXT:C284($1; $vtNewStatus)
$vtNewStatus:=$1

// $vtOldStatus IS THE CURRENT STATUS OF THE ITEM
C_TEXT:C284($vtOldStatus)
$vtOldStatus:=[Item:4]lifeCycleStatus:132

// ********************************************************* //
// ** CHECK THAT THE NEW STATUS IS VALID, THEN UPDATE THE ** //
// ** THE STATUS FIELD AND THE DATE FIELDS ******************//
// ********************************************************* //

Case of 
		
	: ($vtNewStatus="PreRelease")
		
		[Item:4]lifeCycleStatus:132:=$vtNewStatus
		[Item:4]dateReleased:130:=!00-00-00!
		[Item:4]dateRetired:122:=!00-00-00!
		[Item:4]dateArchived:131:=!00-00-00!
		[Item:4]retired:64:=False:C215
		
	: ($vtNewStatus="Active")
		
		[Item:4]lifeCycleStatus:132:=$vtNewStatus
		[Item:4]dateReleased:130:=Current date:C33
		[Item:4]dateRetired:122:=!00-00-00!
		[Item:4]dateArchived:131:=!00-00-00!
		[Item:4]retired:64:=False:C215
		
	: ($vtNewStatus="Retired")
		
		[Item:4]lifeCycleStatus:132:=$vtNewStatus
		[Item:4]dateRetired:122:=Current date:C33
		[Item:4]dateArchived:131:=!00-00-00!
		[Item:4]retired:64:=True:C214
		
	: ($vtNewStatus="Archived")
		
		[Item:4]lifeCycleStatus:132:=$vtNewStatus
		[Item:4]dateArchived:131:=Current date:C33
		
End case 