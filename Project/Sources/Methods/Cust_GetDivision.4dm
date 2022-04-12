//%attributes = {"publishedWeb":true}
//Method: Method: Cust_GetDivision
//Noah Dykoski   August 28, 1999 / 3:14 PM
var $0 : Text

If (process_o.Customer.division#"")
	$0:=process_o.Customer.division
Else 
	$0:=Storage:C1525.default.division
End if 