
C_LONGINT:C283(vFormEvent; changeRecord)

Case of 
	: (entry_o.id=Null:C1517)
		
	: (entry_o.id="")
		DB_InitCustomer
		
		Before_New(ptCurTable)
		
	: (Form event code:C388=On Page Change:K2:54)
		
	: (Form event code:C388=On Display Detail:K2:22)
		
	: (Form event code:C388=On Data Change:K2:15)
		entry_o.changed:=True:C214
		
	: (Form event code:C388=On After Edit:K2:43)
		
	: (Form event code:C388=On Timer:K2:25)
		process_o.entitySave()
		SET TIMER:C645(60*60*2)
		
		
	: (Form event code:C388=On Page Change:K2:54)
		
	: (Form event code:C388=On Display Detail:K2:22)
		
		
	: (Form event code:C388=On Close Box:K2:21)
		//jCancelButton
		CANCEL:C270
	: (Form event code:C388=On Unload:K2:2)
		
	: (Form event code:C388=On Outside Call:K2:11)
		Prs_OutsideCall
		
	: (Form event code:C388=On Load:K2:1)  // nxpr button action is -5 to -8
		If (process_o=Null:C1517)
			CANCEL:C270
		Else 
			AutoSpellCheckOff
			C_BOOLEAN:C305($booGo)
			MESSAGES OFF:C175
			
			jsetBefore(process_o.dataClassName)
			
			TallyMasterPopupScirpts("Customer")
			
		End if 
		
		
		If (Form:C1466.SF_Document=Null:C1517)
			OBJECT SET SUBFORM:C1138(*; "SF_Document"; "Document")
		End if 
		//End if 
		CLEAR VARIABLE:C89(vItemPict)
		
		changeRecord:=0  // set to zero if record is loaded
		bRetired:=Num:C11(entry_o.dateRetired#!00-00-00!)
		
		
		// Modified by: Bill James (2017-08-26T00:00:00)
		//RelatedGet   // always relate records
		
		RelatedRelease(0)  // ### jwm ### 20171003_1635 Selection to Array takes forever.
		P_AddressesCustomer
		//Console_Log ("TEST: jrelateClrFiles")
		
		//SET TIMER(60*60*1)
		
		$doChange:=(UserInPassWordGroup("ChangesalesNameID"))
		
		
		
		
		
		If (entry_o.upsBillingOption="")
			entry_o.upsBillingOption:="Prepaid & Add"
		End if 
		
		
		If ((entry_o.zone=-1) & (entry_o.zip#"") & (entry_o.shipVia#""))  //should this not be done"
			//Find Ship Zone(->entry_o.zip; ->entry_o.zone; ->entry_o.shipVia; ->entry_o.country; ->entry_o.siteID)
		End if 
		
		
		
		
		v1Time:=?00:00:00?
		sMenu:=""
		sItem:=""
		
		
		pCCDateStr:=Date_StrMMYY(entry_o.creditCardExpir)
		//  should we care -- //  CHOPPED DivD_SetFieldColor(->entry_o.accountingDivision)
		//  should we care -- //  CHOPPED DivD_SetFieldColor(->srAcct)
		
		
	: (Form event code:C388=On Activate:K2:9)
		
	: (Form event code:C388=On Deactivate:K2:10)
		
	: (Form event code:C388=On Close Detail:K2:24)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
	: (Form event code:C388=On Plug in Area:K2:16)
		
	: (Form event code:C388=On Load Record:K2:38)
		
	: (Form event code:C388=On Unload:K2:2)
		
	: (Form event code:C388=On Getting Focus:K2:7)
		
	: (Form event code:C388=On Losing Focus:K2:8)
		
	: (Form event code:C388=On Outside Call:K2:11)
		
		
		
	: (Form event code:C388=On Drop:K2:12)
		
		Case of 
			: (aPages=6)
				
			: (aPages=7)
				SFEX_DropDocument
		End case 
	: (Form event code:C388=On Activate:K2:9)
		RelatedRelease
	: (Form event code:C388=On Deactivate:K2:10)
		
		
	: (Form event code:C388=On Close Detail:K2:24)
		
	: (Form event code:C388=On Close Box:K2:21)
		
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Timer:K2:25)  //auto close windows after time passing
		
	: (Form event code:C388=On Resize:K2:27)  //auto close windows after time passing
	: (Form event code:C388=On Menu Selected:K2:14)
	: (Form event code:C388=On Before Keystroke:K2:6)
		
	: (Form event code:C388=On After Keystroke:K2:26)
		C_TEXT:C284($keystroke)
		$keystroke:=Get edited text:C655
		SET TIMER:C645(60*60*10)
	Else 
End case 
