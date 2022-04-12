// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 12:39:41
// ----------------------------------------------------
// Method: Form Method: PackingPallets
// Description
// 
//
// Parameters
// ----------------------------------------------------
Case of 
		
	: (Before:C29)
		C_LONGINT:C283(ePalletList)
		LT_FillArrayLoadItems(0)
		C_LONGINT:C283($i; $k; $error)
		LT_ALDefineLoadItems(eLoadList; "Arial"; 14; 2)
		//
		PKArrayManage(0)
		//PKALDefine (eShipList;"Arial";14;2)
		PKALDefine(eShipList; "Arial"; 14; 3)  //###_jwm_###
		//    
		PKArrayManage22(0)
		PKALDefine22(ePalletList; "Arial"; 14; 2)
		//
		ARRAY TEXT:C222(aTmp20Str4; 3)
		aTmp20Str4{1}:="All Container Types"
		aTmp20Str4{2}:="Pallets and above"
		aTmp20Str4{3}:="Packages Only"
		aTmp20Str4:=2
		iLoDate1:=Current date:C33
		iLoDate2:=Current date:C33
		//
		QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26>1; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]complete:36<1; *)
		READ ONLY:C145([Order:3])
		QUERY:C277([Order:3]; [Order:3]idNum:2=<>orderPacking)
		iLoText1:=[Order:3]customerID:1
		iLoText2:=[Order:3]company:15
		UNLOAD RECORD:C212([Order:3])
		QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=iLoText1; *)
		QUERY:C277([LoadTag:88])
		PKArrayManage22(Records in selection:C76([LoadTag:88]))
		//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
		//
		QUERY:C277([LoadTag:88]; [LoadTag:88]documentID:17=<>orderPacking; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]containerType:26<2)
		PKArrayManage(Records in selection:C76([LoadTag:88]))
		If (eShipList>0)
			//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
		End if 
		//
	: (Outside call:C328)
		Case of 
			: (<>vlRecNum>0)
				Prs_OutsideCall
				FORM NEXT PAGE:C248
				FORM PREVIOUS PAGE:C249
			: (<>vbDoQuit)
				jAcceptButton(True:C214; True:C214)
			Else 
				QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26>1; *)
				QUERY:C277([LoadTag:88];  & [LoadTag:88]complete:36<1; *)
				If (b3=0)
					READ ONLY:C145([Order:3])
					QUERY:C277([Order:3]; [Order:3]idNum:2=<>orderPacking)
					iLoText1:=[Order:3]customerID:1
					iLoText2:=[Order:3]company:15
					UNLOAD RECORD:C212([Order:3])
					QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=iLoText1; *)
				End if 
				QUERY:C277([LoadTag:88])
				PKArrayManage22(Records in selection:C76([LoadTag:88]))
				//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
		End case 
		
	Else 
		
		
		iNumPallets:=Size of array:C274(aPKUniqueID22)  //###_jwm_###
		iNumBoxes:=Size of array:C274(aPKUniqueID)  //###_jwm_###
		
End case 