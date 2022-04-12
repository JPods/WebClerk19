//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/21/19, 16:12:02
// ----------------------------------------------------
// Method: OrdLnReCalc
// Description
// Use the recalc costs and prices
// Needed when cloning an Order
//
// Parameters
// ----------------------------------------------------


If ((<>tcMONEYCHAR=strCurrency) | (<>tcMONEYCHAR="") | ([Order:3]exchangeRate:68=0))
	$d_rate:=1
	$thePrec:=<>tcDecimalUP
Else 
	$d_rate:=[Order:3]exchangeRate:68
	$thePrec:=viExDisPrec
End if 
//
READ ONLY:C145([Item:4])
C_LONGINT:C283($1; $upDatePrice)
$upDatePrice:=1
If (Count parameters:C259=1)
	$upDatePrice:=$1
End if 
C_LONGINT:C283($i; $k; $cntItems)
$k:=Size of array:C274(aOSerialRc)
For ($i; 1; $k)
	aOUniqueID{$i}:=-3  // reset to new line behavior
	aoLineAction{$i}:=-3
	QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{$i})
	aODateReq{$i}:=Current date:C33
	$cntItems:=Records in selection:C76([Item:4])
	aODateReq{$i}:=[Order:3]dateNeeded:5
	aoDateShipOn{$i}:=ShipOnDate(aODateReq{$i}; [Item:4]leadTimeSales:12+[Customer:2]shippingDays:22)
	If ($upDatePrice=1)
		If (Records in selection:C76([Item:4])=1)
			OrdSetPrice(->pUnitPrice; ->pDiscnt; aOQtyOrder{$i}; ->pComm)
			pUnitPrice:=Round:C94(pUnitPrice*$d_rate; $thePrec)
			aOQtyShip{$i}:=0
			If ([Order:3]typeSale:22#"")
				pPricePt:=[Order:3]typeSale:22
			Else 
				pPricePt:=<>tcPriceLvlA
			End if 
			aOPricePt{$i}:=pPricePt
			aOUnitPrice{$i}:=pUnitPrice
			aODiscnt{$i}:=pDiscnt
			aOSalesRate{$i}:=vComSales*pComm*0.01
			aORepRate{$i}:=vComRep*pComm*0.01
		End if 
		If (aOLocation{$i}>-1)
			aOUnitCost{$i}:=[Item:4]costAverage:13*Num:C11([Item:4]typeid:26#"Bulk")*$d_rate
		End if 
	End if 
	UNLOAD RECORD:C212([Item:4])
	//If (aOSerialRc{$i}#<>ciSRNotSerialized)
	
	// Modified by: William James (2014-01-26T00:00:00)
	
	aOSerialRc{$i}:=-3  // reset to empty serial numbers
	aOSerialNm{$i}:=""
	//End if 
	aOQtyShip{$i}:=0
	OrdLnExtend($i)
End for 
READ WRITE:C146([Item:4])
//