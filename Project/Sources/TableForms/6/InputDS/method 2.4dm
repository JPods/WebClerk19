C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent; $incomingTableNum)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	$incomingTableNum:=-1
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			$incomingTableNum:=Table:C252(ptCurTable)
			blockServiceRelate:=True:C214  //keep from wiping out exiting order and proposal// Modified by: williamjames 101020)
			//settings allows Cust_OPiRays (eItemSrvr;0) to wipeout the current order. would also happen in proposals
			If (Is new record:C668([Service:6]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[Service:6])
	//
	$doMore:=False:C215
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			
			QA_LoOnEntry(eAnsListService; Table:C252(->[Service:6]); [Service:6]customerID:1; [Service:6]idNum:26; [Service:6]idNumTask:51)
			List_RaySize(0)
			AL_UpdateArrays(eItemSrvr; -2)
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		MESSAGES OFF:C175
		booAccept:=True:C214
		<>aNameID:=1
		C_POINTER:C301(ptFile)
		
		If ((eItemSrvr>0) & (allowAlerts_boo))
			Cust_OpiFillRay(0)
			Cust_OPiDefineA(eItemSrvr; 0)
		End if 
		List_RaySize(0)
		If ($formEvent=On Load:K2:1)
			// ### bj ### 20210801_1430  Rework these
			///  QQQZZZQQQ as part of ListBox Changes
			Cust_OPiLoadDfl
			Cust_OPiRLoadDf
			Cust_OPRLLoadDf
			aLoCustOPi:=<>vlCOPiTab
			Cust_OPiRays(eItemSrvr; 0)
			Cust_OPiRInitAr
			Cust_OPiRALSetu(eRelateSrvr)
			Cust_OPRLInitAr
			Cust_OPRLALSetu(eRLinesSrvr)
			Cust_OPiRRelate(eRelateSrvr; eRLinesSrvr)
		End if 
		
		NxPvService($incomingTableNum)
		
		// QA_LoOnEntry (eAnsListService;"";0;->[Service]taskID)
		QA_LoOnEntry(eAnsListService; Table:C252(->[Service:6]); [Service:6]customerID:1; [Service:6]idNum:26; [Service:6]idNumTask:51)
		// -- AL_SetScroll(eItemSrvr; 0; 0)
		// -- AL_SetScroll(eRelateSrvr; 0; 0)
		// -- AL_SetScroll(eRLinesSrvr; 0; 0)
		// -- AL_SetScroll(eAnsListService; 0; 0)
		ENABLE MENU ITEM:C149(2; 2)
		MESSAGES ON:C181
		myCycle:=0
		$viProcess:=Current process:C322
		HIDE MENU BAR:C432
		SET MENU BAR:C67(iLoMenu; $viProcess; *)
		SHOW MENU BAR:C431
		
		// ### bj ### 20200313_1457
		If (Locked:C147([Service:6]))
			OBJECT SET RGB COLORS(*; "srCustomer"; (Yellow:K11:2; 256*Red:K11:4))
			OBJECT SET RGB COLORS(*; "srAcct"; (Yellow:K11:2; 256*Red:K11:4))
			OBJECT SET RGB COLORS(*; "srZip"; (Yellow:K11:2; 256*Red:K11:4))
			OBJECT SET RGB COLORS(*; "srPhone"; (Yellow:K11:2; 256*Red:K11:4))
		End if 
		
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	If (Size of array:C274(aOPiRecID)=0)
		Cust_AlClear(eItemSrvr)
	Else 
		// -- AL_SetSelect(eItemSrvr; aOPiSelect)
		// -- AL_SetScroll(eItemSrvr; viVert; viHorz)
	End if 
	If (aPages#FORM Get current page:C276)
		Case of 
			: (aPages=3)
				// -- AL_SetScroll(eItemSrvr; 1; 0)
				// -- AL_SetScroll(eRelateSrvr; 1; 0)
				// -- AL_SetScroll(eRLinesSrvr; 1; 0)
				// -- AL_SetScroll(eAnsListService; 0; 0)
			: (aPages=4)
				// -- AL_SetScroll(eItemSrvr; 0; 0)
				// -- AL_SetScroll(eRelateSrvr; 0; 0)
				// -- AL_SetScroll(eRLinesSrvr; 0; 0)
				// -- AL_SetScroll(eAnsListService; 1; 0)
			Else 
				// -- AL_SetScroll(eItemSrvr; 0; 0)
				// -- AL_SetScroll(eRelateSrvr; 0; 0)
				// -- AL_SetScroll(eRLinesSrvr; 0; 0)
				// -- AL_SetScroll(eAnsListService; 0; 0)
		End case 
	End if 
	If (Modified record:C314([Contact:13]))
		SAVE RECORD:C53([Contact:13])
	End if 
	booAccept:=True:C214
End if 

