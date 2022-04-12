//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/08/18, 11:30:51
// ----------------------------------------------------
// Method: EmailQueryMenu
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($defaultResponse)
$defaultResponse:=Get text from pasteboard:C524

$response:=Request:C163("Query email across all tables"; Substring:C12(Get text from pasteboard:C524; 1; 255); "OK"; "Cancel")
If ((OK=1) & ($response#""))
	EmailQueryAcrossTables($response)
	If (Records in selection:C76([QQQRemoteUser:57])>0)
		ProcessTableOpen(Table:C252(->[QQQRemoteUser:57]); ""; "Email: "+$response)
	End if 
	If (Records in selection:C76([QQQCustomer:2])>0)
		ProcessTableOpen(Table:C252(->[QQQCustomer:2]); ""; "Email: "+$response)
	End if 
	If (Records in selection:C76([QQQContact:13])>0)
		ProcessTableOpen(Table:C252(->[QQQContact:13]); ""; "Email: "+$response)
	End if 
	If (Records in selection:C76([Rep:8])>0)
		ProcessTableOpen(Table:C252(->[Rep:8]); ""; "Email: "+$response)
	End if 
	If (Records in selection:C76([QQQVendor:38])>0)
		ProcessTableOpen(Table:C252(->[QQQVendor:38]); ""; "Email: "+$response)
	End if 
End if 