//%attributes = {"publishedWeb":true}
//PpLnInitRays
C_LONGINT:C283($k)
$k:=0
ARRAY LONGINT:C221(aPLineAction; $k)
ARRAY TEXT:C222(aPUse; $k)
ARRAY LONGINT:C221(aPPQDiR; $k)
//
ARRAY LONGINT:C221(aliRefID1; $k)  ////PrpLine]ProposalKey
ARRAY TEXT:C222(aStr20Ref1; $k)  ////PrpLine]Status
ARRAY LONGINT:C221(aintRef1; $k)  ////PrpLine]Probability
ARRAY BOOLEAN:C223(aPBooUse; $k)  ////PrpLine]Use
ARRAY TEXT:C222(aPItemNum; $k)  ////PrpLine]ItemNum
ARRAY TEXT:C222(aPAltItem; $k)  ////PrpLine]ItemNum
ARRAY REAL:C219(aPQtyOrder; $k)  ////PrpLine]Qty
ARRAY TEXT:C222(aPDescpt; $k)  ////PrpLine]Description
ARRAY REAL:C219(aPUnitPrice; $k)  ////PrpLine]UnitPrice
ARRAY REAL:C219(aPDiscnt; $k)  ////PrpLine]PriceDisount
ARRAY REAL:C219(aPDscntUP; $k)
ARRAY REAL:C219(aPExtPrice; $k)  ////PrpLine]ExtendedPrice
ARRAY TEXT:C222(aPTaxable; $k)  ////PrpLine]SaleTaxable
ARRAY REAL:C219(aPSaleTax; $k)  ////PrpLine]SalesTax
ARRAY REAL:C219(aPTaxCost; $k)  ////PrpLine]SalesTax

ARRAY REAL:C219(aPUnitWt; $k)  ////PrpLine]UnitWeight
ARRAY REAL:C219(aPExtWt; $k)  ////PrpLine]ExtendedWt
ARRAY REAL:C219(aPUnitCost; $k)  ////PrpLine]UnitCost
ARRAY REAL:C219(aPExtCost; $k)  ////PrpLine]ExtendedCost
ARRAY REAL:C219(aPRepRate; $k)  ////PrpLine]CommRateRep
ARRAY REAL:C219(aPRepComm; $k)  ////PrpLine]CommRep
ARRAY REAL:C219(aPSalesRate; $k)  ////PrpLine]CommRateSales
ARRAY REAL:C219(aPSaleComm; $k)  ////PrpLine]CommSales
ARRAY LONGINT:C221(aPLeadTime; $k)  ////PrpLine]Leadtime
ARRAY LONGINT:C221(aPLocation; $k)  ////PrpLine]Location
ARRAY TEXT:C222(aPUnitMeas; $k)  ////PrpLine]SaleUnitofMeas
ARRAY LONGINT:C221(aPSerial; $k)  ////PrpLine]Serialized
ARRAY TEXT:C222(aPPricePt; $k)  ////PrpLine]PricePoint
ARRAY LONGINT:C221(aPSeq; $k)  ////PrpLine]Sequence
ARRAY DATE:C224(aPDateExp; $k)  //[PrpLine]DateExpected
ARRAY LONGINT:C221(aPLineNum; $k)
ARRAY TEXT:C222(aPProdBy; $k)
ARRAY TEXT:C222(aPLnComment; $k)
ARRAY TEXT:C222(aPProfile1; $k)
ARRAY TEXT:C222(aPProfile2; $k)
ARRAY TEXT:C222(aPProfile3; $k)
//
ARRAY REAL:C219(aPQtyOriginal; $k)
ARRAY REAL:C219(aPQtyOpen; $k)
//
ARRAY LONGINT:C221(aPUniqueID; $k)
ARRAY LONGINT:C221(aPPrintThis; $k)
ARRAY TEXT:C222(aPLocationBin; $k)
//
// ARRAY LONGINT(aPpOgRec;$k)  //Original record count

ARRAY LONGINT:C221(aPPLnSelect; 0)
aPLineAction:=0
ARRAY LONGINT:C221(aPpDeleteLines; 0)