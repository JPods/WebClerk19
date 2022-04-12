//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 15:52:24
// ----------------------------------------------------
// Method: RepsiLo
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
		If (UserInPassWordGroup("ViewCommission"))
			If (vHere>1)  //coming from another table's input layout
				If (Is new record:C668([Rep:8]))
					$ptLastTable:=ptCurTable
					$fillFromPrevious:=True:C214
				End if 
			End if 
		End if 
	End if 
	// ### bj ### 20181114_0958
	//  iLoProcedure (->) should not be in the On Load area. 
	// It needs to operate on Record Changes
	//  RelatedGet
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[Rep:8])
	//
	
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			iLoReturningToLayout:=False:C215
			$doMore:=True:C214
			
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			iLoRecordNew:=False:C215
			$doMore:=True:C214
			
			OBJECT SET ENTERABLE:C238([Rep:8]repID:1; True:C214)
			READ ONLY:C145([DefaultAccount:32])
			GOTO RECORD:C242([DefaultAccount:32]; 0)
			[Rep:8]commPayGLAcct:18:=[DefaultAccount:32]commRepPay:10
			UNLOAD RECORD:C212([DefaultAccount:32])
			READ WRITE:C146([DefaultAccount:32])
			
			
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			iLoRecordChange:=False:C215
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		srDisplayEmail:=[Rep:8]email:22
		
		// ### bj ### 20181114_0956
		// this is unloading the records gathered during iLoProcedure, 
		//REDUCE SELECTION([Proposal];0)
		//REDUCE SELECTION([Order];0)
		//REDUCE SELECTION([Invoice];0)
		//REDUCE SELECTION([Quota];0)
		//REDUCE SELECTION([Service];0)
		//REDUCE SELECTION([Territory];0)
		QUERY:C277([RepContact:10]; [RepContact:10]repID:1=[Rep:8]repID:1)
		//  Put  the formating in the form  jFormatPhone(->[Rep]phone; ->srPhone; ->[Rep]fax; ->[Rep]phoneCell)
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	If (Modified record:C314([RepContact:10]))
		SAVE RECORD:C53([RepContact:10])
	End if 
	booAccept:=([Rep:8]repID:1#"")
End if 
