C_TEXT:C284($vtext)
C_POINTER:C301($ptChangedField)
$ptChangedField:=(->[WorkOrder:66]Action:33)
$vtext:=$ptChangedField->
jPopUpArray(Self:C308; $ptChangedField)
If ($ptChangedField->#$vtext)
	// zzzqqq jDateTimeStamp(->[WorkOrder:66]Comment:17; "Change "+Field name:C257($ptChangedField)+" from "+$vtext+" to "+$ptChangedField->)
End if 

If (False:C215)
	
	C_TEXT:C284($vtext)
	$vtext:=[WorkOrder:66]ActionByApproved:48
	entryEntity.Action:=DE_PopUpArray(Self:C308)
	If ([WorkOrder:66]Action:33#$vtext)
		// zzzqqq jDateTimeStamp(->[WorkOrder:66]Comment:17; "Change Name Approved from "+$vtext+" to "+[WorkOrder:66]Action:33)
	End if 
End if 