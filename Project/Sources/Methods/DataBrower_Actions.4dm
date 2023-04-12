//%attributes = {}

Case of 
	: (FORM Event:C1606.objectName="aphone_tool")
		ALERT:C41("aphone")
	: (FORM Event:C1606.objectName="aphoneCell_tool")
		ALERT:C41("aphoneCell")
		
		
	: (FORM Event:C1606.objectName="email_tool")
		ALERT:C41("email")
		
		
	: (FORM Event:C1606.objectName="address1_tool")
		ALERT:C41("address1")
		
		
End case 