//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
If ($1=-1)
	$1:=Size of array:C274(aXItemNum)+1
	Ray_InsertElems($1; 1; ->aXItemNum; ->aXItemDesc; ->aXVendCode; ->aXLead; ->aXCost; ->aXLocation; ->aXQtyLoc; ->aXRefRec)
End if 
aXItemNum{$1}:=[ItemXRef:22]itemNumXRef:2
aXItemDesc{$1}:=[ItemXRef:22]descriptionXRef:3
aXVendCode{$1}:=[ItemXRef:22]sourceid:4  //"Reversed"
aXLead{$1}:=[ItemXRef:22]leadTime:6  //-1
aXCost{$1}:=[ItemXRef:22]cost:7  //-1
aXLocation{$1}:=[ItemXRef:22]siteid:11
aXQtyLoc{$1}:=[ItemXRef:22]quantity:12
aXRefRec{$1}:=Record number:C243([ItemXRef:22])