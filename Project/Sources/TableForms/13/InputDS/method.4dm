If (False:C215)
	//Date: 02/23/02
	//Who: Peter Fleming, Arkware
	//Description: Enter Prepaid as default for [Contact]UPSBillingOption
	VERSION_960
	//June 29, 2002
	//Bill
	//Descriptiont:  If Option key, set to table name
End if 
// ### jwm ### 20170530_1325 rebuilt field OptOut

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)

If ($formEvent=On Close Box:K2:21)  // ### jwm ### 20181211_1050
	jCancelButton
End if 

$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set t.compilerhe record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([Contact:13]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[Contact:13])
	//
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			If ($fillFromPrevious)
				Contact_FillFrom($ptLastTable)
			End if 
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			If (([Customer:2]customerID:1#[Contact:13]customerID:1) & ([Contact:13]customerID:1#""))
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
				If (Records in selection:C76([Customer:2])=0)
					ALERT:C41("There is no Customer Card for this contact's Customer Account Code.")
				Else 
					srVarLoad(Table:C252(->[Customer:2]))
				End if 
			End if 
			$doMore:=True:C214
	End case 
	If ($doMore)
		TallyMasterPopuuScriptsGeneral(->[Contact:13]; "iLo"; ""; "")
		TallyMasterPopuuScriptsGeneral(->[Contact:13]; "ilo"; "test"; "aLoScripts2")
		
		If (([Contact:13]company:23="") & ([Customer:2]company:2#""))
			[Contact:13]company:23:=[Customer:2]company:2
		End if 
		vContactEmail:=[Contact:13]email:35
		//  Put  the formating in the form  jFormatPhone(->[Customer]phone)
		//  Put  the formating in the form  jFormatPhone(->[Contact]phone)
		//  Put  the formating in the form  jFormatPhone(->[Contact]fax)
		//  Put  the formating in the form  jFormatPhone(->[Contact]phoneCell)
		booAccept:=True:C214
		REDUCE SELECTION:C351([CallReport:34]; 0)
		REDUCE SELECTION:C351([QA:70]; 0)
		jNxPvButtonSet(->aServiceRecs)
		//  CHOPPED DivD_SetFieldColor(->[Customer]division)
		//  CHOPPED DivD_SetFieldColor(->[Customer]customerID)
		//  CHOPPED QA_LoOnEntry(eAnsListContacts; 13; String([Contact]idNum); 0; 0)
		//02/23/02.prf Enter Prepaid as default
		If ([Contact:13]upsBillingOption:49="")
			[Contact:13]upsBillingOption:49:="Prepaid & Add"
		End if 
		iLo20String1:=""
		If ([Customer:2]customerID:1=[Contact:13]customerID:1)
			If ([Contact:13]idNum:28=[Customer:2]contactBillTo:92)
				iLo20String1:="Bill2_"
			End if 
			If ([Contact:13]idNum:28=[Customer:2]contactShipTo:93)
				iLo20String1:=iLo20String1+"Ship_"
			End if 
		End if 
		If ([Contact:13]letterList:13)
			iLo20String1:=iLo20String1+"Ltr_"
		End if 
		If ([Contact:13]optOut:51#"")
			iLo20String1:=iLo20String1+"OptOut"
		End if 
		Before_New(ptCurTable)  //last thing to do
	End if 
End if 





