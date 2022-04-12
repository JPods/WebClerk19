vGrafTitle:=vHeadTitle
vSubTitle:=vCatTitle
GRAPH SETTINGS:C298(prntGraf; 0; 0; 0; 0; False:C215; False:C215; True:C214; "Totals")
GRAPH:C169(prntGraf; 1; aShowCats; aTally)
_O_PAGE SETUP:C299([Control:1]; "prntGraf")
PRINT SETTINGS:C106
If (OK=1)
	Print form:C5([Control:1]; "prntGraf")
	PAGE BREAK:C6
End if 
vGrafTitle:=""
vSubTitle:=""