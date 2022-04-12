//%attributes = {"publishedWeb":true}
//CM_ChangeWho ([Order]SalesName;aComNameID;[Employee];vComSales
//;aEmpRate;viSaleMar;aOExtPrice;aOExtCost;aOSalesRate;aOSaleComm;
//[Order]SalesCommission)
C_LONGINT:C283($6)
C_POINTER:C301($1; $2; $3; $4; $5; $7; $8; $9; $10; $11; $12; $13)
// zzzqqq PopUpWildCard($1; $2; $3)  //([Proposal]Rep;aReps;[Rep])
//
If ($1->#Old:C35($1->))
	CM_ChangeRateByNameID($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13)
End if 