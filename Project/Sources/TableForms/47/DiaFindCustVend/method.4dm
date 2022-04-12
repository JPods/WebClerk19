Case of 
	: (Before:C29)
		REDUCE SELECTION:C351([Customer:2]; 0)
		REDUCE SELECTION:C351([Vendor:38]; 0)
		OBJECT SET ENABLED:C1123(bSerialVend; False:C215)
		OBJECT SET ENABLED:C1123(bSerialCust; False:C215)
		OBJECT SET ENABLED:C1123(bSerialOrd; False:C215)
		ARRAY TEXT:C222(aSrlItemSr; 0)
		ARRAY LONGINT:C221(aSrlRecNum; 0)
		ARRAY LONGINT:C221(aSrlRecNum; 0)
		FillCustArray
		doSearch:=0
		// -- $error:=AL_SetArraysNam(eCustList; 1; 9; "aCustType"; "aCustomers"; "aCustAttn"; "aCustPhone"; "aCustZip"; "aCustCity"; "aCustRep"; "aCustCodes"; "aRecNum")
		// -- AL_SetHeaders(eCustList; 1; 8; "T"; "Customer"; "Attn"; "Phone"; "Zip"; "City"; "Rep"; "Acct")
		// -- AL_SetWidths(eCustList; 1; 8; 12; 100; 82; 76; 37; 53; 24; 70)
		//
		// -- AL_SetRowOpts(eCustList; 1; 1; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eCustList; 1; 0; 1; 1; 0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eCustList; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eCustList; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eCustList; ""; "")
		//Name; GP at entry; Function true or false if keep changes       
		// -- AL_SetHdrStyle(eCustList; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle(eCustList; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eCustList; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetSort(eCustList; 2)
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		
		If (doSearch=1)
			If (aText1>0)
				GOTO RECORD:C242([ItemSerial:47]; aSrlRecNum{aText1})
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[ItemSerial:47]customerID:9)
				QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[ItemSerial:47]vendorID:5)
				vClaim:=[ItemSerial:47]claimCosts:22
				doSearch:=0
			Else 
				REDUCE SELECTION:C351([Customer:2]; 0)
				REDUCE SELECTION:C351([Vendor:38]; 0)
				REDUCE SELECTION:C351([Lead:48]; 0)
			End if 
			FillCustArray
			//  --  CHOPPED  AL_UpdateArrays(eCustList; -2)
			// -- AL_SetSort(eCustList; 2)
		End if 
		If (Records in selection:C76([Customer:2])>0)
			OBJECT SET ENABLED:C1123(bSerialCust; True:C214)
			OBJECT SET ENABLED:C1123(bSerialOrd; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(bSerialCust; False:C215)
			OBJECT SET ENABLED:C1123(bSerialOrd; False:C215)
		End if 
		If (Records in selection:C76([Vendor:38])>0)
			OBJECT SET ENABLED:C1123(bSerialVend; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(bSerialVend; False:C215)
		End if 
		If (Records in selection:C76([ItemSerial:47])>0)
			OBJECT SET ENABLED:C1123(bSerialRec; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(bSerialRec; False:C215)
		End if 
End case 