//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_BOOLEAN:C305($2)
If (Records in selection:C76([Item:4])=1)
	pPartNum:=[Item:4]itemNum:1
End if 
pDescript:=[Item:4]description:7
pUnitCost:=[Item:4]costAverage:13
Case of 
	: ($1=(->[Order:3]))
		OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; $2)
	: ($1=(->[Invoice:26]))
		IvcLnAdd((Size of array:C274(aiLineAction)+1); 1; $2)
	: ($1=(->[PO:39]))
		
		POLnAdd((Size of array:C274(aPOLineAction)+1); 1; $2)
	: ($1=(->[Proposal:42]))
		
		PpLnAdd((Size of array:C274(aPLineAction)+1); 1; $2)
		pUse:=1
End case 
vLineMod:=True:C214
