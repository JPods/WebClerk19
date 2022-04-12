//%attributes = {"publishedWeb":true}
//jOECAbort
Case of 
	: (Error=2000)
	: (Error=-9999)
		jAlertMessage(-9999)
		Thermo_Close
		ABORT:C156
	: (Error=-9998)
		jAlertMessage(-9998)
		Thermo_Close
		ABORT:C156
	Else 
		jAlertMessage(0)
		booOK:=False:C215
		Thermo_Close
		ABORT:C156
End case 