//%attributes = {}
//Script Email ShippingNoticeOne 20130726

//Email Testing
//variable1:="j.medlen@functionaldevices.com"

viPosition:=Position:C15(Char:C90(64); variable1)
If ((variable1#"") & (viPosition#0))
	QUERY:C277([UserReport:46]; [UserReport:46]name:2="Email Shipping Notice"; *)
	QUERY:C277([UserReport:46])
	//Alert("variable1 = "+variable1)
	//Prnt_ReportOpts 
	SMTP_Email
	UNLOAD RECORD:C212([UserReport:46])
	vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
	vtMyDate:=String:C10(Current date:C33; 4)
	vtMyName:=Current user:C182
	vtMyText:=" Sent Advanced Shipping Notice Email to "+variable1+" Status: "+vtEmailStatusMessage+"\r"
	vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyName+" - "+vtMyText
	vtLog:=vtComment+"\r"+vtBody+"\r"+"\r"+"Status: "+vtEmailStatusMessage+"\r"
	If (vtEmailStatusMessage="sent")
		vtGroup:="Email"
	Else 
		vtGroup:="Email Error"
	End if 
	ELogRecord:=ELog_NewRecord([Invoice:26]invoiceNum:2; vtGroup; vtLog)
	[Invoice:26]commentProcess:73:=vtComment+[Invoice:26]commentProcess:73
	If ((vtEmailStatusMessage="sent") & ([Invoice:26]profile5:84#"@ASN@"))
		[Invoice:26]profile5:84:=[Invoice:26]profile5:84+"ASN "
	End if 
	SAVE RECORD:C53([Invoice:26])
	If (ELogRecord>0)  // link invoice.
		// ### bj ### 20181115_1412
		// test where this is used
		GOTO RECORD:C242([EventLog:75]; ELogRecord)
		[EventLog:75]tableNumTarget:53:=26
		[EventLog:75]targetRecordNum:52:=Record number:C243([Invoice:26])
		[EventLog:75]targetComments:28:=variable1
		[EventLog:75]status:48:=vtEmailStatusMessage
		[EventLog:75]customerID:38:=[Invoice:26]customerID:3
		[EventLog:75]company:46:=[Invoice:26]bill2Company:69
		[EventLog:75]dateComplete:45:=Current date:C33
		[EventLog:75]addressIPRemote:18:=vWCRemoteAddress
		SAVE RECORD:C53([EventLog:75])
		UNLOAD RECORD:C212([EventLog:75])
	End if 
End if 
