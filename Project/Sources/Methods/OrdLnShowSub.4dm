//%attributes = {"publishedWeb":true}
//Procedure: OrdLnShowSub
//wraps this complexe call so that it only needs to be changed here
Ray_ShowSubSet(->aRayLines; ->aoLineAction; ->aOLineNum; ->aOItemNum; ->aOAltItem; ->aOQtyOrder; ->aOQtyShip; ->aOQtyBL; ->aODescpt; ->aOUnitPrice)
Ray_ShowSubSet(->aRayLines; ->aODiscnt; ->aODscntUP; ->aOPQDIR; ->aOExtPrice; ->aOUnitCost; ->aOExtCost; ->aOBackLog; ->aOTaxable; ->aOSaleTax)
Ray_ShowSubSet(->aRayLines; ->aOSaleComm; ->aOSalesRate; ->aORepComm)
Ray_ShowSubSet(->aRayLines; ->aORepRate; ->aOUnitMeas; ->aOUnitWt; ->aOExtWt; ->aOLocation; ->aOQtyOpen; ->aOSerialRc; ->aOSerialNm; ->aOSeq; ->aOPricePt)
Ray_ShowSubSet(->aRayLines; ->aoDateReq; ->aoDateShipOn; ->aoDateShipped; ->aoProdBy; ->aoLnComment; ->aoProfile1; ->aoProfile2; ->aoProfile3)
ARRAY LONGINT:C221(aRayLines; 0)