//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/31/12, 15:33:52
// ----------------------------------------------------
// Method: OrdLineALDefine
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $areaList)
$areaList:=$1
C_LONGINT:C283($error; $grp1; $grpCnt1; $grp2; $grpCnt2; $grp3; $grpCnt3)
$grp1:=1  //starting array
$grpCnt1:=15  //count of arrays
$grp2:=$grp1+$grpCnt1  //11
$grpCnt2:=15
$grp3:=$grp2+$grpCnt2  //27
$grpCnt3:=15
// -- $error:=AL_SetArraysNam($areaList; $grp1; $grpCnt1; "aOItemNum"; "aOAltItem"; "aOQtyOrder"; "aOQtyBL"; "aOLnCmplt"; "aOPrintThis"; "aODescpt"; "aOPricePt"; "aOUnitPrice"; "aODiscnt"; "aODscntUP"; "aOExtPrice"; "aOSeq"; "aOTaxable"; "aOSaleTax")
// -- $error:=AL_SetArraysNam($areaList; $grp2; $grpCnt2; "aOTaxCost"; "aOUnitMeas"; "aOUnitWt"; "aOExtWt"; "aOLocation"; "aoLocationBin"; "aOPQDIR"; "aOSerialRc"; "aOSerialNm"; "aOQtyShip"; "aOQtyOpen"; "aoProdBy"; "aoLnComment"; "aoShipOrdSt"; "aoProfile1")
// -- $error:=AL_SetArraysNam($areaList; $grp3; $grpCnt3; "aoProfile2"; "aoProfile3"; "aOBackLog"; "aOUnitCost"; "aOExtCost"; "aOSalesRate"; "aOSaleComm"; "aORepRate"; "aORepComm"; "aODateReq"; "aoDateShipOn"; "aoDateShipped"; "aOLineNum"; "aoLineAction"; "aoUniqueID")
//
//size arrays are set in
//LineArraySize
//
// -- AL_SetHeaders($areaList; $grp1; $grpCnt1; "Item"; "Alt"; "Qty"; "BLQ"; "x"; "PrintThis"; "Description"; "P"; "Unit Price"; "Disc"; "Disc Price"; "Ext Price"; "Seq"; "Taxable"; "Tax")
// -- AL_SetHeaders($areaList; $grp2; $grpCnt2; "TaxCost"; "UnitMeas"; "UnitWt"; "ExtWt"; "Location"; "LocationBin"; "PQDIR"; "SerialRc"; "SerialNum"; "QtyShip"; "QtyOpen"; "Produced By"; "Comment"; "Status"; "Profile1")  //Access to all
// -- AL_SetHeaders($areaList; $grp3; $grpCnt3; "Profile2"; "Profile3"; "BackLog"; "UnitCost"; "ExtCost"; "SalesRate"; "SaleComm"; "RepRate"; "RepComm"; "DateReq"; "ShipOn"; "DateShip"; "LineNum"; "LineAction"; "idNum")  //Access to Cost Group
C_LONGINT:C283($discountPriceWidth; $basePriceWidth)

// -- AL_SetWidths($areaList; $grp1; $grpCnt1; <>aeOrdList{1}; <>aeOrdList{2}; <>aeOrdList{3}; <>aeOrdList{4}; <>aeOrdList{5}; <>aeOrdList{6}; <>aeOrdList{7}; <>aeOrdList{8}; <>aeOrdList{9}; <>aeOrdList{10}; <>aeOrdList{11}; <>aeOrdList{12}; <>aeOrdList{13}; <>aeOrdList{14}; <>aeOrdList{15})
// -- AL_SetWidths($areaList; $grp2; $grpCnt2; <>aeOrdList{16}; <>aeOrdList{17}; <>aeOrdList{18}; <>aeOrdList{19}; <>aeOrdList{20}; <>aeOrdList{21}; <>aeOrdList{22}; <>aeOrdList{23}; <>aeOrdList{24}; <>aeOrdList{25}; <>aeOrdList{26}; <>aeOrdList{27}; <>aeOrdList{28}; <>aeOrdList{29}; <>aeOrdList{30})
// -- AL_SetWidths($areaList; $grp3; $grpCnt3; <>aeOrdList{31}; <>aeOrdList{32}; <>aeOrdList{33}; <>aeOrdList{34}; <>aeOrdList{35}; <>aeOrdList{36}; <>aeOrdList{37}; <>aeOrdList{38}; <>aeOrdList{39}; <>aeOrdList{40}; <>aeOrdList{41}; <>aeOrdList{42}; <>aeOrdList{43}; <>aeOrdList{44}; <>aeOrdList{45})



//
// -- AL_SetStyle($areaList; 0; "Arial"; 12; 0)
// -- AL_SetHdrStyle($areaList; 0; "Arial"; 9; 0)
// -- AL_SetHdrStyle($areaList; 1; "Arial"; 9; 1)  //Item Number
// -- AL_SetHdrStyle($areaList; 10; "Arial"; 9; 2)  //Ext Price
//// -- AL_SetEnterable ($areaList;1;1)




// -- AL_SetDividers($areaList; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetFormat($areaList; 3; "###,###,###.###"; 0; 0)  //Qty
// -- AL_SetFormat($areaList; 4; "###,###,###.###"; 0; 0)  //BLQ
// -- AL_SetFormat($areaList; 9; <>tcFormatUP; 0; 0)  //Unit Price
// -- AL_SetFormat($areaList; 10; "##0.0"; 0; 0)  //Disc
// -- AL_SetFormat($areaList; 11; <>tcFormatUP; 0; 0)  //Disc Unit Price
// -- AL_SetFormat($areaList; 12; <>tcFormatTt; 0; 0)  //Extd Price
// -- AL_SetFormat($areaList; 20; "###,###,###"; 0; 0)  //Location
// -- AL_SetFormat($areaList; 40; "1"; 0; 0)  //date
// -- AL_SetFormat($areaList; 41; "1"; 0; 0)  //date
// -- AL_SetFormat($areaList; 42; "1"; 0; 0)  //date

//// -- AL_SetRowOpts ($areaList;1;1;1;0;1)
//// -- AL_SetRowOpts (Self->;0;1;6;1;1) 

AlpSetRowsOpts($areaList; 1; 1; 6; 1; 1)  // 0;0)  //accept drag
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
//$doChange:=User in group(Current user;"Costing")
//$columnCnt:=Num(not($doChange))*8
// -- AL_SetColOpts($areaList; 1; 0; 1; 0; <>viPixel)  //$columnCnt;*viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($areaList; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($areaList; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// // -- AL_SetCallbacks ($areaList;"";"")
//Name; GP at entry; Function true or false if keep changes
// Put in AL directly
// // -- AL_SetAreaTextProperty ($areaList;ALP_Area_CallbackMethOnEvent;"ALOrderLinesCallBack")
// // -- AL_SetAreaLongProperty ($areaList;ALP_Area_Compatibility;0)
//eOrdList

// -- AL_SetSort($areaList; 13)  //Seq
// -- AL_SetColLock($areaList; 2)  //Lock after Alt Item Num
// -- AL_SetMiscOpts($areaList; 0; 1; "\\"; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters

$doChange:=(UserInPassWordGroup("ViewCommission"))

If ((Not:C34($doChange)) & (Current user:C182#[Order:3]salesNameID:10))
	// -- AL_SetForeClr($areaList; 32; "white"; 0; "white"; 0; "white"; 0)  //Sales Rate
	// -- AL_SetForeClr($areaList; 33; "white"; 0; "white"; 0; "white"; 0)  //Sales Commission
End if 
If ((Not:C34($doChange)) & (Current user:C182#[Order:3]repID:8))
	// -- AL_SetForeClr($areaList; 34; "white"; 0; "white"; 0; "white"; 0)  //Rep Rate
	// -- AL_SetForeClr($areaList; 35; "white"; 0; "white"; 0; "white"; 0)  //Rep Commission
End if 

//  // -- AL_SetAreaTextProperty ($areaList;ALP_Area_DragSrcRowCodes;"drag")  // set source access code
//  // -- AL_SetAreaTextProperty ($areaList;ALP_Area_DragDstRowCodes;"drag")  // set destination access code
//  // -- AL_SetAreaLongProperty ($areaList;ALP_Area_DragRowMultiple;1)  // multiple rows dragging
// // -- AL_SetAreaLongProperty ($areaList;ALP_Area_DragRowOnto;0) // Between rows (disable On row)


//  --  CHOPPED  AL_UpdateArrays($areaList; -2)
