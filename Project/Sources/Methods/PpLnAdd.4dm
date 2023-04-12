//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/28/20, 06:27:57
// ----------------------------------------------------
// Method: PpLnAdd
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1; $2)  //aPBooUse//is maintained for consistency, not used except to set aPUse in before
C_BOOLEAN:C305($3)
C_REAL:C285($d_rate)
If ((<>tcMONEYCHAR=strCurrency) | (<>tcMONEYCHAR="") | ([Proposal:42]exchangeRate:54=0))
	$d_rate:=1
	$thePrec:=<>tcDecimalUP
Else 
	$d_rate:=[Proposal:42]exchangeRate:54
	$thePrec:=viExDisPrec
End if 
PpLn_RaySize(1; $1; $2)
viPrplLnCnt:=viPrplLnCnt+1
aPLineNum{$1}:=viPrplLnCnt
aPLineAction:=$1
aPLineAction{$1}:=-3
aPUniqueID{$1}:=-3
//
pQtyOrd:=[Item:4]qtySaleDefault:15
//pPartNum:=[Item]ItemNum
//pDescript:=[Item]Description
//pUnitCost:=[Item]StdCost
aPPrintThis{$1}:=[Item:4]printNot:112
aPAltItem{$1}:=[Item:4]mfrItemNum:39
aPLocation{$1}:=[Item:4]location:9
If ([Item:4]locationBin:113="multiple")
	apLocationBin{$1}:="multiple"
Else 
	apLocationBin{$1}:=[Item:4]locationBin:113
End if 
aPUnitMeas{$1}:=[Item:4]unitOfMeasure:11
aPUnitCost{$1}:=[Item:4]costAverage:13*Num:C11([Item:4]type:26#"Bulk")*$d_rate
aPUnitWt{$1}:=[Item:4]weightAverage:8
//aPQtyOpen{$1}:=[Item]QtyOnHand-[Item]QtyOnSalesOrds  //was used for
aPQtyOriginal{$1}:=0
//TRACE
Case of 
	: (([Item:4]taxID:17="NoTax") | ([Item:4]taxID:17="No Tax"))
		aPTaxable{$1}:="NoTax"  //|(Record number([Item])=-1))&doTax)
	: ([Item:4]taxID:17="")
		aPTaxable{$1}:="Tax"
	Else 
		aPTaxable{$1}:=[Item:4]taxID:17  //|(Record number([Item])=-1))&doTax)
End case 

aPProfile1{$1}:=[Item:4]profile1:35
aPProfile2{$1}:=[Item:4]profile2:36
aPProfile3{$1}:=[Item:4]profile3:37

If ([Item:4]useQtyPriceBrks:6>0)
	aPPQDiR{$1}:=Record number:C243([Item:4])  //record num if use price breaks
Else 
	aPPQDiR{$1}:=-1
End if 
aPItemNum{$1}:=pPartNum
If ([Item:4]qtySaleDefault:15>pQtyOrd)
	aPQtyOrder{$1}:=[Item:4]qtySaleDefault:15
	pQtyOrd:=[Item:4]qtySaleDefault:15
	BEEP:C151
Else 
	aPQtyOrder{$1}:=pQtyOrd
End if 
If ((<>vbDoSrlNums) & ([Item:4]serialized:41))
	aPSerial{$1}:=<>ciSRUnknown
Else 
	aPSerial{$1}:=<>ciSRNotSerialized
End if 

//C_LONGINT($prevUseBase)
Case of 
	: ((<>tcSrItemDoXRefs=True:C214) & (pXRfPricePt#""))
		//did the user request XRef searching in defaults?
		//AND did the located xref have an associated price point?
		//$prevUseBase:=vUseBase//preserve the old value for reverting.
		vUseBase:=SetPricePoint(pXRfPricePt)
		pDescript:=pXRfDescrp
		aPPricePt{$1}:=pPricePt
	: ([Proposal:42]typeSale:20#"")
		pPricePt:=[Proposal:42]typeSale:20
		vUseBase:=SetPricePoint(pPricePt)
		aPPricePt{$1}:=pPricePt
	Else 
		pPricePt:=<>tcPriceLvlA
		vUseBase:=SetPricePoint(pPricePt)
		aPPricePt{$1}:=pPricePt
End case 
OrdSetPrice(->pUnitPrice; ->pDiscnt; aPQtyOrder{$1}; ->pComm; ->aPTaxable{$1})
//If ((<>tcSrItemDoXRefs=True)&(pPricePt#""))
//vUseBase:=$prevUseBase//revert to the old price point for this order
//End if 
aPLeadTime{$1}:=[Item:4]leadTimeSales:12
aPUse{$1}:="x"
aPDescpt{$1}:=pDescript
pUnitPrice:=Round:C94(pUnitPrice*$d_rate; $thePrec)
aPUnitPrice{$1}:=pUnitPrice  //rate above
aPDiscnt{$1}:=pDiscnt
aPSalesRate{$1}:=vComSales*pComm*0.01
aPRepRate{$1}:=vComRep*pComm*0.01
aPSeq{$1}:=$1
aPLnComment{$1}:=[Item:4]liComment:66
If (allowAlerts_boo)
	If (pQtyOrd>aPQtyOpen{$1})
		BEEP:C151  //PLAY("StockLevel")
	End if 
	ItemSetButtons((Size of array:C274(aPLineAction)>0); True:C214)
	If ([Item:4]linked:63)
		If ((Size of array:C274(aItemLines)#1) & (bAddItem=1))
			BEEP:C151
		Else 
			List_XRefLink(eItemPp; ->[Item:4]itemNum:1)
		End if 
	End if 
	If ([Item:4]alertMessage:52#"")
		ConsoleLog([Item:4]itemNum:1+"\r"+"\r"+[Item:4]alertMessage:52)
	End if 
End if 
If ($3)
	PpLnExtend(aPLineAction)
End if 
UNLOAD RECORD:C212([Item:4])
UNLOAD RECORD:C212([ItemXRef:22])
UNLOAD RECORD:C212([ItemSpec:31])