//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 15:02:29
// ----------------------------------------------------
// Method: SyncExchangeiLo
// Description
// Modified: 03/28/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

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
			If (Is new record:C668([SyncExchange:104]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
			//
			C_LONGINT:C283($formEvent)
			$formEvent:=iLoProcedure(->[SyncExchange:104])
			//
			$doMore:=False:C215
			Case of 
				: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
					
					
				: (iLoRecordNew)  //set in iLoProcedure only once, new record
					
					$doMore:=True:C214
				: (iLoRecordChange)  //set in iLoProcedure only once, existing record
					
					$doMore:=True:C214
			End case 
			If ($doMore)  //action for the form regardless of new or existing record
				jDateTimeRecov([SyncExchange:104]dtCreated:5; ->vDate1; ->vTime1)
				iLo20String1:=String:C10(vDate1)*(Num:C11(Not:C34(vDate1=!00-00-00!)))
				iLo20String2:=String:C10(vTime1)*(Num:C11(Not:C34(vTime1=?00:00:00?)))
				Before_New(ptCurTable)  //last thing to do
			End if 
			//every cycle
			
			booAccept:=True:C214
		End if 
	End if 
End if 