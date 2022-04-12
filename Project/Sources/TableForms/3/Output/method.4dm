C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Outside Call:K2:11)  //: (Outside call)
		Case of 
			: (<>prsTableNum=-3)
				QUERY:C277([Order:3]; [Order:3]customerid:1=<>prscustomerID)
				If (False:C215)  //add a TM option
					
				Else 
					ORDER BY:C49([Order:3]; [Order:3]dateOrdered:4; <)
					REDUCE SELECTION:C351([Order:3]; 10)
				End if 
				<>prscustomerID:=""
				<>prsTableNum:=-1
				booPreNext:=True:C214
			: (<>vlRecNum>0)
				Prs_OutsideCall
			: (<>vbDoQuit)
				jAcceptButton(True:C214; True:C214)
			Else 
				Prs_OutsideCall
		End case 
		
	: ($formEvent=On Activate:K2:9)
		FormEventOnActivate
	: ($formEvent=On Close Detail:K2:24)
		FormEventCloseDetail
	: ($formEvent=On Unload:K2:2)
		FormEventOnUnloadOLO
	: ($formEvent=On Display Detail:K2:22)
		FormEventOnDisplayDetail
	: ($formEvent=On Header:K2:17)
		C_TEXT:C284(<>prscustomerID)
		C_LONGINT:C283(<>prsTableNum)
		If (<>prscustomerID#"")
			QUERY:C277([Order:3]; [Order:3]customerid:1=<>prscustomerID)
			<>prscustomerID:=""
			<>prsTableNum:=-1
		End if 
		FormEventOnHeader
	: ($formEvent=On Selection Change:K2:29)
		FormEventOnSelectionChange
	: ($formEvent=On Open Detail:K2:23)
		FormEventOnOpenDetail
	: ($formEvent=On Close Box:K2:21)
		FormEventOnCloseBox
	: ($formEvent=On Clicked:K2:4)
		FormEventOnClicked
	: ($formEvent=On Double Clicked:K2:5)
		FormEventOnDoubleClicked
	: (($formEvent=On Load:K2:1) & (vHere<<>outLayoutTrigger))  //In header
		If (False:C215)
			TCNavigationChange005
		End if 
		jsetInHeader(->[Order:3])
		OLO_HereAndMenu
		
		// ### bj ### 20191130_1216 duplicated from OLO_HereAndMenu
		//LoadCustomFields   // load custom user fields
		
		//: ($formEvent=On Header)
	: ($formEvent=On Outside Call:K2:11)  // (Outside call)
		QUERY:C277([Order:3]; [Order:3]customerid:1=<>prscustomerID)
		<>prscustomerID:=""
		<>prsTableNum:=-1
		booPreNext:=True:C214
		
		
		
	Else 
		
End case 

