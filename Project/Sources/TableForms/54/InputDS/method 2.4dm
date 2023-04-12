// ### jwm ### 20170105_1139 corrected labels for commission % / $
// ### jwm ### 20170531_1049 ProfileReal1 and 2 number format ###,###,##0.####;-###,###,##0.####
// ### jwm ### 20180215_0739 added drop down menus for SalesName and RepID

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)

If ($formEvent=On Close Box:K2:21)  // ### jwm ### 20181211_1052
	jCancelButton
End if 

$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([InvoiceLine:54]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[InvoiceLine:54])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			
			$doMore:=True:C214
	End case 
	If ($doMore)
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//If ($formEvent=On After Keystroke)
	MarginCalc(->[InvoiceLine:54]extendedPrice:11; ->[InvoiceLine:54]extendedCost:13; ->pGrossMar; ->pGross)
	pDscntPrice:=DiscountApply([InvoiceLine:54]unitPrice:9; [InvoiceLine:54]discount:10; <>tcDecimalUP)
	//End if 
	booAccept:=True:C214
End if 
