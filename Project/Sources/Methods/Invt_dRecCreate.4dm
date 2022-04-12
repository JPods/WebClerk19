//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/08/13, 16:02:15
// ----------------------------------------------------
// Method: Invt_dRecCreate
// Description
// File: Invt_dRecCreate.txt
// Parameters
// ----------------------------------------------------
//### jwm ### 20130308_1558 string size $14 changed from 4 to 40

//Invt_dRecCreate
C_TEXT:C284($1; $4; $6; $9; $13)
C_TEXT:C284($14)  //### jwm ### 20130308_1558 string size $14 changed from 4 to 40
C_LONGINT:C283($2; $3; $5; $7; $8; $w)
C_REAL:C285($10; $11; $12; $15)


If (($9#"") & ($9#"Comment") & (($10#0) | ($11#0)))
	$w:=Size of array:C274(dType)+1
	Ray_InsertElems($w; 1; ->dItemNumKey; ->dQtyOnHand; ->dQtyOnSO; ->dQtyOnPO; ->dQtyOnWO; ->dQtyOnAdj; ->dUnitCost; ->dJobID; ->dDocID; ->dLineNum; ->dReceiptID; ->dSource; ->dReason; ->dType; ->dDTCreated; ->dNote; ->dTakeAction; ->dSite; ->dUnitPrice; ->dChangeBy; ->dTableNum)
	dType{$w}:=$1
	dDocID{$w}:=$2  //[Order]OrderNum
	dReceiptID{$w}:=$3  //Alt Id For INship ID
	dSource{$w}:=$4  //[Order]AccountKey
	dJobID{$w}:=$5
	dReason{$w}:=$6  //"-d Item"
	dTakeAction{$w}:=$7  // integer, use to keep sales orders from sliding backwards in count when
	//                                //talleying Usage Records
	dLineNum{$w}:=$8  //[OrderLine]LineNum
	dItemNumKey{$w}:=$9
	dQtyOnHand{$w}:=$10  //adding increases qty OnHand
	Case of 
		: ($1="")
		: (($1[[1]]="S") | ($1[[1]]="i") | ($1[[1]]="B") | ($1="PK@"))  //S for sales order
			dQtyOnSO{$w}:=$11  //adding decreases Qty on Order
			dTableNum{$w}:=Table:C252(->[Order:3])
		: ($1[[1]]="P")  //P for Purchase Receipt
			dQtyOnPO{$w}:=$11  //adding decreases Qty on Po  
			dTableNum{$w}:=Table:C252(->[POLine:40])
		: ($1[[1]]="W")  //W for Work Receipt
			dQtyOnWO{$w}:=$11  //adding decreases Qty on Wo 
			dTableNum{$w}:=Table:C252(->[WorkOrder:66])
		: ($1[[1]]="A")  //A and else for adjustments
			dQtyOnAdj{$w}:=$11  //adding decreases Qty on Adj       
			dTableNum{$w}:=-5
	End case 
	dUnitCost{$w}:=$12
	dNote{$w}:=$13
	dDTCreated{$w}:=DateTime_Enter
	dSite{$w}:=$14
	dUnitPrice{$w}:=$15
	dChangeBy{$w}:=Current user:C182
	//SAVE RECORD([dInventory])
	//UNLOAD RECORD([dInventory])
End if 
//$7 == 3, no back counting for orders/po counts
//$7 == 4, add the invoice/po received counts to ordered/purchased  ($11+$10)