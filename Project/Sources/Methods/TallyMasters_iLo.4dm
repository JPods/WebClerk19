//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 14:34:32
// ----------------------------------------------------
// Method: TallyMasters_iLo
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
			If (Is new record:C668([TallyMaster:60]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[TallyMaster:60])
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
		Before_New(ptCurTable)  //last thing to do
		If ([TallyMaster:60]Purpose:3="SSL")
			OBJECT SET TITLE:C194(*; "lb_Profile1"; "Status")
			OBJECT SET TITLE:C194(*; "lb_Profile2"; "ssl-method")
			OBJECT SET TITLE:C194(*; "lb_Profile3"; "password")
			OBJECT SET TITLE:C194(*; "lb_Script"; "Certificate")
			OBJECT SET TITLE:C194(*; "lb_Build"; "Private Key")
			// OBJECT SET TITLE(*;"lb_After";"New/Exist")
			OBJECT SET TITLE:C194(*; "lb_Template"; "Request")
			
		End if 
	End if 
	//every cycle
	If (([TallyMaster:60]tableNum:1>0) & ([TallyMaster:60]tableNum:1<=Get last table number:C254))
		oLo20String1:=Table name:C256([TallyMaster:60]tableNum:1)
	Else 
		oLo20String1:=""
	End if 
	
	booAccept:=True:C214
End if 