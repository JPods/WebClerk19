// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/14/12, 10:28:19
// ----------------------------------------------------
// Method: Object Method: b63
// Description
// 
//
// Parameters
// ----------------------------------------------------


TRACE:C157
If (Size of array:C274(aInvoiceRecSel)>0)
	QUERY:C277([UserReport:46]; [UserReport:46]Name:2="PKExecute_ShipImport")
	If (Records in selection:C76([UserReport:46])=1)
		theText:=[UserReport:46]ScriptBegin:5
		UNLOAD RECORD:C212([UserReport:46])
		$err:=0
		ExecuteText(0; theText)
	End if 
End if 