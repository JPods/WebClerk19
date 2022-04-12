//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/27/13, 10:49:58
// ----------------------------------------------------
// Method: SRE_OrdLnVars
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($w; $cnt)
$w:=Size of array:C274(SRVarNames)
$cnt:=50
INSERT IN ARRAY:C227(SRVarNames; $w+1; $cnt)
SRVarNames{$w+1}:="4;Line Vars"
SRVarNames{$w+2}:="4;pvSeq;pvSeq;1"
SRVarNames{$w+3}:="4;pvItemNum;pvItemNum;1"
SRVarNames{$w+4}:="4;pvAltItem;pvAltItem;1"
SRVarNames{$w+5}:="4;pvDescription;pvDescription;1"
SRVarNames{$w+6}:="4;pvQtyOrd;pvQtyOrd;1"
SRVarNames{$w+7}:="4;pvQtyShip;pvQtyShip;1"
SRVarNames{$w+8}:="4;pvQtyBL;pvQtyBL;1"
SRVarNames{$w+9}:="4;pvQtyCancelled;pvQtyCancelled;1"
SRVarNames{$w+10}:="4;pvTaxable;pvTaxable;1"
SRVarNames{$w+11}:="4;pvTax;pvTax;1"
SRVarNames{$w+12}:="4;pvPricePt;pvPricePt;1"
SRVarNames{$w+13}:="4;pvBasePrice;pvBasePrice;1"
SRVarNames{$w+14}:="4;pvUnitPrice;pvUnitPrice;1"
SRVarNames{$w+15}:="4;pvDiscount;pvDiscount;1"
SRVarNames{$w+16}:="4;pvExtPrice;pvExtPrice;1"
SRVarNames{$w+17}:="4;pvUnitCost;pvUnitCost;1"
SRVarNames{$w+18}:="4;pvExtCost;pvExtCost;1"
SRVarNames{$w+19}:="4;pvUnitMeas;pvUnitMeas;1"
SRVarNames{$w+20}:="4;pvLocation;pvLocation;1"
SRVarNames{$w+21}:="4;pvUse;pvUse;1"
SRVarNames{$w+22}:="4;pvUnitWt;pvUnitWt;1"
SRVarNames{$w+23}:="4;pvExtWt;pvExtWt;1"
SRVarNames{$w+24}:="4;pvLeadTime;pvLeadTime;1"
SRVarNames{$w+25}:="4;pvSerial;pvSerial;1"
SRVarNames{$w+26}:="4;pvCommRep;pvCommRep;1"
SRVarNames{$w+27}:="4;pvCommSales;pvCommSales;1"
SRVarNames{$w+28}:="4;pvRateRep;pvRateRep;1"
SRVarNames{$w+29}:="4;pvRateSales;pvRateSales;1"
SRVarNames{$w+30}:="4;pvRateCommt;pvRateCommt;1"
SRVarNames{$w+31}:="4;pvReference;pvReference;1"
SRVarNames{$w+32}:="4;pvProfile1;pvProfile1;1"
SRVarNames{$w+33}:="4;pvProfile2;pvProfile2;1"
SRVarNames{$w+34}:="4;pvProfile3;pvProfile3;1"
SRVarNames{$w+35}:="4;pvProfileReal1;pvProfileReal1;1"
SRVarNames{$w+36}:="4;pvProfileReal2;pvProfileReal2;1"

SRVarNames{$w+37}:="4;pvNameID;pvNameID;1"
SRVarNames{$w+38}:="4;pvLnComment;pvLnComment;1"
SRVarNames{$w+39}:="4;pvAmountBL;pvAmountBL;1"

SRVarNames{$w+40}:="2;pvTimesPrnt;pvTimesPrnt;1"
SRVarNames{$w+41}:="2;MfgName;MfgName;1"
SRVarNames{$w+42}:="2;MfgAddress;MfgAddress;1"
SRVarNames{$w+43}:="2;MfgAttn;MfgAttn;1"
SRVarNames{$w+44}:="2;MfgPhone;MfgPhone;1"
SRVarNames{$w+45}:="2;MfgFAX;MfgFAX;1"

SRVarNames{$w+46}:="4;curLines;curLines;1"
SRVarNames{$w+47}:="4;<>exUnPrice;<>exUnPrice;1"
SRVarNames{$w+48}:="4;<>exUnExPrice;<>exUnExPrice;1"
SRVarNames{$w+49}:="4;<>exUnCost;<>exUnCost;1"
SRVarNames{$w+50}:="4;<>exUnExCost;<>exUnExCost;1"

If (False:C215)
	SRVarNames{$w+1}:="4;Line Vars"
	SRVarNames{$w+2}:="4;pvSeq;pvSeq;1"
	SRVarNames{$w+3}:="4;pvItemNum;pvItemNum;1"
	SRVarNames{$w+4}:="4;pvAltItem;pvAltItem;1"
	SRVarNames{$w+5}:="4;pvDescription;pvDescription;1"
	SRVarNames{$w+6}:="4;pvQtyOrd;pvQtyOrd;1"
	SRVarNames{$w+7}:="4;pvQtyShip;pvQtyShip;1"
	SRVarNames{$w+8}:="4;pvQtyBL;pvQtyBL;1"
	SRVarNames{$w+9}:="4;pvTaxable;pvTaxable;1"
	SRVarNames{$w+10}:="4;pvTax;pvTax;1"
	SRVarNames{$w+11}:="4;pvPricePt;pvPricePt;1"
	SRVarNames{$w+12}:="4;pvBasePrice;pvBasePrice;1"
	SRVarNames{$w+13}:="4;pvUnitPrice;pvUnitPrice;1"
	SRVarNames{$w+14}:="4;pvDiscount;pvDiscount;1"
	SRVarNames{$w+15}:="4;pvExtPrice;pvExtPrice;1"
	SRVarNames{$w+16}:="4;pvUnitCost;pvUnitCost;1"
	SRVarNames{$w+17}:="4;pvExtCost;pvExtCost;1"
	SRVarNames{$w+18}:="4;pvUnitMeas;pvUnitMeas;1"
	SRVarNames{$w+19}:="4;pvLocation;pvLocation;1"
	SRVarNames{$w+20}:="4;pvUse;pvUse;1"
	SRVarNames{$w+21}:="4;pvUnitWt;pvUnitWt;1"
	SRVarNames{$w+22}:="4;pvExtWt;pvExtWt;1"
	SRVarNames{$w+23}:="4;pvLeadTime;pvLeadTime;1"
	SRVarNames{$w+24}:="4;pvSerial;pvSerial;1"
	SRVarNames{$w+25}:="4;pvCommRep;pvCommRep;1"
	SRVarNames{$w+26}:="4;pvCommSales;pvCommSales;1"
	SRVarNames{$w+27}:="4;pvRateRep;pvRateRep;1"
	SRVarNames{$w+28}:="4;pvRateSales;pvRateSales;1"
	SRVarNames{$w+29}:="4;pvRateCommt;pvRateCommt;1"
	SRVarNames{$w+30}:="4;pvReference;pvReference;1"
	SRVarNames{$w+31}:="4;pvProfile1;pvProfile1;1"
	SRVarNames{$w+32}:="4;pvProfile2;pvProfile2;1"
	SRVarNames{$w+33}:="4;pvProfile3;pvProfile3;1"
	SRVarNames{$w+34}:="4;pvNameID;pvNameID;1"
	SRVarNames{$w+35}:="4;pvLnComment;pvLnComment;1"
	SRVarNames{$w+36}:="4;pvAmountBL;pvAmountBL;1"
	//
	SRVarNames{$w+37}:="2;pvTimesPrnt;pvTimesPrnt;1"
	SRVarNames{$w+38}:="2;MfgName;MfgName;1"
	SRVarNames{$w+39}:="2;MfgAddress;MfgAddress;1"
	SRVarNames{$w+40}:="2;MfgAttn;MfgAttn;1"
	SRVarNames{$w+41}:="2;MfgPhone;MfgPhone;1"
	SRVarNames{$w+42}:="2;MfgFAX;MfgFAX;1"
	//
	SRVarNames{$w+43}:="4;curLines;curLines;1"
	SRVarNames{$w+44}:="4;<>exUnPrice;<>exUnPrice;1"
	SRVarNames{$w+45}:="4;<>exUnExPrice;<>exUnExPrice;1"
	SRVarNames{$w+46}:="4;<>exUnCost;<>exUnCost;1"
	SRVarNames{$w+47}:="4;<>exUnExCost;<>exUnExCost;1"
	
	
End if 