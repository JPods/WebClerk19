//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 14:42:31
// ----------------------------------------------------
// Method: TallyResultsiLo
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
			If (Is new record:C668([TallyResult:73]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
		//
		C_LONGINT:C283($formEvent)
		$formEvent:=iLoProcedure(->[TallyResult:73])
		//
		$doMore:=False:C215
		Case of 
			: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
				
				
			: (iLoRecordNew)  //set in iLoProcedure only once, new record
				[TallyResult:73]dtCreated:11:=DateTime_DTTo
				If ([UserReport:46]idNum:17=0)
					READ WRITE:C146([TallyResult:73])
					
				End if 
				$doMore:=True:C214
			: (iLoRecordChange)  //set in iLoProcedure only once, existing record
				
				$doMore:=True:C214
		End case 
		If ($doMore)  //action for the form regardless of new or existing record
			If (myOK#0)
				Nxpr_TallyResul
			End if 
			C_LONGINT:C283($w)
			$w:=Find in array:C230(<>aTableNums; [TallyResult:73]tableNum:3)
			If ($w>0)
				<>aTableNames:=<>aTableNums{$w}
			Else 
				<>aTableNames:=0
			End if 
			
			
			
			$doChange:=(UserInPassWordGroup("UnlockRecord"))
			If (Not:C34($doChange))
				OBJECT SET ENTERABLE:C238([TallyResult:73]publish:36; False:C215)
			End if 
			DateTime_DTFrom([TallyResult:73]dtReport:12; ->vDate1; ->vTime1)
			Before_New(ptCurTable)  //last thing to do
		End if 
		//every cycle
		
		booAccept:=True:C214
	End if 
End if 

