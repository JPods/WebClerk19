If ([ItemSerial:47]DateShipped:13=!00-00-00!)
	[ItemSerial:47]DateShipped:13:=Current date:C33
End if 
[ItemSerial:47]DateWarrantyEnd:21:=[ItemSerial:47]WarrantyDays:20+[ItemSerial:47]DateShipped:13