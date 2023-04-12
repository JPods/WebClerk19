//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($1; $noSave; $confirm)
//C_TEXT($theString)
//If (jCanAccpConfirm)
//TRACE

//Console_Log ("TEST: jCancelButton")
$confirm:=True:C214
If (Count parameters:C259=1)  //false for no confirm, true for confirm
	$confirm:=$1
End if 
$noSave:=Not:C34(jConfirmSave(False:C215; $confirm))
If ($noSave)
	If (Record number:C243(ptCurTable->)>-1)
		<>aLastRecNum{Table:C252(ptCurTable)}:=Record number:C243(ptCurTable->)
	End if 
	// ### bj ### 20211030_1836
	// AddToProcessObject
	//If (Size of array(aSrPendRec)>0)
	//End if 
	//jCancelClrRays //Cannot be here or al will crash
	If (vHere>1)
		CounterRecover(ptCurTable)
	End if 
	CANCEL:C270
	If (vHere<=2)  //0 cancels to Splash, 1 adds a new order, 3 for between files (cust 2 ords)
		jNavResetSplash
	End if 
	//Console_Log ("TEST: jNavResetSplash")
	myCycle:=0  //Must reset to 0 is Cancel button is selected.  6 allows the flow to continue  
	myOK:=0
	booDuringDo:=False:C215  //be careful of this, side buttons
	viNavAccept:=0  //layout canceled
	blockServiceRelate:=False:C215
	vModLoadTags:=False:C215
	CLEAR VARIABLE:C89(imageQA_p)
	CLEAR VARIABLE:C89(imageDoc_p)
	CLEAR VARIABLE:C89(pathDoc_p)
	CLEAR VARIABLE:C89(pathQA_p)
	
	TransactionValidate(False:C215)
	
End if 