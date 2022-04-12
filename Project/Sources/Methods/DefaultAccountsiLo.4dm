//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 15:59:43
// ----------------------------------------------------
// Method: DefaultAccountsiLo
// Description
// Modified: 03/28/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// ### bj ### 20181201_1040
C_LONGINT:C283($formEvent)
// $formEvent:=form event
C_BOOLEAN:C305($allowed)
$allowed:=True:C214
If (Form event code:C388=On Load:K2:1)
	$allowed:=(UserInPassWordGroup("Archive"))
End if 

If ($allowed)
	
	$formEvent:=iLoProcedure(->[DefaultAccount:32])
	$doMore:=False:C215
	
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			$doMore:=True:C214
			
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			$doMore:=True:C214
			
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			$doMore:=True:C214
	End case 
	
	If ($doMore)  //action for the form regardless of new or existing record
		ALL RECORDS:C47([QQQGLAccount:53])
		ALL RECORDS:C47([AccountPayType:106])
		DISABLE MENU ITEM:C150(2; 2)
		DISABLE MENU ITEM:C150(2; 1)
		// related records not addressed by (P) RelatedGet
		// form calculations
	End if 
	
	booAccept:=True:C214  // no madatory fields
	
End if 