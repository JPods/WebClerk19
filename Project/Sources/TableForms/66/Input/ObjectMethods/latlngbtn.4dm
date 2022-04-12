C_TEXT:C284($googleMaps)


If (([WorkOrder:66]Address1:50#"") & ([WorkOrder:66]City:52#""))
	C_TEXT:C284($input)
	$input:=[WorkOrder:66]Address1:50+", "+[WorkOrder:66]City:52+", "+[WorkOrder:66]State:53+", "+[WorkOrder:66]Zip:54
	C_OBJECT:C1216($voLatLng)
	$voLatLng:=WC_Returnlatlng(Replace string:C233($input; " "; "+"))
	[WorkOrder:66]lat:72:=$voLatLng.lat
	[WorkOrder:66]lng:73:=$voLatLng.lng
End if 

