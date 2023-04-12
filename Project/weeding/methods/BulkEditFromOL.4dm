//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 08/20/19, 08:46:31
// ----------------------------------------------------
// Method: BulkEditFromOL
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ************************************************************************* //
// *** TYPE AND INITIALIZE PARAMETERS ************************************** //
// ************************************************************************* //

// PARAMETER 1 IS A SPACE DELIMITED SET OF PERMISSION GROUPS WHO'S MEMBERS ARE
// ALLOWED TO USE THIS TOOL
ARRAY TEXT:C222($atPermissionGroups; 0)
C_TEXT:C284($1; $vtPermissionGroupsSpaceDel)
$vtPermissionGroupsSpaceDel:=$1
TextToArray($vtPermissionGroupsSpaceDel; ->$atPermissionGroups; " ")

// PARAMETER 2 IS THE NAME OF THE TABLE THAT WE ARE EDITING
C_TEXT:C284($2; $tableName; $vtTableNameSingular)
$tableName:=$2
If (Substring:C12("Customer"; Length:C16("Customer"))="s")
	$vtTableNameSingular:=Substring:C12($tableName; 1; Length:C16($tableName)-1)
Else 
	$vtTableNameSingular:=$tableName
End if 

C_LONGINT:C283($viTableNum)
$viTableNum:=STR_GetTableNumber($tableName)

// PARAMETER 3 IS THE NAME OF THE FIELD THAT WE ARE EDITING
C_TEXT:C284($3; $vtFieldName)
$vtFieldName:=$3

C_LONGINT:C283($viFieldNum)
$viFieldNum:=STR_GetFieldNumber($tableName; $vtFieldName)

// WE NEED A FLAG TO TRACK IF WE ARE LIMITING VALUES TO A CHOICE-LIST
C_BOOLEAN:C305($vbLimitToChoiceList)
$vbLimitToChoiceList:=False:C215

// PARAMETER 4 IS OPTIONAL. IT IS A POINTER TO AN ARRAY OF CHOICES
If (Count parameters:C259>=4)
	
	$vbLimitToChoiceList:=True:C214
	
	C_POINTER:C301($4; $vpatChoices)
	$vpatChoices:=$4
	
	C_TEXT:C284($vtChoicesColonDel)
	$vtChoicesSemiColonDel:=""
	For (vi1; 1; Size of array:C274($vpatChoices->))
		$vtChoicesSemiColonDel:=$vtChoicesSemiColonDel+$vpatChoices->{vi1}+";"
	End for 
	
	C_LONGINT:C283($viSelectedChoiceIndex)
	
End if 

// WE NEED VARIABLES TO HOLD THE SELECTED CHOICE

C_TEXT:C284($vtNewValue)

// POINTER TO TABLE AND FIELD
C_POINTER:C301($vpTable; $vpField)

// UTILITY VARIABLES

C_LONGINT:C283($viCounter; $viCountRecords)
$viCounter:=1
$viCountRecords:=0

C_BOOLEAN:C305($vbUserHasPermission)
$vbUserHasPermission:=False:C215

// ************************************************************************* //
// *** CHECK TO SEE IF THE USER HAS PERMISSION ***************************** //
// ************************************************************************* //

// LOOP THROUGH THE PERMISSION GROUPS WHICH ARE ALLOWED TO USE THIS TOOL AND
// CHECK TO SEE IF THE USER IS IN ANY OF THEM

For ($viCounter; 1; Size of array:C274($atPermissionGroups))
	
	If (IsUserInPermissionGroup($atPermissionGroups{$viCounter}))
		
		$vbUserHasPermission:=True:C214
		
	End if 
	
End for 

// ************************************************************************* //
// *** RUN VALIDATION CHECKS *********************************************** //
// ************************************************************************* //

If ($vbUserHasPermission=False:C215)
	
	ALERT:C41("Sorry, you don't have permission to use this bulk edit tool. If you think this is a mistake, please contact the CIS dept.")
	
Else 
	
	// MAKE SURE THE SPECIFIED FIELD IS A VALID
	
	If (($viTableNum<1) | ($viFieldNum<1))
		
		ALERT:C41("Sorry, the specified field (["+$tableName+"]"+$vtFieldName+") isn't valid.")
		
	Else 
		
		// BUILD POINTERS TO THE TABLE AND FIELD
		
		$vpTable:=Table:C252($viTableNum)
		$vpField:=Field:C253($viTableNum; $viFieldNum)
		
		// ************************************************************************* //
		// *** GATHER INPUT FROM USER ********************************************** //
		// ************************************************************************* //
		
		If ($vbLimitToChoiceList)
			
			// SHOW USER BEGIN/CANCEL PROMPT
			
			CONFIRM:C162("Bulk Edit: ["+$vtTableNameSingular+"]"+$vtFieldName; "Select New "+$vtFieldName; "Cancel")
			
			If (OK=1)
				
				// SHOW THE CHOICES POPUP MENU
				
				$viSelectedChoiceIndex:=Pop up menu:C542($vtChoicesSemiColonDel)
				
				If ($viSelectedChoiceIndex>0)
					
					// GRAB THE NEW RANK BY WHAT WAS SELECTED
					
					$vtNewValue:=$vpatChoices->{$viSelectedChoiceIndex}
					
				Else 
					
					OK:=0
					
				End if 
				
			End if 
			
		Else 
			
			$vtNewValue:=Request:C163("Bulk Edit: ["+$vtTableNameSingular+"]"+$vtFieldName+". Enter New Value:"; ""; "Confirm")
			
		End if 
		
		// ************************************************************************* //
		// *** BEGIN THE BULK EDIT ************************************************* //
		// ************************************************************************* //
		
		If (OK=1)
			
			// STORE THE FULL CURRENT SET OF RECORDS, THEN SWITCH TO SET OF WHAT THE
			// USER HAS ACTUALLY SELECTED/HIGHLIGHED
			
			CREATE SET:C116($vpTable->; "Current")
			USE SET:C118("UserSet")
			
			// CACHE THE COUNT RECORDS
			
			$viCountRecords:=Records in selection:C76($vpTable->)
			
			// SHOW FINAL CONFIRMATION
			
			CONFIRM:C162("Please Confirm: Update "+$vtFieldName+" to \""+$vtNewValue+"\" for the highlighted/selected ("+String:C10($viCountRecords)+") "+Lowercase:C14($tableName)+"."; "Update"; "Cancel")
			
			// IF CONFIRMED, UPDATE ALL SELECTED RECORDS
			
			If (OK=1)
				
				// TURN ON PROGRESS BAR
				
				$viProgressID:=Progress New
				Progress SET TITLE($viProgressID; "Bulk Update: "+$vtTableNameSingular+" "+$vtFieldName; 0; ("Initializing..."))
				Progress SET BUTTON ENABLED($viProgressID; True:C214)
				
				// LOAD THE FIRST RECORD
				
				FIRST RECORD:C50($vpTable->)
				
				// lOOP THROUGH THE RECORDS
				
				For ($viCounter; 1; $viCountRecords)
					
					// UPDATE THE RANK (NO NEED TO CALL SAVE RECORD BECAUSE THAT HAPPENS IN WC_AddChangeLog)
					
					$vpField->:=$vtNewValue
					
					// ADD CHANGELOG
					
					ARRAY TEXT:C222(atSavedFieldNames; 0)
					ARRAY TEXT:C222(atSavedFieldValuesNew; 0)
					ARRAY TEXT:C222(atSavedFieldValuesOld; 0)
					If (($vpField->)#(Old:C35($vpField->)))
						APPEND TO ARRAY:C911(atSavedFieldNames; $vtFieldName)
						APPEND TO ARRAY:C911(atSavedFieldValuesNew; $vpField->)
						APPEND TO ARRAY:C911(atSavedFieldValuesOld; Old:C35($vpField->))
					End if 
					
					Case of 
						: ($tableName="Customer")
							WC_AddChangeLog($viTableNum; ->[Customer:2]comment:15; False:C215)
						: ($tableName="Contact")
							WC_AddChangeLog($viTableNum; ->[Contact:13]comment:29; False:C215)
					End case 
					
					// MOVE TO NEXT RECORD IF WE AREN'T ON THE LAST ONE ALREADY
					
					If ($viCounter<$viCountRecords)
						
						NEXT RECORD:C51($vpTable->)
						
					End if 
					
					// UPDATE PROGRES BAR
					
					Progress SET PROGRESS($viProgressID; ($viCounter/$viCountRecords); "Currently on record "+String:C10($viCounter)+" out of "+String:C10($viCountRecords)+".")
					
					// CANCEL LOOP IF THE CANCEL BUTTON IS CLICKED
					
					If (Progress Stopped($viProgressID))
						$viCounter:=$viMax
					End if 
					
				End for 
				
			End if 
			
			// RESTORE ORIGINAL SET AND THEN CLEAR IT
			
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			
			// CLOSE DOWN PROGRESS BAR
			
			Progress QUIT($viProgressID)
			
		End if 
		
	End if 
	
End if 
