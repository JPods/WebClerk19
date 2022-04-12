Case of 
	: ((Before:C29) | (booPreNext))
		C_REAL:C285($ItemWt; $BackOrdered)
		C_LONGINT:C283($i; $o; $f)
		C_BOOLEAN:C305($booOK; invMod)
		//    INPUT LAYOUT([Customer];"iCustomer_9")
		vPartNum:=""
		booPreNext:=False:C215
		booAccept:=True:C214
		booDuringDo:=True:C214  //use to avoid all during phase actions when side buttons are used.
		InRelatedRec:=0  //Sets that subrecord has not been entered
		aPagePath{Table:C252(->[Customer:2])}:=1
		jNxPvButtonSet
		If (vHere<2)
			vHere:=2
			ptCurTable:=(->[Customer:2])
			SET WINDOW TITLE:C213("Manufacturer-"+aPages{1})
			jNavPalletPop("General"; "Products"; "Sales")
			jSetMenuNums(10; 12; 11)
			aPages:=1
		End if 
		C_LONGINT:C283($viProcess)
		$viProcess:=Current process:C322
		SET MENU BAR:C67(iLoMenu; $viProcess; *)
		//    DISABLE ITEM(2;1)//no cloning new records 
		//   DISABLE ITEM(2;2)//no cmd b - automatically cycles to new invoice
		//   DISABLE ITEM(2;7)
		//  booNewNum:=True
		REDUCE SELECTION:C351([Item:4]; 0)
		REDUCE SELECTION:C351([Order:3]; 0)
		REDUCE SELECTION:C351([Payment:28]; 0)
		REDUCE SELECTION:C351([Invoice:26]; 0)
		ARRAY REAL:C219(aPayShow; 0)
		//    jClearFile ([Contact])
		REDUCE SELECTION:C351([Service:6]; 0)
		If ([Customer:2]customerID:1="")
			OBJECT SET ENTERABLE:C238([Customer:2]customerID:1; True:C214)
			DBCustomer_init
			DISABLE MENU ITEM:C150(2; 1)  //no cloning new records
			srAcct:=[Customer:2]customerID:1
			bChangeRec:=1
			FontSrchLabels(2)
			REDUCE SELECTION:C351([Contact:13]; 0)
			//  CHOPPED  ContactsLoad(0)
			MFG_AssignCode
		Else 
			FontSrchLabels(3)
			srPhone:=[Customer:2]phone:13
			srZip:=[Customer:2]zip:8
			srCustomer:=[Customer:2]company:2
			srAcct:=[Customer:2]customerID:1
			//  CHOPPED  ContactsLoad(-1)
		End if 
		//  Put  the formating in the form  jFormatPhone(->[Customer]phone; ->[Customer]fax; ->srPhone)
		booAccept:=True:C214
		MESSAGES OFF:C175
		curRecNum:=Selected record number:C246([Customer:2])
		MESSAGES ON:C181
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		If (booDuringDo)
			//      jsetDuringIncluded
			If (ptCurTable#(->[Customer:2]))
				If (vInclTrue=True:C214)
					MESSAGES OFF:C175
					vHere:=vHere-1
					ARRAY LONGINT:C221(aPagePath; Get last table number:C254)
					aPagePath{Table:C252(ptCurTable)}:=1
					ptCurTable:=(->[Customer:2])
					jNavPalletPop("General"; "Products"; "Sales")
					jSetMenuNums(10; 12; 11)
					jNxPvButtonSet
					$k:=aPagePath{Table:C252(->[Customer:2])}
					FORM GOTO PAGE:C247($k)
					SET WINDOW TITLE:C213("Manufacturer-"+aPages{$k})
					If (vHere<=2)
						vInclTrue:=False:C215
					End if 
					C_LONGINT:C283($viProcess)
					$viProcess:=Current process:C322
					SET MENU BAR:C67(iLoMenu; $viProcess; *)
					jSetAutoReMenus
					MESSAGES ON:C181
					curRecNum:=Selected record number:C246([Customer:2])
				End if 
			End if 
			InRelatedRec:=0  //Clear notation that we are moving back from a subFile
			booDuringDo:=True:C214
		End if 
		
End case 