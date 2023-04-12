//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/13/20, 18:43:07
// ----------------------------------------------------
// Method: POLnAdd
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1; $2)
C_BOOLEAN:C305($3; $4; $5; $6; $7; $8)


If ((<>tcMONEYCHAR=strCurrency) | (<>tcMONEYCHAR="") | ([PO:39]exchangeRate:45=0))
	$d_rate:=1
	$thePrec:=<>tcDecimalUP
Else 
	$d_rate:=[PO:39]exchangeRate:45
	$thePrec:=viExDisPrec
End if 
//C_REAL($d_rate)
//If ((<>tcMONEYCHAR#"")&(<>tcMONEYCHAR#strCurrency)&([POs
//]ExchangeRate#0))
//$d_rate:=[PO]ExchangeRate
//Else 
//$d_rate:=1
//End if 
//If (pQtyOrd=0)
//pQtyOrd:=1
//End if 
viPOLnCnt:=viPOLnCnt+1

aPOLineAction:=$1
POLn_RaySize(1; $1; $2)  //action add; position; number of elements
aPOLineAction{$1}:=-3  // -3 new, >-1  unchanged selected rec, - 3000 notes changed selected rec
aPoUniqueID{$1}:=-3
aPOLineNum{$1}:=viPOLnCnt
aPOUnitMeas{$1}:=[Item:4]unitOfMeasure:11
aPoUnitWt{$1}:=[Item:4]weightAverage:8

// ### bj ### 20201013_1733
// [Item]CostMSC
// <>Order2POCost210 should only apply if coming from a SO
// rework this, checkThis
If ([Item:4]costMSC:110=0)  // fix legacy
	[Item:4]costMSC:110:=[Item:4]costLastInShip:47
End if 
Case of 
	: (<>Order2POCost210=4)
		pUnitPrice:=[Item:4]costMSC:110*Num:C11([Item:4]type:26#"Bulk")*$d_rate
	: (<>Order2POCost210=1)
		pUnitPrice:=[Item:4]costAverage:13*Num:C11([Item:4]type:26#"Bulk")*$d_rate
	: (<>Order2POCost210=2)
		pUnitPrice:=[Item:4]costLastInShip:47*Num:C11([Item:4]type:26#"Bulk")*$d_rate
	Else 
		pUnitPrice:=[Item:4]costMSC:110*Num:C11([Item:4]type:26#"Bulk")*$d_rate
End case 



aPoUnitCost{$1}:=pUnitPrice
If ([Item:4]useQtyPriceBrks:6>0)
	aPoPQBIR{$1}:=Record number:C243([Item:4])  //record num if use price breaks
Else 
	aPoPQBIR{$1}:=-1
End if 
aPoTaxable{$1}:=[Item:4]taxID:17  //&doTax)
pQtyShip:=0  //default qty recvd = 0
// 
// Modified by: Bill James (2016-10-07T00:00:00)

If ([Item:4]reOrdQty:27#0)  //September 26, 1996
	pQtyOrd:=[Item:4]reOrdQty:27
End if 
If (pQtyOrd=0)  //avoid line items with zero ordered
	pQtyOrd:=1
End if 
If ((<>vbDoSrlNums) & ([Item:4]serialized:41))  //serialized item
	aPOSerialRc{$1}:=CounterNew(->[DialingInfo:81])
Else 
	aPOSerialRc{$1}:=<>ciSRNotSerialized
End if 
aPOQtyOrder{$1}:=pQtyOrd
aPOQtyRcvd{$1}:=pQtyShip
aPoExtWt{$1}:=aPoUnitWt{$1}*aPOQtyOrder{$1}
//TRACE
//aPOQtyBL{$1}:=pQtyOrd-pQtyShip  //in extensions

aPODescpt{$1}:=pDescript

If ([PO:39]vendorID:1#"")
	//is the vendor assured to be selected?
	aPODiscnt{$1}:=[Vendor:38]discount:16
Else 
	aPODiscnt{$1}:=0
End if 
pDiscnt:=aPODiscnt{$1}
aPOVATax{$1}:=0
If ([Item:4]leadTimePo:55>0)
	aPODateExp{$1}:=Current date:C33+[Item:4]leadTimePo:55
Else 
	aPODateExp{$1}:=!00-00-00!
End if 
aPOOrdRef{$1}:=[PO:39]idNumOrder:18
aPODateRcvd{$1}:=!00-00-00!
aPOVndrAlph{$1}:=[Item:4]vendorItemNum:40
aPoItemNum{$1}:=[Item:4]itemNum:1
aPoSeq{$1}:=MaxValueInArray(->aPoSeq)+1
aPoLComment{$1}:=[Item:4]liComment:66
//
If (<>viDebugMode>410)
	ConsoleLog("POLine: "+[Item:4]itemNum:1+", MyCycle: "+String:C10(myCycle)+", Line#: "+String:C10(aPOLineNum{$1}))
End if 

If (allowAlerts_boo)
	ItemSetButtons((Size of array:C274(aPOLineAction)>0); True:C214)  //activate item control buttons
	If ([Item:4]linked:63)
		If ((Size of array:C274(aItemLines)#1) & (bAddItem=1))
			BEEP:C151
		Else 
			List_XRefLink(eItemPo; ->[Item:4]itemNum:1)
		End if 
	End if 
	If ((aPOLineAction{$1}=-3) & ([Item:4]alertMessagePO:140#""))
		ConsoleLog([Item:4]itemNum:1+"\r"+"\r"+[Item:4]alertMessagePO:140)
	End if 
End if 

If ($3)  // calculate because there are no overrides
	PoLnExtend(aPOLineAction)
End if 
UNLOAD RECORD:C212([Item:4])
UNLOAD RECORD:C212([ItemXRef:22])
UNLOAD RECORD:C212([ItemSpec:31])
