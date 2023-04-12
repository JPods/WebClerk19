C_TEXT:C284($googleMaps)

C_TEXT:C284($input)
$input:=[QQQCustomer:2]address1:4+", "+[QQQCustomer:2]city:6+", "+[QQQCustomer:2]state:7+", "+[QQQCustomer:2]zip:8+", "+[QQQCustomer:2]country:9
TRACE:C157
C_OBJECT:C1216($voLatLng)
$voLatLng:=WC_Returnlatlng(Replace string:C233($input; " "; "+"))
If ($voLatLng#Null:C1517)
	[QQQCustomer:2]lat:135:=$voLatLng.lat
	[QQQCustomer:2]lng:108:=$voLatLng.lng
End if 