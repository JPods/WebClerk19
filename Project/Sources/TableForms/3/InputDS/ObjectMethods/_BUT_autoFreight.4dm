ALERT:C41("No load planning released")
If (False:C215)
	ARRAY REAL:C219(aOQtyPack; 0)  //must be zero in Order Layout vs Packing
	badTechnique:=0  //so this can be found later
	iLoInteger9:=9
	LT_OrdWindowOpen
	iLoInteger9:=0
End if 

