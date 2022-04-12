//%attributes = {"publishedWeb":true}
//Method: EDI_OrdLnAddComplete
C_TEXT:C284($1; $ItemNum)
$ItemNum:=$1
C_REAL:C285($2; $Qty)
If (Count parameters:C259>=2)
	$Qty:=$2
Else 
	$Qty:=1
End if 

QUERY:C277([Item:4]; [Item:4]itemNum:1=$ItemNum)
EDI_OrdLnAdd
aOQtyOrder{aoLineAction}:=$Qty
EDI_OrdLnExtd