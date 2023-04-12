// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/21/15, 11:34:36
// ----------------------------------------------------
// Method: [CarrierWeight].Input1
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150421_1135 added Before_New
// ### jwm ### 20150303_2226 set default values for new record

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
			If (Is new record:C668([CarrierWeight:144]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
		Execute_TallyMaster("OnOpen_CarrierWeights"; "ilo_OnLoadRecord"; 5000)  // ### jwm ### 20161118_1016
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[CarrierWeight:144])
	//
	Case of 
		: (iLoRecordChange)
			Before_New(->[CarrierWeight:144])  //last thing to do  // ### jwm ### 20150421_1135
		: (iLoRecordNew)  //set in iLoProcedure only once
			// ### jwm ### 20150303_2226
			
			[CarrierWeight:144]idNumCarrier:13:=[Carrier:11]idNum:44
			[CarrierWeight:144]carrierid:14:=[Carrier:11]carrierid:10
			[CarrierWeight:144]siteid:19:=[Carrier:11]siteid:36
			// ### jwm ### 20150303_2226
			Before_New(->[CarrierWeight:144])  //last thing to do  // ### jwm ### 20150421_1135
		: (iLoRecordChange)  //set in iLoProcedure only once
			Before_New(->[CarrierWeight:144])  //last thing to do  // ### jwm ### 20150421_1135
	End case 
	//
End if 