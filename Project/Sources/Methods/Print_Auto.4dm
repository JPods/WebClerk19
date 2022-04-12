//%attributes = {"publishedWeb":true}
//Method: Print_Auto
C_POINTER:C301($1)
Case of 
	: ($1=(->[Order:3]))
		If (<>aPrimeRpts{3}>0)
			GOTO RECORD:C242([UserReport:46]; <>aPrimeRpts{Table:C252(ptCurTable)})
			C_LONGINT:C283($result)
			LOAD RECORD:C52([Order:3])
			SRE_Print(0)
		End if 
	Else 
		//    
End case 