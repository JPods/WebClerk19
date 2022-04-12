
C_LONGINT:C283(vFormEvent; changeRecord)

Case of 
	: (entryEntity.id="")
		DBCustomer_init
		
		Before_New(ptCurTable)
	: (Form event code:C388=On Close Box:K2:21)
		//jCancelButton
		CANCEL:C270
	: (Form event code:C388=On Unload:K2:2)
		
	: (Form event code:C388=On Outside Call:K2:11)
		Prs_OutsideCall
	: (Form event code:C388=On Display Detail:K2:22)
		
	: (Form event code:C388=On Load:K2:1)  // nxpr button action is -5 to -8
		If (process_o=Null:C1517)
			CANCEL:C270
		Else 
			If (entryEntity=Null:C1517)
				process_o.cur:=process_o.sel[0]
				entryEntity:=process_o.sel[0].toObject()
			End if 
			AutoSpellCheckOff
			If (process_o.page#Null:C1517)
				If (process_o.page>1)
					FORM GOTO PAGE:C247(process_o.page)
					aPages:=process_o.page
				End if 
			End if 
			//ConsoleMessage ("TEST: On Load")
			C_BOOLEAN:C305($booGo)
			MESSAGES OFF:C175
			oLo20Str1:=""
			booAccept:=Not:C34((entryEntity.customerID="") | (entryEntity.company=""))
			jsetBefore(process_o.tableName)
			
			TallyMasterPopupScirpts("Customer")
			
		End if 
		
		// do these only when the page is selected
		//P_AddressesCustomer
		//OBJECT SET SUBFORM(*; "SF_Document"; [Document]; "Entity")
		
		If (Form:C1466.SF_Document=Null:C1517)
			OBJECT SET SUBFORM:C1138(*; "SF_Document"; "Document")
		End if 
		//End if 
		CLEAR VARIABLE:C89(vItemPict)
		
		changeRecord:=0  // set to zero if record is loaded
		bRetired:=Num:C11(entryEntity.dateRetired#!00-00-00!)
		
		
		// Modified by: Bill James (2017-08-26T00:00:00)
		//RelatedGet   // always relate records
		
		RelatedRelease(0)  // ### jwm ### 20171003_1635 Selection to Array takes forever.
		P_AddressesCustomer
		//ConsoleMessage ("TEST: jrelateClrFiles")
		
		//SET TIMER(60*60*1)
		
		$doChange:=(UserInPassWordGroup("ChangesalesNameID"))
		
		
		
		
		
		If (entryEntity.upsBillingOption="")
			entryEntity.upsBillingOption:="Prepaid & Add"
		End if 
		
		
		If ((entryEntity.zone=-1) & (entryEntity.zip#"") & (entryEntity.shipVia#""))  //should this not be done
			//Find Ship Zone(->entryEntity.zip; ->entryEntity.zone; ->entryEntity.shipVia; ->entryEntity.country; ->entryEntity.siteID)
		End if 
		
		
		
		
		v1Time:=?00:00:00?
		sMenu:=""
		sItem:=""
		
		
		pCCDateStr:=Date_StrMMYY(entryEntity.creditCardExpir)
		//  should we care -- //  CHOPPED DivD_SetFieldColor(->entryEntity.accountingDivision)
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
		
		
	: (Form event code:C388=On Data Change:K2:15)
		
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [Order:3]; "IncludedDS")
		
	: (Form event code:C388=On Drop:K2:12)
		
		Case of 
			: (aPages=6)
				
			: (aPages=7)
				SFEX_DropDocument
		End case 
	: (Form event code:C388=On Activate:K2:9)
		RelatedRelease
	: (Form event code:C388=On Deactivate:K2:10)
		
	: (Form event code:C388=On Display Detail:K2:22)
		
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
