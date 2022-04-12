//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-29T00:00:00, 23:21:47
// ----------------------------------------------------
// Method: EmailVendorOrders
// Description
// Modified: 12/29/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


ARRAY TEXT:C222(atEmailAttachments; 0)
ARRAY TEXT:C222(atEmailBCC; 0)
ARRAY TEXT:C222(atEmailCC; 0)
QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
vtEmailSubject:=[Vendor:38]company:2+" Order# "+String:C10([Order:3]orderNum:2)+" | Bill to "+[Customer:2]company:2
QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[Order:3]mfrID:52)
vtEmailReceiver:=[Vendor:38]email:59
variable4:=vtEmailReceiver
// could be a duplication
// APPEND TO ARRAY(atEmailCC;vtEmailReceiver)  
QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Order:3]salesNameID:10)
variable9:=[Employee:19]email:16
APPEND TO ARRAY:C911(atEmailCC; variable9)
APPEND TO ARRAY:C911(atEmailBCC; Storage:C1525.default.email)  // blind copy the admin default
//  APPEND TO ARRAY(atEmailBCC;vtEmailSender)  //  double sending clipped
// jMessageWindow ("vtEmailReceiver  "+vtEmailReceiver)
ConsoleMessage("vtEmailReceiver  "+vtEmailReceiver; 1)
// Alert (vtEmailSender)
// Alert("UR vtEmailSender: "+vtEmailSender+"\r"+" vtEmailServer: "+vtEmailServer+"\r"+" vtEmailUserName: "+vtEmailUserName+"\r"+" vtEmailPassword: "+vtEmailPassword)

