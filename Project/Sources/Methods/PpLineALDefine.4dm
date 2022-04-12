//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-04-02T00:00:00, 15:08:57
// ----------------------------------------------------
// Method: PpLineALDefine
// Description
// Modified: 04/02/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($error; $columnCnt; $grp1; $grpCnt1; $grp2; $grpCnt2; $grp3; $grpCnt3)
C_LONGINT:C283($areaList)
$areaList:=ePropList
$grp1:=1  //starting array
$grpCnt1:=12  //count of arrays
$grp2:=$grp1+$grpCnt1  //9
$grpCnt2:=14
$grp3:=$grp2+$grpCnt2  //21
$grpCnt3:=14
// -- $error:=AL_SetArraysNam(ePropList; $grp1; $grpCnt1; "aPItemNum"; "aPAltItem"; "aPQtyOrder"; "aPQtyOpen"; "aPUse"; "aPPrintThis"; "aPDescpt"; "aPPricePt"; "aPUnitPrice"; "aPDiscnt"; "aPDscntUP"; "aPExtPrice")
// -- $error:=AL_SetArraysNam(ePropList; $grp2; $grpCnt2; "aPSeq"; "aPTaxable"; "aPSaleTax"; "aPTaxCost"; "aPUnitMeas"; "aPUnitWt"; "aPExtWt"; "aPLocation"; "aPLocationBin"; "aPPQDiR"; "aPSerial"; "aPLeadTime"; "aPQtyOriginal"; "aPDateExp")
// -- $error:=AL_SetArraysNam(ePropList; $grp3; $grpCnt3; "aPProdBy"; "aPLnComment"; "aPProfile1"; "aPProfile2"; "aPProfile3"; "aPUnitCost"; "aPExtCost"; "aPSalesRate"; "aPSaleComm"; "aPRepRate"; "aPRepComm"; "aPLineAction"; "aPLineNum"; "aPUniqueID")
// -- AL_SetHeaders(ePropList; $grp1; $grpCnt1; "Item"; "Alt"; "Qty"; "PreQty"; "Use"; "PrintThis"; "Description"; "P"; "Unit Price"; "Disc"; "Disc Price"; "Ext Price")
// -- AL_SetHeaders(ePropList; $grp2; $grpCnt2; "Seq"; "Taxable"; "SaleTax"; "CostTax"; "UnitMeas"; "UnitWt"; "ExtWt"; "Location"; "LocationBin"; "PQDiR"; "Serial"; "LeadTime"; "QtyOrig"; "Expect")
// -- AL_SetHeaders(ePropList; $grp3; $grpCnt3; "Produced By"; "Comment"; "Profile1"; "Profile2"; "Profile3"; "UnitCost"; "ExtCost"; "SalesRate"; "SaleComm"; "RepRate"; "RepComm"; "LineAction"; "LineNum"; "idNum")
C_LONGINT:C283($discountPriceWidth; $basePriceWidth)

// -- AL_SetWidths(ePropList; $grp1; $grpCnt1; <>aePPList{1}; <>aePPList{2}; <>aePPList{3}; <>aePPList{4}; <>aePPList{5}; <>aePPList{6}; <>aePPList{7}; <>aePPList{8}; <>aePPList{9}; <>aePPList{10}; <>aePPList{11}; <>aePPList{12})
// -- AL_SetWidths(ePropList; $grp2; $grpCnt2; <>aePPList{13}; <>aePPList{14}; <>aePPList{15}; <>aePPList{16}; <>aePPList{17}; <>aePPList{18}; <>aePPList{19}; <>aePPList{20}; <>aePPList{21}; <>aePPList{22}; <>aePPList{23}; <>aePPList{24}; <>aePPList{25}; <>aePPList{26})
// -- AL_SetWidths(ePropList; $grp3; $grpCnt3; <>aePPList{27}; <>aePPList{28}; <>aePPList{29}; <>aePPList{30}; <>aePPList{31}; <>aePPList{32}; <>aePPList{33}; <>aePPList{34}; <>aePPList{35}; <>aePPList{36}; <>aePPList{37}; <>aePPList{38}; <>aePPList{39}; <>aePPList{40})


// -- AL_SetHdrStyle(ePropList; 0; "Arial"; 9; 0)
// -- AL_SetHdrStyle(ePropList; 1; "Arial"; 9; 1)  //Item Number
// -- AL_SetHdrStyle(ePropList; 10; "Arial"; 9; 2)  //Extd Price
// -- AL_SetStyle(ePropList; 0; "Arial"; 12; 0)



// // -- AL_SetRowOpts (ePropList;1;1;1;0;1)
AlpSetRowsOpts($areaList; 1; 1; 6; 1; 1)  // 0;0)  //accept drag
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
$doChange:=UserInPassWordGroup("Costing")
$columnCnt:=Num:C11(Not:C34($doChange))*$grpCnt3
//
// -- AL_SetColOpts(ePropList; 1; 0; 1; $columnCnt; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts(ePropList; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts(ePropList; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks(ePropList; ""; "")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetMiscOpts(ePropList; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters

//
// -- AL_SetDividers(ePropList; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetFormat(ePropList; 3; "###,###,###.###"; 0; 0)  //Qty
// -- AL_SetFormat(ePropList; 4; "###,###,###.###"; 0; 0)  //Qty
// -- AL_SetFormat(ePropList; 5; ""; 1; 0)  //Use
// -- AL_SetFormat(ePropList; 9; <>tcFormatUP; 0; 0)  //Unit price
// -- AL_SetFormat(ePropList; 10; "##0.0"; 0; 0)  //Disc
// -- AL_SetFormat(ePropList; 11; <>tcFormatUP; 0; 0)  //Unit price
// -- AL_SetFormat(ePropList; 12; <>tcFormatTt; 0; 0)  //Disc Unit Price
// -- AL_SetFormat(ePropList; 26; "1"; 0; 0)  //date
// -- AL_SetColLock(ePropList; 2)  //Lock after Alt Item
// -- AL_SetSort(ePropList; 13)  //Seq



QQSetColor(ePropList; ->aPItemNum)

//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)