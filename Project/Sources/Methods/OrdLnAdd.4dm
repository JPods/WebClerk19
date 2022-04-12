//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-01-21T00:00:00, 11:50:29
// ----------------------------------------------------
// Method: OrdLnAdd
// Description
// Modified: 01/21/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(pvLnProfile1; pvLnProfile2; pvLnProfile3; pXRfPricePt)

C_LONGINT:C283($1; $2)  //start point, number of inserts)
C_BOOLEAN:C305($3)
C_REAL:C285($d_rate)
C_LONGINT:C283($k; $i; viOrdLnCnt; $inTest)
$inTest:=0
$k:=Size of array:C274(aOOgLine)
For ($i; 1; $k)
	$inTest:=MaxValueReturn($inTest; aOOgLine{$i}; 1)
End for 
$k:=Size of array:C274(aOLineNum)
For ($i; 1; $k)
	$inTest:=MaxValueReturn($inTest; aOLineNum{$i}; 1)
End for 
viOrdLnCnt:=$inTest+1
//TRACE
If ((<>tcMONEYCHAR=strCurrency) | (<>tcMONEYCHAR="") | ([Order:3]exchangeRate:68=0))
	$d_rate:=1
	$thePrec:=<>tcDecimalUP
Else 
	$d_rate:=[Order:3]exchangeRate:68
	$thePrec:=viExDisPrec
End if 
OrdLn_RaySize(1; $1; $2)
pUse:=0
aoLineAction:=$1
aoLineAction{$1}:=-3  // -3 new, >-1  unchanged selected rec, - 3000 notes changed selected rec
aoUniqueID{$1}:=-3
aOLineNum{$1}:=viOrdLnCnt
pQtyOrd:=[Item:4]qtySaleDefault:15
//pPartNum:=[Item]ItemNum   //in ListItemFill
If ([Item:4]type:26="carrier")
	pDescript:=String:C10(Current date:C33)+", "+[Item:4]description:7
End if 
//pUnitCost:=[Item]StdCost
aOPrintThis{$1}:=[Item:4]printNot:112
aOAltItem{$1}:=[Item:4]mfrItemNum:39
aOLocation{$1}:=[Item:4]location:9
aOUnitMeas{$1}:=[Item:4]unitOfMeasure:11

If (True:C214)
	aOUnitCost{$1}:=[Item:4]costAverage:13*Num:C11([Item:4]type:26#"Bulk")*$d_rate
Else 
	C_LONGINT:C283(<>Order2POCost210)
	//Setting Costs from an Order to POACH
	//<>Order2POCost210
	//2  =  Last Cost
	//1  =  Average Cost
	//0  =  Cost from the orderliness
	//Case of 
	//: (<>Order2POCost210=2)
	// aOUnitCost{$1}:=[Item]CostLastInShip*Num([Item]typeID#"Bulk")*$d_rate
	// Else 
	// Modified by: williamjames (3/3/13)
	If (<>Order2POCost210=2)
		aOUnitCost{$1}:=[Item:4]costLastInShip:47*Num:C11([Item:4]type:26#"Bulk")*$d_rate
	Else   //(<>Order2POCost210=1)
		aOUnitCost{$1}:=[Item:4]costAverage:13*Num:C11([Item:4]type:26#"Bulk")*$d_rate
	End if 
End if 


// End case 

aOUnitWt{$1}:=[Item:4]weightAverage:8
aOQtyOpen{$1}:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16
If ([Item:4]locationBin:113="multiple")
	aoLocationBin{$1}:="multiple"
Else 
	aoLocationBin{$1}:=[Item:4]locationBin:113
End if 
Case of 
	: (([Item:4]taxID:17="NoTax") | ([Item:4]taxID:17="No Tax"))
		aOTaxable{$1}:="NoTax"  //|(Record number([Item])=-1))&doTax)
	: ([Item:4]taxID:17="")
		aOTaxable{$1}:="Tax"
	Else 
		aOTaxable{$1}:=[Item:4]taxID:17  //|(Record number([Item])=-1))&doTax)
End case 
If ((<>vbDoSrlNums) & ([Item:4]serialized:41))
	aOSerialRc{$1}:=<>ciSRUnknown
Else 
	aOSerialRc{$1}:=<>ciSRNotSerialized
End if 
If ([Item:4]useQtyPriceBrks:6>0)
	aOPQDIR{$1}:=Record number:C243([Item:4])  //record num if use price breaks
Else 
	aOPQDIR{$1}:=-1
End if 
aOItemNum{$1}:=pPartNum
If ([Item:4]qtySaleDefault:15>pQtyOrd)
	aOQtyOrder{$1}:=[Item:4]qtySaleDefault:15
	pQtyOrd:=[Item:4]qtySaleDefault:15
	If (allowAlerts_boo)
		BEEP:C151
	End if 
Else 
	aOQtyOrder{$1}:=pQtyOrd
End if 
If ((pvLnProfile1="NewsClerk") & (pvLnProfile2#""))
	OrdLnNewsClerk
	aOQtyOrder{$1}:=pQtyOrd
	aoProfile1{$1}:=pvLnProfile1
	aoProfile2{$1}:=pvLnProfile2
	aoProfile3{$1}:=pvLnProfile3
Else 
	// Note the likely cross over between two types of line profiles
	//IvcLnAdd
	//IvcLnLoadRec
	//OrdLn_RecordFill
	//
	aoProfile1{$1}:=[Item:4]profile1:35
	aoProfile2{$1}:=[Item:4]profile2:36
	aoProfile3{$1}:=[Item:4]profile3:37
	Case of 
		: ((<>tcSrItemDoXRefs=True:C214) & (pXRfPricePt#""))
			//did the user request XRef searching in defaults?
			//AND did the located xref have an associated price point?
			//$prevUseBase:=vUseBase//preserve the old value for reverting.
			vUseBase:=SetPricePoint(pXRfPricePt)
			pDescript:=pXRfDescrp
			aOPricePt{$1}:=pXRfPricePt
		: ([Order:3]typeSale:22#"")
			pPricePt:=[Order:3]typeSale:22
			vUseBase:=SetPricePoint([Order:3]typeSale:22)
			aOPricePt{$1}:=pPricePt
		Else 
			pPricePt:=<>tcPriceLvlA
			vUseBase:=SetPricePoint(pPricePt)
			aOPricePt{$1}:=pPricePt
	End case 
	OrdSetPrice(->pUnitPrice; ->pDiscnt; aOQtyOrder{$1}; ->pComm; ->aOTaxable{$1})
End if 
//If ((<>tcSrItemDoXRefs=True)&(pPricePt#""))
//vUseBase:=$prevUseBase//revert to the old price point for this order
//End if 

pUnitPrice:=Round:C94(pUnitPrice*$d_rate; $thePrec)
aOQtyShip{$1}:=0
aODescpt{$1}:=pDescript
aOUnitPrice{$1}:=pUnitPrice
aODiscnt{$1}:=pDiscnt
aOSalesRate{$1}:=vComSales*pComm*0.01
aORepRate{$1}:=vComRep*pComm*0.01
aODateReq{$1}:=[Order:3]dateNeeded:5
aoDateShipOn{$1}:=ShipOnDate(aODateReq{$1}; [Item:4]leadTimeSales:12+[Customer:2]shippingDays:22)
aOSeq{$1}:=$1
//
aoLnComment{$1}:=[Item:4]liComment:66
pPricePt:=aOPricePt{$1}
If (allowAlerts_boo)
	If (pQtyOrd>aOQtyOpen{$1})
		BEEP:C151  //PLAY("StockLevel")
	End if 
	ItemSetButtons((Size of array:C274(aoLineAction)>0); True:C214)
	If ([Item:4]linked:63)
		If ((Size of array:C274(aItemLines)#1) & (bAddItem=1))
			BEEP:C151
		Else 
			List_XRefLink(eItemOrd; ->[Item:4]itemNum:1)
		End if 
	End if 
	If ([Item:4]alertMessage:52#"")
		ConsoleMessage([Item:4]itemNum:1+"\r"+"\r"+[Item:4]alertMessage:52)
	End if 
End if 
//vLineMod:=True
vLineReCalc:=True:C214
If ($3)
	OrdLnExtend(aoLineAction)
End if 
UNLOAD RECORD:C212([Item:4])
UNLOAD RECORD:C212([ItemXRef:22])
UNLOAD RECORD:C212([ItemSpec:31])
