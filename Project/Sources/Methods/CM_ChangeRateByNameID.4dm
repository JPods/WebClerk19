//%attributes = {"publishedWeb":true}
//Method: CM_ChangeRateByNameID
//Noah Dykoski 000115
//CM_ChangeRateByNameID ([Order]SalesName;aComNameID;[Employee];vComSales
//;aEmpRate;viSaleMar;aOExtPrice;aOExtCost;aOSalesRate;aOSaleComm;
//[Order]SalesCommission)
//CM_AllLineCalc
//$11[Order]SalesCommission:=CM_AllLineCalc ($6viSaleMar;$4vComSales
//;$7aOExtPrice;$8aOExtCost;$9aOSalesRate;$10aOSaleComm;$12aiQtyOrder)
C_REAL:C285($tempRate)
C_LONGINT:C283($6)
C_POINTER:C301($1; $2; $3; $4; $5; $7; $8; $9; $10; $11; $12; $13)
$tempRate:=$4->  //vComRep
$4->:=CM_FindRate($1; $2; $5)  //vComRep:=($1;aReps;aRepRate)
$11->:=CM_AllLineCalc($6; $4; $7; $8; $9; $10; $12; $13)  //(viSaleMar;vComRep;aOExtPrice;aOExtCost;aORepRate;aORepComm
//[Proposal]RepCommission=$11