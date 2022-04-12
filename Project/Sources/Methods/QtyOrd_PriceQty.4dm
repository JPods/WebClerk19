//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)  //aoLineAction; aOPQDIR ;aOQtyOpen
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8)
READ ONLY:C145([Item:4])
If ([Item:4]itemNum:1#$4->{$1})
	GOTO RECORD:C242([Item:4]; $2->{$1})
	If ([Item:4]itemNum:1#$4->{$1})
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$4->{$1})
		$2->{$1}:=Record number:C243([Item:4])
	End if 
End if 
If ([Item:4]itemNum:1=$4->{$1})
	OrdSetPrice(->pUnitPrice; ->pDiscnt; pQtyOrd; ->pComm)
	$3->{$1}:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16
	$5->{$1}:=pUnitPrice
	$6->{$1}:=pDiscnt
	$7->{$1}:=Round:C94(vComSales*pComm*0.01; 1)
	$8->{$1}:=Round:C94(vComRep*pComm*0.01; 1)
	If (pQtyOrd>$3->{$1})
		BEEP:C151  //PLAY("StockLevel")
	End if 
Else 
	ALERT:C41("Re-enter item number if you wish to reset the Price/Qty discounts.")
End if 
UNLOAD RECORD:C212([Item:4])
READ WRITE:C146([Item:4])