//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305(booOK)
Case of 
	: (Error=-9991)
		booOK:=False:C215
	: (Error=-9992)
		booOK:=False:C215
	: (Error=-9999)
		booOK:=False:C215
	: (Error=-9998)
	Else 
		booOK:=True:C214
		ALERT:C41("Error "+String:C10(error))
End case   //
jAlertMessage(Error)