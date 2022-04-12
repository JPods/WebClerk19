//%attributes = {}



// 4D_25Invoice - 2022-01-15
If (Form:C1466.selectedSubset.length>0)
	Form:C1466.displayedSelection:=Form:C1466.selectedSubset
	Form:C1466.selectedSubset:=Form:C1466.dataClass.newSelection()
	Form:C1466.clickedEntity:=New object:C1471
	Form:C1466.clickedEntityPosition:=0
	Form:C1466.queryString:=""
End if 
