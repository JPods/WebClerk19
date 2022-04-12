//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/21/19, 16:10:14
// ----------------------------------------------------
// Method: PpLnReCalc
// Description
// Use the recalc costs and prices
// Needed when cloning a Proposal
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(strCurrency)  // ### bj ### 20200524_1203  SimplfyQQQ
If ((<>tcMONEYCHAR=strCurrency) | (<>tcMONEYCHAR="") | ([Proposal:42]exchangeRate:54=0))
	$d_rate:=1
	$thePrec:=<>tcDecimalUP
Else 
	$d_rate:=[Proposal:42]exchangeRate:54
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
$k:=Size of array:C274(aPLineAction)
For ($i; 1; $k)
	QUERY:C277([Item:4]; [Item:4]itemNum:1=aPItemNum{$i})
	$cntItems:=Records in selection:C76([Item:4])
	Case of 
		: ($cntItems=0)
			aPDateExp{$i}:=Current date:C33+1
		: (aPDateExp{$i}>(Current date:C33+[Item:4]leadTimeSales:12))
			//leave alone
		Else 
			aPDateExp{$i}:=Current date:C33+[Item:4]leadTimeSales:12
	End case 
	If ($upDatePrice=1)
		If (Records in selection:C76([Item:4])=1)
			OrdSetPrice(->pUnitPrice; ->pDiscnt; aPQtyOrder{$i}; ->pComm)
			pUnitPrice:=Round:C94(pUnitPrice*$d_rate; $thePrec)
			//aOQtyShip{$i}:=0
			
			If ([Proposal:42]typeSale:20#"")
				pPricePt:=[Proposal:42]typeSale:20
			Else 
				pPricePt:=<>tcPriceLvlA
			End if 
			aPPricePt{$i}:=pPricePt
			aPUnitPrice{$i}:=pUnitPrice
			aPDiscnt{$i}:=pDiscnt
			aPSalesRate{$i}:=vComSales*pComm*0.01
			aPRepRate{$i}:=vComRep*pComm*0.01
		End if 
		If (aPLocation{$i}>-1)
			aPUnitCost{$i}:=[Item:4]costAverage:13*Num:C11([Item:4]typeid:26#"Bulk")*$d_rate
		End if 
	End if 
	If ((<>vbDoSrlNums) & ([Item:4]serialized:41))
		aPSerial{$i}:=<>ciSRUnknown
	Else 
		aPSerial{$i}:=<>ciSRNotSerialized
	End if 
	UNLOAD RECORD:C212([Item:4])
	aPLineAction{$i}:=-3
	//aOQtyShip{$i}:=0
	PpLnExtend($i)
End for 
READ WRITE:C146([Item:4])
//