//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Method: CommissionReCalcOrders  
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 


vi9:=0
If (Count parameters:C259=0)
	CONFIRM:C162("Recalc Order Commissions")
	vi9:=OK
Else 
	C_LONGINT:C283($doThis; $1)
	vi9:=$1
End if 
If (vi9=1)
	vi2:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	allowAlerts_boo:=False:C215
	For (vi1; 1; vi2)
		MESSAGE:C88(String:C10(vi1))
		vComRep:=CM_FindRate(->[Order:3]repID:8; -><>aReps; -><>aRepRate)
		vComSales:=CM_FindRate(->[Order:3]salesNameID:10; -><>aComNameID; -><>aEmpRate)
		OrdLnFillRays
		vi4:=Size of array:C274(aOItemNum)
		For (vi3; 1; vi4)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{vi3})
			If (Records in selection:C76([Item:4])=1)
				OrdSetPrice(->pUnitPrice; ->pDiscnt; aOQtyOrder{vi3}; ->pComm)
				aOSalesRate{vi3}:=vComSales*pComm*0.01
				aORepRate{vi3}:=vComRep*pComm*0.01
				OrdLnExtend(vi3)
			End if 
		End for 
		booAccept:=True:C214
		vMod:=True:C214
		acceptOrders
		NEXT RECORD:C51([Order:3])
	End for 
	allowAlerts_boo:=True:C214
End if 
REDRAW WINDOW:C456