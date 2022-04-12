C_TEXT:C284($vtext)
C_POINTER:C301($ptChangedField)
$ptChangedField:=(->[WorkOrder:66]ActionByApproved:48)
$vtext:=$ptChangedField->
jPopUpArray(Self:C308; $ptChangedField)
If ($ptChangedField->#$vtext)
	// zzzqqq jDateTimeStamp(->[WorkOrder:66]Comment:17; "Change "+Field name:C257($ptChangedField)+" from "+$vtext+" to "+$ptChangedField->)
End if 