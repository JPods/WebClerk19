//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/04/08, 21:33:09
// ----------------------------------------------------
// Method: LineArraySize
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216(<>objAreaList; $objAreaListSizes)
C_OBJECT:C1216($objRec; $objSel)
C_COLLECTION:C1488($cArraySizes)
If (<>objAreaList=Null:C1517)
	$objSel:=ds:C1482.Default.query("primeDefault = 1")
	$objRec:=$objSel.first()
	$objAreaListSizes:=$objRec.obGeneral.AreaListSizes
	If ($objAreaListSizes=Null:C1517)
		$objRec.obGeneral.AreaListSizes:=New object:C1471
		
		$objRec.save()
	End if 
End if 

ARRAY LONGINT:C221(<>aeQuickQuote; 16)
<>aeQuickQuote{1}:=12  //T      --aLsDocType
<>aeQuickQuote{2}:=65  //Item Number--aLsItemNum
<>aeQuickQuote{3}:=250  //Description--aLsItemDesc
<>aeQuickQuote{4}:=51  //On Hand--aLsQtyOH
<>aeQuickQuote{5}:=51  //On S/O--aLsQtySO
<>aeQuickQuote{6}:=51  //On P/O--aLsQtyPO
<>aeQuickQuote{7}:=43  //Lead--aLsLeadTime
<>aeQuickQuote{8}:=47  //Disc Price--aLsDiscountPrice
<>aeQuickQuote{9}:=51  //Discount--aLsDiscount
<>aeQuickQuote{10}:=37  //Price--aLsPrice
<>aeQuickQuote{11}:=51  //Cost--aLsCost
<>aeQuickQuote{12}:=51  //Margin--aLSMargin
<>aeQuickQuote{13}:=50  //Dt--aLsDate
<>aeQuickQuote{14}:=50  //T1--aLsText1
<>aeQuickQuote{15}:=50  //T2--aLsText2
<>aeQuickQuote{16}:=50  //Rec--aLsSrRec

// --<>aeQuickQuote--16--50

ARRAY LONGINT:C221(<>aeListItems; 16)
<>aeListItems{1}:=12  //T   --  aLsDocType
<>aeListItems{2}:=106  //Item Number   --  aLsItemNum
<>aeListItems{3}:=298  //Description   --  aLsItemDesc  164
<>aeListItems{4}:=45  //On Hand   --  aLsQtyOH
<>aeListItems{5}:=45  //On S/O   --  aLsQtySO
<>aeListItems{6}:=45  //On P/O   --  aLsQtyPO
<>aeListItems{7}:=45  //Lead   --  aLsLeadTime
<>aeListItems{8}:=47  //Disc Price   --  aLsDiscountPrice
<>aeListItems{9}:=35  //Discount   --  aLsDiscount
<>aeListItems{10}:=47  //Price   --  aLsPrice
<>aeListItems{11}:=35  //Cost   --  aLsCost
<>aeListItems{12}:=51  //Margin   --  aLSMargin
<>aeListItems{13}:=51  //Dt   --  aLsDate
<>aeListItems{14}:=5  //T1   --  aLsText1
<>aeListItems{15}:=51  //T2   --  aLsText2
<>aeListItems{16}:=51  //Rec   --  aLsSrRec

ARRAY LONGINT:C221(<>aeOrdList; 45)
<>aeOrdList{1}:=129  //Item     aOItemNum
<>aeOrdList{2}:=5  //Alt     aOAltItem
<>aeOrdList{3}:=60  //Qty     aOQtyOrder
<>aeOrdList{4}:=36  //BLQ     aOQtyBL
<>aeOrdList{5}:=16  //x     aOLnCmplt
<>aeOrdList{6}:=5  //PrintThis     aOPrintThis
<>aeOrdList{7}:=174  //Description     aODescpt
<>aeOrdList{8}:=20  //P     aOPricePt
<>aeOrdList{9}:=66  //Unit Price     aOUnitPrice
<>aeOrdList{10}:=33  //Disc     aODiscnt
<>aeOrdList{11}:=66  //Disc Unit Price     aODscntUP
<>aeOrdList{12}:=97  //Ext Price     aOExtPrice
<>aeOrdList{13}:=50  //Seq     aOSeq
<>aeOrdList{14}:=50  //Taxable     aOTaxable
<>aeOrdList{15}:=50  //Tax     aOSaleTax
<>aeOrdList{16}:=50  //TaxCost     aOTaxCost
<>aeOrdList{17}:=50  //UnitMeas     aOUnitMeas
<>aeOrdList{18}:=50  //UnitWt     aOUnitWt
<>aeOrdList{19}:=50  //ExtWt     aOExtWt
<>aeOrdList{20}:=50  //Location     aOLocation
<>aeOrdList{21}:=50  //LocationBin     aoLocationBin
<>aeOrdList{22}:=50  //PQDIR     aOPQDIR
<>aeOrdList{23}:=50  //SerialRc     aOSerialRc
<>aeOrdList{24}:=50  //SerialNum     aOSerialNm
<>aeOrdList{25}:=50  //QtyShip     aOQtyShip
<>aeOrdList{26}:=50  //QtyOpen     aOQtyOpen
<>aeOrdList{27}:=50  //Produced By     aoProdBy
<>aeOrdList{28}:=50  //Comment     aoLnComment
<>aeOrdList{29}:=50  //Status     aoShipOrdSt
<>aeOrdList{30}:=50  //Profile1     aoProfile1
<>aeOrdList{31}:=50  //Profile2     aoProfile2
<>aeOrdList{32}:=50  //Profile3     aoProfile3
<>aeOrdList{33}:=50  //BackLog     aOBackLog
<>aeOrdList{34}:=50  //UnitCost     aOUnitCost
<>aeOrdList{35}:=50  //ExtCost     aOExtCost
<>aeOrdList{36}:=50  //SalesRate     aOSalesRate
<>aeOrdList{37}:=50  //SaleComm     aOSaleComm
<>aeOrdList{38}:=50  //RepRate     aORepRate
<>aeOrdList{39}:=50  //RepComm     aORepComm
<>aeOrdList{40}:=50  //DateReq     aODateReq
<>aeOrdList{41}:=50  //DateShipOn     aoDateShipOn
<>aeOrdList{42}:=50  //DateShip     aoDateShipped
<>aeOrdList{43}:=50  //LineNum     aOLineNum
<>aeOrdList{44}:=50  //LineRec     aoLineAction
<>aeOrdList{45}:=70  //UniqueID     aoUniqueID

ARRAY LONGINT:C221(<>aePOList; 45)
<>aePOList{1}:=91  //Item   --  aPoItemNum
<>aePOList{2}:=5  //Vendor Item Num   --  aPOVndrAlph
<>aePOList{3}:=63  //Qty   --  aPOQtyOrder
<>aePOList{4}:=5  //Chng   --  aPOQtyNow
<>aePOList{5}:=48  //Rec'd   --  aPOQtyRcvd
<>aePOList{6}:=5  //WH   --  aPoHoldQty
<>aePOList{7}:=16  //Cmpl   --  aPOLnCmplt
<>aePOList{8}:=198  //Description   --  aPODescpt
<>aePOList{9}:=73  //Unit Cost   --  aPOUnitCost
<>aePOList{10}:=33  //Disc   --  aPODiscnt
<>aePOList{11}:=66  //Disc Unit Cost   --  aPoDscntUP
<>aePOList{12}:=103  //Ext Cost   --  aPOExtCost
<>aePOList{13}:=50  //Seq   --  aPoSeq
<>aePOList{14}:=50  //Taxable   --  aPOTaxable
<>aePOList{15}:=50  //VATax   --  aPOVATax
<>aePOList{16}:=50  //Duties   --  aPoDuties
<>aePOList{17}:=50  //NonP Costs   --  aPoNPCosts
<>aePOList{18}:=50  //UnitMeas   --  aPOUnitMeas
<>aePOList{19}:=50  //PQBIR   --  aPoPQBIR
<>aePOList{20}:=50  //SerialRc   --  aPOSerialRc
<>aePOList{21}:=50  //SerialNm   --  aPOSerialNm
<>aePOList{22}:=50  //QtyBL   --  aPoQtyBL
<>aePOList{23}:=50  //BackLog   --  aPoBackLog
<>aePOList{24}:=50  //DateExp   --  aPODateExp
<>aePOList{25}:=50  //DateRcvd   --  aPODateRcvd
<>aePOList{26}:=50  //OrdRef   --  aPOOrdRef
<>aePOList{27}:=70  //CustRef   --  aPOCustRef
<>aePOList{28}:=50  //Comment   --  aPoLComment
<>aePOList{29}:=50  //SiteRef   --  aPoSiteRef
<>aePOList{30}:=50  //UnitWt   --  aPoUnitWt
<>aePOList{31}:=50  //Ext Wt   --  aPoExtWt
<>aePOList{32}:=50  //LineNum   --  aPOLineNum
<>aePOList{33}:=50  //LineRec   --  aPOLineAction
<>aePOList{34}:=60  //UniqueID   --  aPoUniqueID

ARRAY LONGINT:C221(<>aePPList; 40)
<>aePPList{1}:=130  //  Item -- aPItemNum
<>aePPList{2}:=5  //  Alt -- aPAltItem
<>aePPList{3}:=60  //  Qty -- aPQtyOrder
<>aePPList{4}:=5  //  PreQty -- aPQtyOpen
<>aePPList{5}:=18  //  Use -- aPUse
<>aePPList{6}:=5  //  PrintThis -- aPPrintThis
<>aePPList{7}:=202  //  Description -- aPDescpt
<>aePPList{8}:=21  //  P -- aPPricePt
<>aePPList{9}:=66  //  Unit Price -- aPUnitPrice
<>aePPList{10}:=33  //  Disc -- aPDiscnt
<>aePPList{11}:=66  //  Disc Unit Price -- aPDscntUP
<>aePPList{12}:=99  //  Ext Price -- aPExtPrice
<>aePPList{13}:=50  //  Seq -- aPSeq
<>aePPList{14}:=50  //  Taxable -- aPTaxable
<>aePPList{15}:=50  //  SaleTax -- aPSaleTax
<>aePPList{16}:=50  //  CostTax -- aPTaxCost
<>aePPList{17}:=50  //  UnitMeas -- aPUnitMeas
<>aePPList{18}:=50  //  UnitWt -- aPUnitWt
<>aePPList{19}:=50  //  ExtWt -- aPExtWt
<>aePPList{20}:=50  //  Location -- aPLocation
<>aePPList{21}:=50  //  LocationBin -- aPLocationBin
<>aePPList{22}:=50  //  PQDiR -- aPPQDiR
<>aePPList{23}:=50  //  Serial -- aPSerial
<>aePPList{24}:=50  //  LeadTime -- aPLeadTime
<>aePPList{25}:=50  //  QtyOrig -- aPQtyOriginal
<>aePPList{26}:=54  //  Expect -- aPDateExp
<>aePPList{27}:=50  //  Produced By -- aPProdBy
<>aePPList{28}:=50  //  Comment -- aPLnComment
<>aePPList{29}:=50  //  Profile1 -- aPProfile1
<>aePPList{30}:=50  //  Profile2 -- aPProfile2
<>aePPList{31}:=50  //  Profile3 -- aPProfile3
<>aePPList{32}:=50  //  UnitCost -- aPUnitCost
<>aePPList{33}:=50  //  ExtCost -- aPExtCost
<>aePPList{34}:=50  //  SalesRate -- aPSalesRate
<>aePPList{35}:=50  //  SaleComm -- aPSaleComm
<>aePPList{36}:=50  //  RepRate -- aPRepRate
<>aePPList{37}:=50  //  RepComm -- aPRepComm
<>aePPList{38}:=50  //  LineRec -- aPLineAction
<>aePPList{39}:=50  //  LineNum -- aPLineNum
<>aePPList{40}:=50  //  UniqueID -- aPUniqueID


ARRAY LONGINT:C221(<>aeInvoiceList; 41)
<>aeInvoiceList{1}:=129  //  Item -- aiItemNum
<>aeInvoiceList{2}:=5  //  Alt -- aiAltItem
<>aeInvoiceList{3}:=64  //  Ship -- aiQtyShip
<>aeInvoiceList{4}:=35  //  BL -- aiQtyBL
<>aeInvoiceList{5}:=5  //  PrintThis -- aiPrintThis
<>aeInvoiceList{6}:=202  //  Description -- aiDescpt
<>aeInvoiceList{7}:=19  //  P -- -- iPricePt
<>aeInvoiceList{8}:=63  //  Unit Price -- aiUnitPrice
<>aeInvoiceList{9}:=33  //  Disc -- aiDiscnt
<>aeInvoiceList{10}:=58  //  Disc Unit Price -- aiUnitPriceDiscounted
<>aeInvoiceList{11}:=96  //  Ext Price -- aiExtPrice
<>aeInvoiceList{12}:=50  //  Seq -- aiSeq
<>aeInvoiceList{13}:=50  //  Taxable -- aiTaxable
<>aeInvoiceList{14}:=50  //  SaleTax -- aiSaleTax
<>aeInvoiceList{15}:=50  //  TaxCost -- aiTaxCost
<>aeInvoiceList{16}:=50  //  UnitMeas -- aiUnitMeas
<>aeInvoiceList{17}:=50  //  UnitWt -- aiUnitWt
<>aeInvoiceList{18}:=50  //  ExtWt -- aiExtWt
<>aeInvoiceList{19}:=50  //  Location -- aiLocation
<>aeInvoiceList{20}:=50  //  LocationBin -- aiLocationBin
<>aeInvoiceList{21}:=50  //  PQDIR -- aiPQDIR
<>aeInvoiceList{22}:=50  //  Sr# Rec -- aiSerialRc
<>aeInvoiceList{23}:=50  //  SerialNum -- aiSerialNm
<>aeInvoiceList{24}:=50  //  QtyOrder -- aiQtyOrder
<>aeInvoiceList{25}:=50  //  QtyRemain -- aiQtyRemain
<>aeInvoiceList{26}:=50  //  QtyOpen -- aiQtyOpen
<>aeInvoiceList{27}:=50  //  Produced By -- aiProdBy
<>aeInvoiceList{28}:=50  //  Comment -- aiLnComment
<>aeInvoiceList{29}:=50  //  Profile1 -- aiProfile1
<>aeInvoiceList{30}:=50  //  Profile2 -- aiProfile2
<>aeInvoiceList{31}:=50  //  Profile3 -- aiProfile3
<>aeInvoiceList{32}:=50  //  UnitCost -- aiUnitCost
<>aeInvoiceList{33}:=50  //  ExtCost -- aiExtCost
<>aeInvoiceList{34}:=50  //  SalesRate -- aiSalesRate
<>aeInvoiceList{35}:=50  //  SaleComm -- aiSaleComm
<>aeInvoiceList{36}:=50  //  RepRate -- aiRepRate
<>aeInvoiceList{37}:=50  //  RepComm -- aiRepComm
<>aeInvoiceList{38}:=50  //  LineNum -- aiLineNum
<>aeInvoiceList{39}:=50  //  LineRec -- aiLineAction
<>aeInvoiceList{40}:=50  //  LnUniqueID -- aiLnUnique
<>aeInvoiceList{41}:=50  //  LnOrdUniqueID -- aiLnOrdUnique
