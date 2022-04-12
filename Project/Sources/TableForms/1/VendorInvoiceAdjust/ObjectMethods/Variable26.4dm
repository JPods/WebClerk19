$k:=Size of array:C274(aPoLnSelct)
If ($k>0)
	bRecByChang:=0  //must be set not to overship
	For ($i; 1; $k)
		If (aPOQtyOrder{aPoLnSelct{$i}}#aPOQtyRcvd{aPoLnSelct{$i}})
			aPOLineAction:=aPoLnSelct{$i}
			pQtyShip:=aPOQtyOrder{aPOLineAction}
			PoLineRecv
			PoLnExtend(aPOLineAction)
		End if 
	End for 
	vLineMod:=True:C214
	aPOLineAction:=aPoLnSelct{$k}
	PoLnFillVar(aPOLineAction)
	vMod:=True:C214
Else 
	BEEP:C151
	BEEP:C151
End if 

C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aPoLnSelct)
iLoReal9:=0
For ($i; 1; $k)
	iLoReal9:=iLoReal9+(aPOQtyNow{aPoLnSelct{$i}}*aPoDscntUP{aPoLnSelct{$i}})
End for 
iLoReal10:=vrVendorInvoiceAmount-iLoReal9