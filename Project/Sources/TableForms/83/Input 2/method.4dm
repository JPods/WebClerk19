C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([Requisition:83]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[Requisition:83])
	//
	$doMore:=False:C215
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			If ($formEvent<0)
				If ((Table:C252(-$formEvent)=(->[Item:4])) & (Record number:C243([Item:4])>-1) & (([Requisition:83]description:39="z@") | ([Requisition:83]description:39="")))
					[Requisition:83]description:39:=[Item:4]description:7
				End if 
			End if 
			UNLOAD RECORD:C212([Item:4])
			DateTime_DTFrom([Requisition:83]dtApprSales:12; ->vDate1; ->vTime1)
			DateTime_DTFrom([Requisition:83]dtApprPurch:15; ->vDate2; ->vTime2)
			DateTime_DTFrom([Requisition:83]dtApprCood:17; ->vDate3; ->vTime3)
			DateTime_DTFrom([Requisition:83]dtApprOth:19; ->vDate4; ->vTime4)
			DateTime_DTFrom([Requisition:83]dtNeeded:6; ->vDate5; ->vTime5)
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		DateTime_DTFrom([Requisition:83]dtApprSales:12; ->vDate1; ->vTime1)
		DateTime_DTFrom([Requisition:83]dtApprPurch:15; ->vDate2; ->vTime2)
		DateTime_DTFrom([Requisition:83]dtApprCood:17; ->vDate3; ->vTime3)
		DateTime_DTFrom([Requisition:83]dtApprOth:19; ->vDate4; ->vTime4)
		DateTime_DTFrom([Requisition:83]dtNeeded:6; ->vDate5; ->vTime5)
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 

