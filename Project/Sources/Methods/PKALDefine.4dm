//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PKALDefine
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 


C_LONGINT:C283($1; $theArea)
C_TEXT:C284($fontName; $2)
C_LONGINT:C283($3; $4; $fontSize; $styleLayout)
If (Count parameters:C259<3)
	$theArea:=eLoadList
	$fontName:="Geneva"
	$fontSize:=9
	$styleLayout:=0
Else 
	$theArea:=$1
	$fontName:=$2
	$fontSize:=$3
	$styleLayout:=$4
End if 

Case of 
	: ($styleLayout=2)
		// -- $error:=AL_SetArraysNam($1; 1; 10; "aPKUniqueID"; "aPKContainerType"; "aPKUniqueIDSuperior"; "aPKtrackID"; "aPKStatus"; "aPKCarrierID"; "aPKWeightExtended"; "aPKValue"; "aPKInsuranceID")
		// -- $error:=AL_SetArraysNam($1; 10; 10; "aPKDTShipOn"; "aPKDTReceiveExpected"; "aPKDTAssembly"; "aPKDTCustoms"; "aPKTagComments"; "aPKTagOptions"; "aPKCustomerVendorID"; "aPKdocumentID"; "aPKTransactionType"; "aPKInvoiceNum")
		// -- AL_SetHeaders($1; 1; 10; "idNum"; "ContainerType"; "IDSuperior"; "trackID"; "Status"; "CarrierID"; "WeightExtended"; "Value"; "InsuranceID")
		// -- AL_SetHeaders($1; 10; 10; "DTShipOn"; "DTReceiveExpected"; "DTAssembly"; "DTCustoms"; "TagComments"; "TagOptions"; "CustomerVendorID"; "documentID"; "TransactionType"; "InvoiceNum")
		// -- AL_SetWidths($1; 1; 10; 60; 34; 34; 60; 88; 73; 73; 73; 52)
		// -- AL_SetWidths($1; 10; 10; 55; 73; 21; 21; 21; 21; 73; 52; 110; 100)
		//
		// -- AL_SetRowOpts($1; 1; 1; 1; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts($1; 1; 1; 1)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
		//Name; SortInDuring; UserSort; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks($1; ""; "")
		//Name; GP at entry; Function true or false if keep changes
		//// -- AL_SetSort ($1;3;1)    
		// -- AL_SetFormat($1; 1; ""; 3; 0)
		// -- AL_SetFormat($1; 2; ""; 3; 2)
		// -- AL_SetFormat($1; 6; ""; 3; 0)
		//
		// -- AL_SetHdrStyle($1; 0; $2; $3; 0)
		// -- AL_SetStyle($1; 0; $2; $3; 0)
		// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
		//
		// -- AL_SetScroll($1; 1; 1)
		// -- AL_SetSelect($1; aShipSel)
		
	: ($styleLayout=3)  //###_jwm_New Area List Layout ###
		// -- $error:=AL_SetArraysNam($1; 1; 11; "aPKdocumentID"; "aPKUniqueID"; "aPKContainerType"; "aPKUniqueIDSuperior"; "aPKtrackID"; "aPKStatus"; "aPKCarrierID"; "aPKWeightExtended"; "aPKValue"; "aPKInsuranceID")
		// -- $error:=AL_SetArraysNam($1; 11; 10; "aPKDTShipOn"; "aPKDTReceiveExpected"; "aPKDTAssembly"; "aPKDTCustoms"; "aPKTagComments"; "aPKTagOptions"; "aPKCustomerVendorID"; "aPKTransactionType"; "aPKInvoiceNum")
		// -- AL_SetHeaders($1; 1; 11; "documentID"; "idNum"; "ContainerType"; "IDSuperior"; "trackID"; "Status"; "CarrierID"; "WeightExtended"; "Value"; "InsuranceID")
		// -- AL_SetHeaders($1; 11; 10; "DTShipOn"; "DTReceiveExpected"; "DTAssembly"; "DTCustoms"; "TagComments"; "TagOptions"; "CustomerVendorID"; "TransactionType"; "InvoiceNum")
		// -- AL_SetWidths($1; 1; 11; 60; 60; 18; 60; 70; 73; 90; 73; 73; 52)
		// -- AL_SetWidths($1; 11; 10; 55; 73; 21; 21; 21; 21; 73; 110; 100)
		//
		// -- AL_SetRowOpts($1; 1; 1; 1; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts($1; 1; 1; 1)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
		//Name; SortInDuring; UserSort; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks($1; ""; "")
		//Name; GP at entry; Function true or false if keep changes
		//// -- AL_SetSort ($1;3;1)    
		
		//// -- AL_SetFormat ($1;1;"";3;0)
		//// -- AL_SetFormat ($1;2;"";3;2)
		//// -- AL_SetFormat ($1;6;"";3;0)
		//
		// -- AL_SetHdrStyle($1; 0; $2; $3; 0)
		// -- AL_SetStyle($1; 0; $2; $3; 0)
		// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
		//
		// -- AL_SetScroll($1; 1; 1)
		// -- AL_SetSelect($1; aShipSel)
		
	Else 
		// -- $error:=AL_SetArraysNam($1; 1; 9; "aPKUniqueID"; "aPKContainerType"; "aPKUniqueIDSuperior"; "aPKtrackID"; "aPKStatus"; "aPKCarrierID"; "aPKWeightExtended"; "aPKValue"; "aPKInsuranceID")
		// -- $error:=AL_SetArraysNam($1; 10; 10; "aaPKDTShipOn"; "aPKDTReceiveExpected"; "aPKDTAssembly"; "aPKDTCustoms"; "aPKTagComments"; "aPKTagOptions"; "aPKCustomerVendorID"; "aPKdocumentID"; "aPKTransactionType"; "aPKInvoiceNum")
		// -- AL_SetHeaders($1; 1; 9; "idNum"; "ContainerType"; "IDSuperior"; "trackID"; "Status"; "CarrierID"; "WeightExtended"; "Value"; "InsuranceID")
		// -- AL_SetHeaders($1; 10; 10; "aDTShipOn"; "DTReceiveExpected"; "DTAssembly"; "DTCustoms"; "TagComments"; "TagOptions"; "CustomerVendorID"; "documentID"; "TransactionType"; "InvoiceNum")
		// -- AL_SetWidths($1; 1; 9; 55; 73; 21; 21; 21; 21; 73; 52; 110)
		// -- AL_SetWidths($1; 10; 9; 55; 73; 21; 21; 21; 21; 73; 52; 110)
		//
		// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts($1; 0; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
		//Name; SortInDuring; UserSort; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks($1; ""; "")
		//Name; GP at entry; Function true or false if keep changes
		//// -- AL_SetSort ($1;3;1)    
		// -- AL_SetFormat($1; 1; ""; 3; 0)
		// -- AL_SetFormat($1; 2; ""; 3; 2)
		// -- AL_SetFormat($1; 6; ""; 3; 0)
		//
		// -- AL_SetHdrStyle($1; 0; $2; $3; 0)
		// -- AL_SetStyle($1; 0; $2; $3; 0)
		// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
		//
		// -- AL_SetScroll($1; 1; 1)
		// -- AL_SetSelect($1; aShipSel)
		
End case 