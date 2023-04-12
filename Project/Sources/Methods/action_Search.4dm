//%attributes = {}

// Modified by: Bill James (2022-01-15T06:00:00Z)
// Method: action_Search
// Description 
// Parameters
// ----------------------------------------------------




// 4D_25Invoice - 2022-01-15
Form:C1466.queryTable.path:="_ANYWHERE_"
If (Form:C1466.displayedSelection=Null:C1517)
	Form:C1466.displayedSelection:=Form:C1466.dataClass.newSelection()
End if 
Form:C1466.displayedSelection:=QRY_Do_Query(ds:C1482; Form:C1466.dataClass; Form:C1466.displayedSelection; Form:C1466.queryTable.inSelection)

If (OK=1)
	Form:C1466.queryTable.queryString:=""
End if 