If (False:C215)
	//Date: 03/15/02
	//Who: Dan Bentson, Arkware
	//Description: Added
	VERSION_960
End if 


SumOutPutLayOut(->[Usage:5]SalesQtyActual:4; ->vR1; ->[Usage:5]SalesActual:10; ->vR2; ->[Usage:5]OrdQtyActual:26; ->vR3; ->[Usage:5]OrdersActual:20; ->vR4; ->[Usage:5]BOMQtyActual:36; ->vR5; ->[Usage:5]InventoryActual:6; ->vR6)

If (False:C215)
	vR1:=0
	vR2:=0
	vR3:=0
	vR4:=0
	vR5:=0
	vR6:=0
	C_LONGINT:C283($ris; $i)
	$ris:=Records in selection:C76([Usage:5])
	FIRST RECORD:C50([Usage:5])
	For ($i; 1; $ris)
		vR1:=vR1+[Usage:5]SalesQtyActual:4
		vR2:=vR2+[Usage:5]SalesActual:10
		vR3:=vR3+[Usage:5]OrdQtyActual:26
		vR4:=vR4+[Usage:5]OrdersActual:20
		vR5:=vR5+[Usage:5]BOMQtyActual:36
		vR6:=vR6+[Usage:5]InventoryActual:6
		NEXT RECORD:C51([Usage:5])
	End for 
End if 
