//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-29T00:00:00, 23:13:02
// ----------------------------------------------------
// Method: EmailEmployeeOrders
// Description
// Modified: 12/29/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// vtEmailSenderOverRide:="orders@cmashowroom.com"
// SMTP_SentBy(vtEmailSenderOverRide;"email")

QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
vtEmailSubject:="Order# "+String:C10([Order:3]orderNum:2)+" | Bill to"+[Customer:2]company:2
ARRAY TEXT:C222(atEmailAttachments; 0)
ARRAY TEXT:C222(atEmailBCC; 0)
ARRAY TEXT:C222(atEmailCC; 0)
Case of 
	: (variable1="1")
		// send to customer
		vtEmailReceiver:=[Customer:2]email:81
		variable4:=vtEmailReceiver
		// copy the employee
		QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Order:3]salesNameID:10)
		variable9:=[Employee:19]email:16
		APPEND TO ARRAY:C911(atEmailCC; variable9)  // double send to the default email if no employee is found
		// blind copy the Admin
		APPEND TO ARRAY:C911(atEmailBCC; Storage:C1525.default.email)  // blind copy the admin default
	: (variable1="2")
		// send to the employee
		QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Order:3]salesNameID:10)
		vtEmailReceiver:=[Employee:19]email:16
		variable4:=vtEmailReceiver
		// blind copy the Admin
		APPEND TO ARRAY:C911(atEmailBCC; Storage:C1525.default.email)  // blind copy the admin default
End case 

jMessageWindow("vtEmailReceiver  "+vtEmailReceiver)

//  Alert("UR vtEmailSender: "+vtEmailSender+"\r"+" vtEmailServer: "+vtEmailServer+"\r"+" vtEmailUserName: "+vtEmailUserName+"\r"+" vtEmailPassword: "+vtEmailPassword)
