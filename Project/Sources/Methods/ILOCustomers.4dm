//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 9/05/08, 10:06:23
// ----------------------------------------------------
// Method: ILOCustomers
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	//Date: 02/23/02
	//Who: Peter Fleming, Arkware
	//Description: Enter Prepaid as default for [Customer]UPSBillingOption
	VERSION_960
End if 
C_LONGINT:C283($formEvent; vFormEvent; changeRecord)
$formEvent:=Form event code:C388
vFormEvent:=$formEvent
//ALERT(String($formEvent))




If (<>aLastRecNum{Table:C252(ptCurTable)}#Record number:C243([Customer:2]))
	
End if 
If (changeRecord<-3)
	// nxpr button actions, gotoRecord action
End if 

Case of 
	: ($formEvent=On Load:K2:1)  //|(booPreNext))//(Before)
		jsetBefore(->[Customer:2])
		AutoSpellCheckOff
		booAccept:=True:C214
		
		
		If (allowAlerts_boo)
			TallyMasterPopupScirpts(->[ManufacturerTerm:111])
			TallyMasterPopupScirpts(->[Customer:2])
			jrelateClrFiles(1)  //force all arrays to be empty
		End if 
		
		
	: ($formEvent=On Close Box:K2:21)
		jCancelButton
		
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)
		READ WRITE:C146([Customer:2])
	: ($formEvent=On Outside Call:K2:11)
		Prs_OutsideCall
		
	: (Form event code:C388=On Display Detail:K2:22)
		$vsTheEvent:="Displaying record #"+String:C10(Selected record number:C246([Customer:2]))
		
		
		Before_New(->[Customer:2])
		//NEXT PAGE
		//PREVIOUS PAGE
		TRACE:C157
		If (Is new record:C668([Customer:2]))
			bRetired:=0
			OBJECT SET ENTERABLE:C238([Customer:2]customerID:1; True:C214)
			DBCustomer_init
			srVarLoad(Table:C252(->[Customer:2]))
			DISABLE MENU ITEM:C150(2; 1)  //no cloning new records
			srAcct:=[Customer:2]customerID:1
			bChangeRec:=1
			FontSrchLabels(2)
			jrelateClrFiles(1)
			jNxPvButtonSet
			If ([Customer:2]upsBillingOption:96="")
				[Customer:2]upsBillingOption:96:="Prepaid & Add"
			End if 
			Before_New(ptCurTable)
		End if 
		
		OBJECT SET SUBFORM:C1138(*; "SF_Document"; [Document:100]; "Entity")
		
		
		
		//End if 
		CLEAR VARIABLE:C89(vItemPict)
		
		changeRecord:=0  // set to zero if record is loaded
		bRetired:=Num:C11([Customer:2]dateRetired:111#!00-00-00!)
		<>aLastRecNum{Table:C252(ptCurTable)}:=Record number:C243([Customer:2])
		
		// Modified by: Bill James (2017-08-26T00:00:00)
		//RelatedGet   // always relate records
		
		RelatedRelease(0)  // ### jwm ### 20171003_1635 Selection to Array takes forever.
		
		//ConsoleMessage ("TEST: jrelateClrFiles")
		
		//SET TIMER(60*60*1)
		srVarLoad(Table:C252(->[Customer:2]))  // calls Alert popup
		$doChange:=(UserInPassWordGroup("ChangesalesNameID"))
		If (Not:C34($doChange))
			OBJECT SET ENTERABLE:C238([Customer:2]salesNameID:59; False:C215)
			OBJECT SET ENTERABLE:C238([Customer:2]repID:58; False:C215)
		End if 
		
		
		FontSrchLabels(1)
		////  CHOPPED  ContactsLoad (-1)
		If (<>tcDefaultLockAcctNbr)
			OBJECT SET ENTERABLE:C238(srAcct; False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(srAcct; True:C214)
		End if 
		jNxPvButtonSet
		
		If ([Customer:2]upsBillingOption:96="")
			[Customer:2]upsBillingOption:96:="Prepaid & Add"
		End if 
		//  Put  the formating in the form  jFormatPhone(->[Customer]phone; ->srPhone; ->[Customer]fax; ->[Customer]phoneCell)
		If (([Customer:2]zone:57=-1) & ([Customer:2]zip:8#"") & ([Customer:2]shipVia:12#""))  //should this not be done
			Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteID:106)
		End if 
		curRecNum:=Record number:C243([Customer:2])
		v1Time:=?00:00:00?
		sMenu:=""
		sItem:=""
		
		
		pCCDateStr:=Date_StrMMYY([Customer:2]creditCardExpir:54)
		
		
		If (Locked:C147([Customer:2]))
			// ### bj ### 20200313_1449 Make a locked record more vididly locked
			//OBJECT SET RGB COLORS(*; "srCustomer"; Yellow; Red)
			_O_OBJECT SET COLOR:C271(srCustomer; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srAcct; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srZip; -(Yellow:K11:2+(256*Red:K11:4)))
			_O_OBJECT SET COLOR:C271(srPhone; -(Yellow:K11:2+(256*Red:K11:4)))
			
			_O_OBJECT SET COLOR:C271([Customer:2]nameFirst:73; -(Yellow:K11:2+(256*Red:K11:4)))
		End if 
		
		//Format_CreditCd (->[Customer]CreditCardNum)
		//ConsoleMessage ("TEST: Format_CreditCd")
		<>CustAcct:=[Customer:2]customerID:1
		<>ptCurTable:=(->[Customer:2])
		
		
	: ($formEvent=On Activate:K2:9)
		If (False:C215)
			//allowing this will allow changes to be displayed by then the current selected lines are lost
			RelatedRelease
		End if 
		//: ($formEvent=On Losing Focus)
		//<>vPricePoint:=[Customer]TypeSale
	: ($formEvent=On Deactivate:K2:10)
		<>vPricePoint:=[Customer:2]typeSale:18
		
		//: ($formEvent=On Activate)
		//<>vPricePoint:=[Customer]TypeSale
		//: ($formEvent=On Getting Focus)
		//<>vPricePoint:=[Customer]TypeSale
	: ($formEvent=On Close Detail:K2:24)
		READ WRITE:C146([Customer:2])
		
End case 
booAccept:=Not:C34(([Customer:2]customerID:1="") | ([Customer:2]company:2=""))

If (False:C215)
	Case of 
		: ($formEvent=On Clicked:K2:4)
			
		: ($formEvent=On Plug in Area:K2:16)
			
		: ($formEvent=On Load:K2:1)
			
		: ($formEvent=On Load Record:K2:38)
			//UNLOAD RECORD(ptCurTable->)
			READ WRITE:C146([Customer:2])
		: ($formEvent=On Unload:K2:2)
			
		: ($formEvent=On Getting Focus:K2:7)
			
		: ($formEvent=On Losing Focus:K2:8)
			
		: ($formEvent=On Outside Call:K2:11)
			
		: ($formEvent=On Drop:K2:12)
			
			Case of 
				: (aPages=6)
					
				: (aPages=7)
					SFEX_DropDocument
			End case 
		: ($formEvent=On Activate:K2:9)
			RelatedRelease
		: ($formEvent=On Deactivate:K2:10)
			
		: ($formEvent=On Display Detail:K2:22)
			
		: ($formEvent=On Close Detail:K2:24)
			
		: ($formEvent=On Close Box:K2:21)
			
		: ($formEvent=On Validate:K2:3)
			
		: ($formEvent=On Timer:K2:25)  //auto close windows after time passing
			
		: ($formEvent=On Resize:K2:27)  //auto close windows after time passing
		: ($formEvent=On Menu Selected:K2:14)
		: ($formEvent=On Before Keystroke:K2:6)
			
		: ($formEvent=On After Keystroke:K2:26)
			C_TEXT:C284($keystroke)
			$keystroke:=Get edited text:C655
			SET TIMER:C645(60*60*10)
		Else 
	End case 
End if 
