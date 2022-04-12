//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/20/21, 14:21:51
// ----------------------------------------------------
// Method: oloBaseLine
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; ptCurTable)

If (Count parameters:C259=0)
	If (Is nil pointer:C315(ptCurTable))
		ptCurTable:=(->[Customer:2])
	End if 
Else 
	ptCurTable:=$1
End if 

C_OBJECT:C1216(obRec; obSel; $obFormEvent)
$obFormEvent:=FORM Event:C1606
Case of 
	: ($obFormEvent.code=On Load:K2:1)
		TRACE:C157
		Form:C1466.obSel:=ds:C1482.Customer.all()
		
		//Form.obSel:=ds.Customer.query("address1 = :1 AND (address2 # :2 OR city = :3)"; "123"; ""; """).orderBy()"
		
	: ($obFormEvent.code=On Double Clicked:K2:5)
		$obRec:=Form:C1466.obSel[$obFormEvent.row-1]
		
	: ($obFormEvent.code=On Clicked:K2:4)
		
		
		
		// Look at TableShow Class when there is time
		
	: ($obFormEvent.code=On Drag Over:K2:13)
		
	: ($obFormEvent.code=On Drop:K2:12)
		
End case 