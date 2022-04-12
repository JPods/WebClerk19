//%attributes = {"publishedWeb":true}
//Procedure: SRE_PoLnVars
C_LONGINT:C283($w; $cnt)
$w:=Size of array:C274(SRVarNames)
$cnt:=25
INSERT IN ARRAY:C227(SRVarNames; $w+1; $cnt)
SRVarNames{$w+1}:="4;LineVars"
SRVarNames{$w+2}:="4;pvSeq;pvSeq;1"
SRVarNames{$w+3}:="4;pvItemNum;pvItemNum;1"
SRVarNames{$w+4}:="4;pvAltItem;pvAltItem;1"
SRVarNames{$w+5}:="4;pvDescription;pvDescription;1"
SRVarNames{$w+6}:="4;pvQtyOrd;pvQtyOrd;1"
SRVarNames{$w+7}:="4;pvQtyShip;pvQtyShip;1"
SRVarNames{$w+8}:="4;pvQtyBL;pvQtyBL;1"
SRVarNames{$w+9}:="4;pvAmountBL;pvAmountBL;1"
SRVarNames{$w+10}:="4;pvTaxable;pvTaxable;1"
SRVarNames{$w+11}:="4;pvTax;pvTax;1"
SRVarNames{$w+12}:="4;pvDiscount;pvDiscount;1"
SRVarNames{$w+13}:="4;pvBaseCost;pvBaseCost;1"
SRVarNames{$w+14}:="4;pvUnitCost;pvUnitCost;1"
SRVarNames{$w+15}:="4;pvExtCost;pvExtCost;1"
SRVarNames{$w+16}:="4;pvUnitMeas;pvUnitMeas;1"
SRVarNames{$w+17}:="4;pvLocation;pvLocation;1"
SRVarNames{$w+18}:="4;pvUnitWt;pvUnitWt;1"
SRVarNames{$w+19}:="4;pvExtWt;pvExtWt;1"
SRVarNames{$w+20}:="4;pvLeadTime;pvLeadTime;1"
SRVarNames{$w+21}:="4;pvSerial;pvSerial;1"
SRVarNames{$w+22}:="4;pvReference;pvReference;1"
SRVarNames{$w+23}:="4;pvLnComment;pvLnComment;1"
SRVarNames{$w+24}:="4;<>exUnCost;<>exUnCost;1"
SRVarNames{$w+25}:="4;<>exUnExCost;<>exUnExCost;1"