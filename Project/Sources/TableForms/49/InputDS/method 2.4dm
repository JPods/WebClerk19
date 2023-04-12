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
			If (Is new record:C668([OrderLine:49]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[OrderLine:49])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		MarginCalc(->[OrderLine:49]extendedPrice:11; ->[OrderLine:49]extendedCost:13; ->pGrossMar; ->pGross)
		pDscntPrice:=DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP)
		vDiffDays1:=[OrderLine:49]dateShipOn:38-[OrderLine:49]dateRequired:23
		If (([OrderLine:49]dateShipped:39#!00-00-00!) & ([OrderLine:49]dateShipped:39#!1901-01-01!))
			//TRACE
			vDiffDays2:=[OrderLine:49]dateShipped:39-[OrderLine:49]dateShipOn:38
		Else 
			vDiffDays2:=0
		End if 
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 

