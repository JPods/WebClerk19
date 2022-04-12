//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-09T00:00:00, 14:28:49
// ----------------------------------------------------
// Method: iLoWebClerk
// Description
// Modified: 09/09/17
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Load Record:K2:38)
	
End if 
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		passwordPass:=(UserInPassWordGroup("EditReportScript"))
		If (Not:C34(passwordPass))
			CANCEL:C270
		End if 
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([WebClerk:78]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[WebClerk:78])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		iLoText1:=""
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 
