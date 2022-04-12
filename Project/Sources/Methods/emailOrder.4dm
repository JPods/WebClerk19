//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/25/11, 20:42:20
// ----------------------------------------------------
// Method: emailOrder
// Description
// Cmosso only, example of TallyMasters 
//
// Parameters
// ----------------------------------------------------


vtEmailSenderOverRide:="Admin"
vHere:=2  //fake that we are in an imput layout
vi3:=Num:C11(variable3)  //in range of choices
If (vi3>0)  //in range of choices
	
	QUERY:C277([Order:3]; [Order:3]orderNum:2=vi3)
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[Order:3]mfrID:52)
	
	Case of 
		: (variable1="1")  //send to customer
			//    jMessageWindow("case 1 ")
			variable4:=[Customer:2]email:81
			QUERY:C277([UserReport:46]; [UserReport:46]name:2="OrderOneEmail"; *)
			QUERY:C277([UserReport:46];  & ; [UserReport:46]why:9="WebClerk"; *)
			QUERY:C277([UserReport:46])
			Prnt_ReportOpts
			
			vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
			vtMyDate:=String:C10(Current date:C33; 4)
			vtComment:=vtMyDate+": "+vtMyTime+"; "
			If ([Order:3]emailVerified:127=!2001-01-01!)
				//vtComment:=vtComment+"email not successful to customer."+"\r"
				vtComment:=vtComment+"email to: "+[Customer:2]email:81+" not successful."+"\r"
				
				[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
				//[Order]Status:=    //no status change
			Else 
				vtMyMessage:="Customer Copy sent to: "+[Customer:2]email:81+" by Remote User "
				vtMyName:=variable2
				vtComment:=vtComment+vtMyMessage+vtMyName+"\r"
				[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
				// [Order]Status:=    //no status change
			End if 
			SAVE RECORD:C53([Order:3])
			
		: (variable1="2")  //email sent to Vendor, Rep and Autosender
			// jMessageWindow("case 2 ")
			variable4:=[Vendor:38]email:59
			QUERY:C277([UserReport:46]; [UserReport:46]name:2="OrderOneEmailVendor"; *)
			QUERY:C277([UserReport:46];  & ; [UserReport:46]why:9="WebClerk"; *)
			QUERY:C277([UserReport:46])
			
			QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Order:3]salesNameID:10)
			variable9:=[Employee:19]email:16
			If (Position:C15(Char:C90(64); variable9)>2)
				ARRAY TEXT:C222(atEmailCC; 4)
				atEmailCC{1}:=variable9
				atEmailCC{2}:=vtEmailSender
				atEmailCC{3}:="autosender@cmashowroom.com"
				atEmailCC{4}:="bill@jitcorp.com"
			Else 
				ARRAY TEXT:C222(atEmailCC; 1)
				atEmailCC{1}:=vtEmailSender
			End if 
			Prnt_ReportOpts  //send the email 
			
			vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
			vtMyDate:=String:C10(Current date:C33; 4)
			vtComment:=vtMyDate+": "+vtMyTime+"; "
			// If ([Order]EmailVerified=!01/01/01!)
			//  vtComment:=vtComment+"Vendor email to: "+variable4+" or "+variable9+ " not successful"+"\r"
			
			// [Order]CommentProcess:=Insert string([Order]CommentProcess;vtComment;0)
			// [Order]Status:="Failed Vendor email"
			// Else 
			vtMyMessage:="Vendor Copy sent to: "+[Vendor:38]email:59+" and "+variable9+"\r"
			vtComment:=vtComment+vtMyMessage
			[Order:3]commentProcess:12:=vtComment+[Order:3]commentProcess:12
			// [Order]CommentProcess:=Insert string([Order]CommentProcess;vtComment;0)
			[Order:3]status:59:="Sent email"
			
			SAVE RECORD:C53([Order:3])
			
		: (variable1="3")  //only to Rep
			//    jMessageWindow("case 1 ")
			QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Order:3]salesNameID:10)
			variable4:=[Employee:19]email:16
			QUERY:C277([UserReport:46]; [UserReport:46]name:2="OrderOneEmail"; *)
			QUERY:C277([UserReport:46];  & ; [UserReport:46]why:9="WebClerk"; *)
			QUERY:C277([UserReport:46])
			
			QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Order:3]salesNameID:10)
			variable9:=[Employee:19]email:16
			If (Position:C15(Char:C90(64); variable9)>2)
				ARRAY TEXT:C222(atEmailCC; 2)
				atEmailCC{1}:=variable9
				atEmailCC{2}:=vtEmailSender
			Else 
				ARRAY TEXT:C222(atEmailCC; 1)
				atEmailCC{1}:=vtEmailSender
			End if 
			
			Prnt_ReportOpts  //send the email 
			
			vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
			vtMyDate:=String:C10(Current date:C33; 4)
			vtComment:=vtMyDate+": "+vtMyTime+"; "
			If ([Order:3]emailVerified:127=!2001-01-01!)
				vtComment:=vtComment+"email to "+variable4+" not successful"+"\r"
				[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
				//[Order]Status:=    //no status change
			Else 
				vtMyMessage:="Copy sent to Rep: "+variable4
				vtComment:=vtComment+vtMyMessage+"\r"
				[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
				//[Order]Status:=    //no status change
			End if 
			SAVE RECORD:C53([Order:3])
			
			
	End case 
End if 