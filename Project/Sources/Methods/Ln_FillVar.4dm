//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/06/11, 13:32:26
// ----------------------------------------------------
// Method: Ln_FillVar
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $4)
C_POINTER:C301($2; $3)
C_REAL:C285($5; $6; $7; $8; $9)
C_TEXT:C284($10)
If ($1>0)
	pPartNum:=$2->{$1}  //aPItemNum{aPLineAction}
	pDescript:=$3->{$1}  //aPDescpt{aPLineAction}  
	pUse:=$4  //Num(aPUse{aPLineAction}="")
	pQtyOrd:=$5  //aPQtyOrder{aPLineAction}
	//  pQtyShip:=5//Invoices
	pQtyBL:=$6  //pQtyShip
	pUnitPrice:=$7  //aPUnitPrice{aPLineAction}
	pDiscnt:=$8  //aPDiscnt{aPLineAction}
	pExtPrice:=$9  //aPExtPrice{aPLineAction}  //  //  pUnitCost:=$9//aPUnitCost{aPLineAction}
	pPricePt:=$10
Else 
	pPartNum:=""
	pDescript:=""
	pUse:=0
	pQtyOrd:=0
	pQtyShip:=0
	pQtyBL:=0
	pUnitPrice:=0  //  //  pUnitCost:=0
	pDiscnt:=0
	pExtPrice:=0
	pPricePt:=""
End if 
vBooMarFlag:=True:C214
//(aPOLineAction;aPOItemAlph;aPODescpt;0;aPOQtyOrder{aPOLineAction}
//;aPOQtyRcvd{aPOLineAction};aPOUnitCost{aPOLineAction};aPODiscnt{aPOLineAction}
//;aPOExtCost{aPOLineAction})//