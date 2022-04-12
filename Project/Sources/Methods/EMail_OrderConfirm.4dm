//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-21T00:00:00, 00:23:25
// ----------------------------------------------------
// Method: EMail_OrderConfirm
// Description
// Modified: 12/21/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


vtEmailPath:=""
vtEmailAttachment:=""
ARRAY TEXT:C222(atEmailAttachments; 0)
ARRAY TEXT:C222(atEmailBCC; 0)
ARRAY TEXT:C222(atEmailCC; 0)

// Alert("Script to execute with each record "+variable1)
// variable4 set here to override vtEmailReceiver in the UserReport that gets called
// Sends a printable order depending on the value of Variable1, see comment by each case
vHere:=2  // fake that we are in an imput layout

vi3:=Num:C11(variable3)  // is there a valid Order Number
If (vi3>0)
	// Get the Order, etc....
	QUERY:C277([Order:3]; [Order:3]orderNum:2=vi3)
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[Order:3]mfrID:52)
	
	vtEmailSubject:="Sales Order for "+[Customer:2]company:2+" | Number  "+String:C10([Order:3]orderNum:2)+" | Vendor "+[Vendor:38]company:2
	
	Case of 
		: (variable1="1")  // Called in OrdersOne.html  popup "CustBill" email
			// sends to the customer; a copy to the [Employee] and blind copy Storage.default.email
			vtEmailReceiver:=[Customer:2]email:81
			variable4:=vtEmailReceiver
			// copy the employee
			QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Order:3]salesNameID:10)
			variable9:=[Employee:19]email:16
			
			If (Position:C15(Char:C90(64); variable9)>2)
				APPEND TO ARRAY:C911(atEmailCC; variable9)  // double send to the default email if no employee is found
			End if 
			// blind copy the Admin
			If (Position:C15(Char:C90(64); vtEmailSender)>2)
				APPEND TO ARRAY:C911(atEmailBCC; vtEmailSender)  // blind copy the admin default
			End if 
			
			
			If (False:C215)
				C_TEXT:C284(text2Send)
				text2Send:=WC_PageLoad("OrdersOne.html")
				text2send:=TagsToText(text2Send)
				// execute an SMPT send behavior
				QUERY:C277([UserReport:46]; [UserReport:46]name:2="emailPrintableOrder")
				SMTP_EmailBuild(Table:C252([UserReport:46]tableNum:3))
			Else 
				QUERY:C277([UserReport:46]; [UserReport:46]name:2="emailPrintableOrder")
				Prnt_ReportOpts
			End if 
			
			
			
			vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
			vtMyDate:=String:C10(Current date:C33; 4)
			vtComment:=vtMyDate+": "+vtMyTime+"; "
			If ([Order:3]emailVerified:127=!2001-01-01!)
				vtComment:=vtComment+"email from: "+vtEmailSender+" to: "+[Customer:2]email:81+" not successful."+"\r"
				
				[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
				// [Order]Status:=    // no status change
			Else 
				vtMyMessage:="Customer Copy sent to: "+[Customer:2]email:81+" by Remote user: "
				vtMyName:=variable2
				vtComment:=vtComment+vtMyMessage+vtMyName+"\r"
				[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
				//  [Order]Status:=    // no status change
				
			End if 
			SAVE RECORD:C53([Order:3])
			
		: (variable1="2")  // // OrdersOne.html  
			// Send to employee
			QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Order:3]salesNameID:10)
			vtEmailReceiver:=[Employee:19]email:16  // used in the UserReport to set vtEmailReceiver
			variable4:=vtEmailReceiver
			// blind copy the Admin
			If (Position:C15(Char:C90(64); vtEmailSender)>2)
				APPEND TO ARRAY:C911(atEmailBCC; vtEmailSender)  // blind copy the admin default
			End if 
			
			If (False:C215)
				C_TEXT:C284(text2Send)
				text2Send:=WC_PageLoad("OrdersOne.html")
				text2send:=TagsToText(text2Send)
			Else 
				QUERY:C277([UserReport:46]; [UserReport:46]name:2="emailPrintableOrder")
				Prnt_ReportOpts  // send the email  
			End if 
			
			
			
			
			vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
			vtMyDate:=String:C10(Current date:C33; 4)
			vtComment:=vtMyDate+": "+vtMyTime+"; "
			If ([Order:3]emailVerified:127=!2001-01-01!)
				vtComment:=vtComment+"email to "+variable4+" not successful"+"\r"
				[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
				// [Order]Status:=    // no status change
			Else 
				vtMyMessage:="Customer Copy sent to: "+variable4
				vtComment:=vtComment+vtMyMessage+"\r"
				[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
				// [Order]Status:=    // no status change
				
			End if 
			SAVE RECORD:C53([Order:3])
			
			
			// Alert("Finish  "+variable1)
			
			
		: (variable1="3")  // Called in OrdersOne.html  popup "Vendor and Rep" email
			//  sends to the Vendor email with a copy to the [Employee] and  Storage.default.email and blind copy to [Employee] nameID=Email
			QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[Order:3]mfrID:52)
			vtEmailReceiver:=[Vendor:38]email:59
			variable4:=vtEmailReceiver
			
			QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Order:3]salesNameID:10)
			variable9:=[Employee:19]email:16  // used in the UserReport to set vtEmailReceiver
			
			If (Position:C15(Char:C90(64); variable9)>2)
				APPEND TO ARRAY:C911(atEmailCC; variable9)  // double send to the default email if no employee is found
			End if 
			APPEND TO ARRAY:C911(atEmailBCC; vtEmailSender)  // double send to the default email if no employee is found
			
			
			
			If (False:C215)
				C_TEXT:C284(text2Send)
				text2Send:=WC_PageLoad("OrdersOneVendor.html")
				text2send:=TagsToText(text2Send)
			Else 
				QUERY:C277([UserReport:46]; [UserReport:46]name:2="emailPrintableOrderVendor")
				Prnt_ReportOpts  // send the email   
			End if 
			
			
			
			vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
			vtMyDate:=String:C10(Current date:C33; 4)
			vtComment:=vtMyDate+": "+vtMyTime+"; "
			//  If ([Order]EmailVerified=!01/01/01!)
			//   vtComment:=vtComment+"Vendor email to: "+variable4+" or "+variable9+ " not successful"+"\r"
			
			//  [Order]CommentProcess:=Insert string([Order]CommentProcess;vtComment;0)
			//  [Order]Status:="Failed Vendor email"
			//  Else 
			vtMyMessage:="Vendor Copy sent to: "+[Vendor:38]email:59+" and "+variable9+"\r"
			vtComment:=vtComment+vtMyMessage
			[Order:3]commentProcess:12:=vtComment+[Order:3]commentProcess:12
			//  [Order]CommentProcess:=Insert string([Order]CommentProcess;vtComment;0)
			//  [Order]Status:="Sent email"
			[Order:3]status:59:="Sent "+vtMyDate
			
			
			SAVE RECORD:C53([Order:3])
			
			// Alert("Finish  "+variable1)
			
	End case 
End if 

jMessageWindow("vtEmailReceiver  "+vtEmailReceiver)

// Alert("Before: "+[EventLog]OperatingSystem)
// ### bj ### 20210912_1208  should be by obEventLog.id
//QUERY([EventLog]; [EventLog]id=vleventID)
// Alert([EventLog]OperatingSystem)lServer: "+vtEmailServer+"\r"+" vtEmailUserName: "+vtEmailUserName+"\r"+" vtEmailPassword: "+vtEmailPassword)


