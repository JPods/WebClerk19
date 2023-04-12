// ### jwm ### 20181214_1543 check this or restore old procedure
// ### bj ### 20181201_1040
C_LONGINT:C283($formEvent)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[CarrierZone:143])
$doMore:=False:C215

If (Form event code:C388=On Load:K2:1)
	Execute_TallyMaster("OnOpen_CarrierZones"; "ilo_OnLoadRecord"; 5000)  // ### jwm ### 20161118_1016
End if 

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		$doMore:=True:C214
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
		[CarrierZone:143]idNumCarrier:6:=[Carrier:11]idNum:44
		[CarrierZone:143]carrierid:7:=[Carrier:11]carrierid:10
		[CarrierZone:143]siteid:8:=[Carrier:11]siteid:36  // ### jwm ### 20150303_2226
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
End case 

If ($doMore)  //action for the form regardless of new or existing record
	
	// related records not addressed by (P) RelatedGet
	// form calculations
End if 

booAccept:=True:C214  // no madatory fields

If (False:C215)
	C_POINTER:C301($ptLastTable)
	C_BOOLEAN:C305($fillFromPrevious)
	C_LONGINT:C283($formEvent)
	$formEvent:=Form event code:C388
	If ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
	Else 
		If ($formEvent=On Load:K2:1)
			If (vHere>1)  //coming from another table's input layout
				If (Is new record:C668([CarrierZone:143]))
					$ptLastTable:=ptCurTable
					$fillFromPrevious:=True:C214
				End if 
			End if 
			Execute_TallyMaster("OnOpen_CarrierZones"; "ilo_OnLoadRecord"; 5000)  // ### jwm ### 20161118_1016
		End if 
		//
		C_LONGINT:C283($formEvent)
		$formEvent:=iLoProcedure(->[CarrierZone:143])
		//
		Case of 
			: (iLoRecordChange)
				
			: (iLoRecordNew)  //set in iLoProcedure only once
				
				[CarrierZone:143]idNumCarrier:6:=[Carrier:11]idNum:44
				[CarrierZone:143]carrierid:7:=[Carrier:11]carrierid:10
				[CarrierZone:143]siteid:8:=[Carrier:11]siteid:36  // ### jwm ### 20150303_2226
				Before_New(ptCurTable)  //last thing to do
			: (iLoRecordChange)  //set in iLoProcedure only once
				Before_New(ptCurTable)  //last thing to do
		End case 
		//
	End if 
End if 