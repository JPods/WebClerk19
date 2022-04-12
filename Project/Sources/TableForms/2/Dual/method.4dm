C_OBJECT:C1216($obEvent)
C_LONGINT:C283($viEventCode)
$obEvent:=FORM Event:C1606
$viEventCode:=Form event code:C388
If ($viEventCode=On Load:K2:1)
	C_OBJECT:C1216(myEntitySelection)
	C_COLLECTION:C1488($filter_c)
	C_TEXT:C284(fields_t)
	fields_t:="action,actionBy,actionDate,actionTime,company,nameFirst,nameLast,phone,phoneCell,address1,zip,email,city,comment,id"
	$filter_c:=New collection:C1472
	$filter_c:=Split string:C1554(fields_t; ",")
	//$filter_c.push("nameFirst")
	cSelection:=ds:C1482.Customer.all().toCollection($filter_c)
End if 
