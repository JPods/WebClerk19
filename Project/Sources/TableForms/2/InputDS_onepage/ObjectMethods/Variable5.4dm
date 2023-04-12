C_TEXT:C284($googleMaps)

KeyModifierCurrent

If (OptKey=0)
	$googleMaps:="http://maps.google.com?hl=en&q="+entry_o.address1+", "+entry_o.city+", "+entry_o.state+", "+entry_o.zip+" "+entry_o.country
	Web_LaunchURL($googleMaps)
	
Else   //  (optKey=1)
	//   https://developers.google.com/maps/documentation/
	
	// https://developers.google.com/maps/documentation/directions/start  
	
	// auto complete for web api
	// https://www.youtube.com/watch?v=5oG2Q2GMOBE
	// set up the web page
	//  https://www.youtube.com/watch?v=_kHz9snOS-U
	
	
	//maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY
	// QUERY([SyncRelation];[SyncRelation]UniqueID=8)
	// QUERY([SyncRelation];[SyncRelation]Name="@maps@")
	
	C_TEXT:C284($vtInputAddress; $vtOutPutLatLng)
	$vtInputAddress:=process_o.entry_o.address1+", "+entry_o.city+", "+entry_o.state+", "+entry_o.zip+" "+entry_o.country
	C_OBJECT:C1216($voLatLng)
	$voLatLng:=WC_Returnlatlng(Replace string:C233($vtInputAddress; " "; "+"))
	If ($voLatLng#Null:C1517)
		entry_o.lat:=$voLatLng.lat
		entry_o.lat:=$voLatLng.lng
	End if 
End if 