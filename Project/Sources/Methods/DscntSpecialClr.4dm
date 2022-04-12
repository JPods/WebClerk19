//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: DscntSpecialClr  
	//07/11/02:janani
	// changed the array TEXT(aDsctItem;0) size from 15 to 35  
End if 

//TRACE
//DscntSpecialClr
ARRAY TEXT:C222(aDsctItem; 0)
ARRAY BOOLEAN:C223(aDsctbooPC; 0)
ARRAY REAL:C219(aDscnPC; 0)
ARRAY REAL:C219(aDscnPrice; 0)
ARRAY REAL:C219(aBasePrice; 0)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	vUseBase:=SetPricePoint($1)
	If ((vUseBase<2) | (vUseBase>5))
		vUseBase:=2
	End if 
End if 
booSpclComm:=False:C215
vSpclDscn:=0
