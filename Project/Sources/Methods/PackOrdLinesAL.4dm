//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PackOrdLinesAL
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($1)
C_LONGINT:C283($error; $grp1; $grpCnt1; $grp2; $grpCnt2; $grp3; $grpCnt3)
//
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
		// -- $error:=AL_SetArraysNam($theArea; 1; 15; "aOQtyPack"; "aOQtyBL"; "aOItemNum"; "aOAltItem"; "aODescpt"; "aOSeq"; "aOUnitMeas"; "aOLocation"; "aOQtyShip"; "aOUnitWt"; "aOQtyOrder"; "aOQtyOpen"; "aOLineNum"; "aoLineAction"; "aoLnUniqueID")
		// -- $error:=AL_SetArraysNam($theArea; 16; 1; "aODscntUP")
		If (False:C215)
			// -- $error:=AL_SetArraysNam($theArea; 17; 15; "aOBackLog"; "aoDateShipOn"; "aODateReq"; "aoDateShipped"; "aODiscnt"; "aOExtCost"; "aOExtPrice"; "aOExtWt"; "aOLnCmplt"; "aoLnComment"; "aOPQDIR"; "aOPricePt"; "aoProdBy"; "aoProfile1"; "aoProfile2")
			// -- $error:=AL_SetArraysNam($theArea; 32; 15; "aoProfile3"; "aORepComm"; "aORepRate"; "aOSaleComm"; "aOSalesRate"; "aOSaleTax"; "aOSeq"; "aOSerialNm"; "aOSerialRc"; "aOTaxable"; "aoUniqueID"; "aOUnitCost"; "aOUnitMeas"; "aOUnitPrice"; "aOUnitWt")
		End if 
		//
		// -- AL_SetHeaders($theArea; 1; 15; "Packed"; "BLQ"; "Item"; "Alt"; "Description"; "Seq"; "UnitMeas"; "Location"; "QtyShip"; "UnitWt"; "Qty"; "QtyOpen"; "LineNum"; "LineAction"; "idNum")  //Access to Cost Group
		// -- AL_SetHeaders($theArea; 16; 1; "UnitPrice")
		If (False:C215)
			// -- AL_SetHeaders($theArea; 17; 15; "aOBackLog"; "aoDateShipOn"; "aODateReq"; "aoDateShipped"; "aODiscnt"; "aOExtCost"; "aOExtPrice"; "aOExtWt"; "aOLnCmplt"; "aoLnComment"; "aOPQDIR"; "aOPricePt"; "aoProdBy"; "aoProfile1"; "aoProfile2")
			// -- AL_SetHeaders($theArea; 32; 15; "aoProfile3"; "aORepComm"; "aORepRate"; "aOSaleComm"; "aOSalesRate"; "aOSaleTax"; "aOSeq"; "aOSerialNm"; "aOSerialRc"; "aOTaxable"; "aoUniqueID"; "aOUnitCost"; "aOUnitMeas"; "aOUnitPrice"; "aOUnitWt")
		End if 
		
		// -- AL_SetWidths($theArea; 1; 15; 73; 73; 140; 3; 140; 20; 40; 40; 40; 40; 40; 40; 70; 70; 70)
		// -- AL_SetWidths($theArea; 16; 1; 70)
		If (False:C215)
			// -- AL_SetWidths($theArea; 17; 15; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10)
			// -- AL_SetWidths($theArea; 32; 15; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10; 10)
		End if 
		//
		// -- AL_SetRowOpts($theArea; 1; 1; 1; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		//$doChange:=User in group(Current user;"Costing")
		//$columnCnt:=Num(not($doChange))*8
		// -- AL_SetColOpts($theArea; 1; 0; 1; 1; <>viPixel)  //$columnCnt;*viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		//// -- AL_SetEntryOpts ($theArea;1;0;0)
		// -- AL_SetEntryOpts($theArea; 1; 1; 1; 1)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		
		
		//// -- AL_SetEnterable ($theArea;1;1)
		
		// -- AL_SetSortOpts($theArea; 0; 0; 0; ""; 0; 0)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		//// -- AL_SetCallbacks ($theArea;"ShipCallBack";"")
		//Name; GP at entry; Function true or false if keep changes
		//// -- AL_SetSort ($theArea;8)//Location
		// -- AL_SetColLock($theArea; 3)  //Lock after Alt Item Num
		// -- AL_SetMiscOpts($theArea; 0; 1; "\\"; 0)
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		
		// -- AL_SetDividers($theArea; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetStyle($theArea; 0; $fontName; $fontSize; 0)
		// -- AL_SetHdrStyle($theArea; 0; $fontName; $fontSize; 0)
		
		// -- AL_SetFormat($theArea; 1; vsCountFormat; 0; 0)  //Qty
		// -- AL_SetFormat($theArea; 2; vsCountFormat; 0; 0)  //Qty
		// -- AL_SetFormat($theArea; 9; vsCountFormat; 0; 0)  //Qty
		// -- AL_SetFormat($theArea; 11; vsCountFormat; 0; 0)  //Qty
		// -- AL_SetFormat($theArea; 12; vsCountFormat; 0; 0)  //Qty
		
	Else 
		// -- $error:=AL_SetArraysNam($theArea; 1; 15; "aOQtyPack"; "aOQtyBL"; "aOItemNum"; "aOAltItem"; "aODescpt"; "aOSeq"; "aOUnitMeas"; "aOLocation"; "aOQtyShip"; "aOQtyOrder"; "aOQtyOpen"; "aOLineNum"; "aoLineAction"; "aoLnUniqueID"; "aODscntUP")
		//
		
		// -- AL_SetHeaders($theArea; 1; 15; "Packed"; "BLQ"; "Item"; "Alt"; "Description"; "Seq"; "UnitMeas"; "Location"; "QtyShip"; "Qty"; "QtyOpen"; "LineNum"; "LineAction"; "idNum"; "UnitPrice")  //Access to Cost Group
		
		// -- AL_SetWidths($theArea; 1; 15; 73; 73; 140; 3; 140; 20; 40; 40; 40; 40; 40; 70; 70; 70; 70)
		//
		// -- AL_SetRowOpts($theArea; 1; 1; 1; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		//$columnCnt:=Num(Error#0)*8
		// -- AL_SetColOpts($theArea; 1; 0; 1; 1; <>viPixel)  //$columnCnt;*viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		//// -- AL_SetEntryOpts ($theArea;1;0;0)
		// -- AL_SetEntryOpts($theArea; 1; 1; 1; 1)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		
		
		//// -- AL_SetEnterable ($theArea;1;1)
		
		// -- AL_SetSortOpts($theArea; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		//// -- AL_SetCallbacks ($theArea;"ShipCallBack";"")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetSort($theArea; 8)  //Location
		// -- AL_SetColLock($theArea; 3)  //Lock after Alt Item Num
		// -- AL_SetMiscOpts($theArea; 0; 1; "\\"; 0)
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		
		// -- AL_SetDividers($theArea; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetStyle($theArea; 0; $fontName; $fontSize; 0)
		// -- AL_SetHdrStyle($theArea; 0; $fontName; $fontSize; 0)
		//
		
		
		//// -- AL_SetFormat ($theArea;3;"###,###,###.###";0;0)//Qty
		//// -- AL_SetFormat ($theArea;4;"###,###,###.###";0;0)//BLQ
		//// -- AL_SetFormat ($theArea;8;<>tcFormatUP;0;0)//Unit Price
		//// -- AL_SetFormat ($theArea;9;"##0.0";0;0)//Disc
		//// -- AL_SetFormat ($theArea;10;<>tcFormatUP;0;0)//Disc Unit Price
		//// -- AL_SetFormat ($theArea;11;<>tcFormatTt;0;0)//Extd Price
		//// -- AL_SetFormat ($theArea;18;"###,###,###";0;0)//Location
		//// -- AL_SetFormat ($theArea;35;"1";0;0)//date
		//// -- AL_SetFormat ($theArea;36;"1";0;0)//date
		//// -- AL_SetFormat ($theArea;37;"1";0;0)//date
		//// -- AL_SetEnterable ($theArea;1;1)
End case 