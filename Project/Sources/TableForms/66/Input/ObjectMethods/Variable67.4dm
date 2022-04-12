C_TEXT:C284($vtext)
C_POINTER:C301($ptChangedField)
[WorkOrder:66]ActionByLast:65:=[WorkOrder:66]ActionBy:8
$ptChangedField:=(->[WorkOrder:66]ActionBy:8)
$vtext:=$ptChangedField->
jPopUpArray(Self:C308; $ptChangedField)
If ($ptChangedField->#$vtext)
	// zzzqqq jDateTimeStamp(->[WorkOrder:66]Comment:17; "Change "+Field name:C257($ptChangedField)+" from "+$vtext+" to "+$ptChangedField->)
End if 