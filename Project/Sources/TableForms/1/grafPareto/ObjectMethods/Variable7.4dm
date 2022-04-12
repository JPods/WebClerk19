If (vShowCats>vTotCats)
	vShowCats:=vTotCats
End if 
COPY ARRAY:C226(aCatagory; aShowCats)
If (Size of array:C274(aShowCats)>vShowCats)
	DELETE FROM ARRAY:C228(aShowCats; vShowCats+1; (Size of array:C274(aShowCats)-vShowCats))
End if 
GRAPH SETTINGS:C298(vPareto; 0; 0; 0; 0; False:C215; False:C215; True:C214; "Totals")
GRAPH:C169(vPareto; 1; aShowCats; aTally)