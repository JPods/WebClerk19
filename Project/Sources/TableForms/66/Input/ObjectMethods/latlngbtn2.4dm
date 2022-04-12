C_TEXT:C284($input)

If ([WorkOrder:66]AddressEnd:85#"")
	C_OBJECT:C1216($voLatLng)
	$voLatLng:=WC_Returnlatlng(Replace string:C233([WorkOrder:66]AddressEnd:85; " "; "+"))
	[WorkOrder:66]lat:72:=$voLatLng.lat
	[WorkOrder:66]lng:73:=$voLatLng.lng
End if 