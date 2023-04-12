//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 15:04:50
// ----------------------------------------------------
// Method: SyncRelationshipiLo
// Description
// Modified: 03/28/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20200211_2244 Changed layout to better show Pin
If (Form event code:C388=On Load:K2:1)
	C_BOOLEAN:C305($passwordPass)
	$passwordPass:=(UserInPassWordGroup("Sync"))
	If ($passwordPass=False:C215)
		ALERT:C41("Not in Sync Password Group.")
		CANCEL:C270
	End if 
End if 

C_LONGINT:C283($formEvent)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[SyncRelation:103])
$doMore:=False:C215

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
End case 

If ($doMore)  //action for the form regardless of new or existing record
	If ([SyncRelation:103]partnerNumber:14=0)
		[SyncRelation:103]partnerNumber:14:=1
	End if 
	// related records not addressed by (P) RelatedGet
	// form calculations
	
	$doMore:=False:C215
	
	
	iLoText7:=BLOB to text:C555([SyncRelation:103]privateKey:45; UTF8 text without length:K22:17)
	iLoText8:=BLOB to text:C555([SyncRelation:103]publicKey:46; UTF8 text without length:K22:17)
	
	DateTime_DTFrom([SyncRelation:103]dtLastUpdate:6; ->iLoDate1; ->iLoTime1)
	Before_New(ptCurTable)  //last thing to do
End if 

booAccept:=True:C214  // no madatory fields
