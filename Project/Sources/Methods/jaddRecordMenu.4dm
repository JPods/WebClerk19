//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/08/07, 09:10:10
// ----------------------------------------------------
// Method: jaddRecordMenu
// Description
// ###wdj###  massive change to flow, old procedure, If (false)
//
// Parameters
// ----------------------------------------------------
// ### bj ### 20190117_2055 sometimes curTableNum was zero
If ((curTableNum=0) & (Not:C34(Is nil pointer:C315(ptCurTable))))
	curTableNum:=Table:C252(ptCurTable)
Else 
	curTableNum:=2  // with no information, switch to a customer record
End if 
C_BOOLEAN:C305($DoAddInv; StopAddLoop; $DoLoop; $newRecPrcs)
$doAdd:=False:C215
Case of 
	: (vHere=0)
		File_Select("Select the file for which you wish to add a record.")
		// ### bj ### 20200129_1240 put in the button, do not repeat on line 35
		If (myOK=-3)  // already created in the button of the layout
			$doAdd:=False:C215
		End if 
		myOK:=0
	: (vHere=1)
		$doAdd:=True:C214
	: (vHere>1)
		If (<>vbKeepOpen)
			jSaveRecord
		Else 
			jAcceptButton
		End if 
		$doAdd:=True:C214
End case 
If ($doAdd)
	Process_AddRecord(Table name:C256(curTableNum))
End if 