KeyModifierCurrent
If (OptKey=1)
	vbForceShip:=True:C214
End if 
If (Not:C34(Locked:C147([Order:3])))
	Ord2InvProduct(1; OptKey)
Else 
	ALERT:C41("Order is locked.")
End if 