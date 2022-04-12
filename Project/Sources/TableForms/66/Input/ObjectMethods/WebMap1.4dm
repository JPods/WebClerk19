C_TEXT:C284($googleMaps)

If (([WorkOrder:66]Address1:50#"") & ([WorkOrder:66]City:52#""))
	$googleMaps:="http://maps.google.com?hl=en&q="+[WorkOrder:66]Address1:50+", "+[WorkOrder:66]City:52+", "+[WorkOrder:66]State:53+", "+[WorkOrder:66]Zip:54
	Web_LaunchURL($googleMaps)
End if 