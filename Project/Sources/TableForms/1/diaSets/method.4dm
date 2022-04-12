// ### jwm ### 20181214_1543 check this
Case of 
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event code:C388=On Load:K2:1)
		aText4:=0
		vtSetName:=""
		//vtWhy:=""
		//b21:=0
		//b22:=1
		//b24:=1
		OBJECT SET ENABLED:C1123(bSaveServer; (vHere>0))
		OBJECT SET ENABLED:C1123(bAccept; (vHere>0))  // save local
		
		// definition and filling the arealist is the On Load there
		
	: (Outside call:C328)
		Prs_OutsideCall
End case 