//%attributes = {"publishedWeb":true}
//TRACE
Case of 
	: (myCycle=6)  //Needed to SKIP CANCEL (cust 2 ords;  proposals 2 orders; side Nav buttons)  
		If ((vHere>1) & (<>tcMONEYCHAR#""))
			Exch_FillRays
		End if 
	: (myCycle=3)
		CANCEL:C270
	: (vHere>2)
		CANCEL:C270
		//UNLOAD RECORD(ptCurFile)  //February 11, 1998  should we do this????
	: (vHere<=2)
		CANCEL:C270
		
		//jCancelClrRays //0 cancels to Splash, 1 adds a new order, 3 for
		// between files (cust 2 ords)
		
		jNavResetSplash
		StopModLoop:=True:C214
	Else 
		jsplashCancel
End case 
CLEAR VARIABLE:C89(imageQA_p)
CLEAR VARIABLE:C89(imageDoc_p)
CLEAR VARIABLE:C89(pathDoc_p)
CLEAR VARIABLE:C89(pathQA_p)
myOK:=1
booDuringDo:=False:C215
myCycle:=0  //the save verse cancel  --  3 is used in iLo Orders