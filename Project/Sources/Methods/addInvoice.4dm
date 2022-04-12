//%attributes = {"publishedWeb":true}
//Procedure: addInvoice
jsetDefaultFile(->[Invoice:26])
StopAddLoop:=False:C215
Repeat 
	newInv:=False:C215
	//(myCycle#3) must be in the splash or only Invoice File 
	jCenterWindow(412; 252; 1)  //4;"Select Order")
	DIALOG:C40([Invoice:26]; "diaAddInvoice")
	CLOSE WINDOW:C154
	Ord_FillArray(0; 0)
	Case of 
		: (myOK=1)
			myCycle:=11
			REDUCE SELECTION:C351([Invoice:26]; 0)
			ADD RECORD:C56([Invoice:26])
		: (myOK=2)
			If (vHere>0)
				jCancelButton
			End if 
			booManyInv:=True:C214
			rptOrd2Inv
			booManyInv:=False:C215
		: (myOK=3)
			POSaddInv
		Else 
			jCancelButton
			StopAddLoop:=True:C214  //trap everything which is not a myOK=1
	End case 
Until (StopAddLoop)
myCycle:=0
myOK:=0