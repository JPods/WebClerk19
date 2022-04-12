If (IsUserInPermissionGroup("ItemsManagers"))  // ANYONE IN THE ItemsManagers GROUP OR THE SystemAdmins OVERRIDE GROUP
	
	C_TEXT:C284($vtOptions)
	C_LONGINT:C283($viSelectedChoiceIndex)
	ARRAY TEXT:C222($atChoices; 0)
	C_TEXT:C284($vtChoicesSemiColonDel)
	
	APPEND TO ARRAY:C911($atChoices; "PreRelease")
	APPEND TO ARRAY:C911($atChoices; "Active")
	APPEND TO ARRAY:C911($atChoices; "Retired")
	APPEND TO ARRAY:C911($atChoices; "Archived")
	
	$vtChoicesSemiColonDel:=""
	For (vi1; 1; Size of array:C274($atChoices))
		$vtChoicesSemiColonDel:=$vtChoicesSemiColonDel+$atChoices{vi1}+";"
	End for 
	
	$viSelectedChoiceIndex:=Pop up menu:C542($vtChoicesSemiColonDel)
	
	If ($viSelectedChoiceIndex>0)
		
		CONFIRM:C162("Are you sure you want to change this Items's LifecycleStatus from \""+[Item:4]lifeCycleStatus:132+"\" to \""+$atChoices{$viSelectedChoiceIndex}+"\"?\n\nNote: This will automatically update appropriate Dates."; "Yes"; "Cancel")
		
		If (OK=1)
			
			ChangeCurItemLifecycleStatus($atChoices{$viSelectedChoiceIndex})
			
		End if 
		
	End if 
	
Else 
	
	ALERT:C41("The Lifecycle Status of Items may only be changed by members of the ItemsManagers permission group.")
	
End if 