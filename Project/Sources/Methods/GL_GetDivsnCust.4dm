//%attributes = {"publishedWeb":true}
//Procedure: GL_GetDivsnCust
//Noah Dykoski  June 25, 1998 / 5:48 PM
var $0 : Text
var $1; $CustAcct : Text
$CustAcct:=$1

//Get the Insight Division from [Customer]
//If the customer doesn't have a division or
//the customer isn't found return the [Default]InsightDivision
If (process_o.Customer=Null:C1517)
	process_o.Customer:=New object:C1471
End if 
If (process_o.Customer.customerID=Null:C1517)
	process_o.Customer.customerID:=""
End if 
$0:=Storage:C1525.default.division
If (process_o.Customer.customerID#$CustAcct)
	process_o.Customer:=ds:C1482.Customer.query("customerID = :1"; $CustAcct).first
	If (process_o.Customer#Null:C1517)
		$0:=process_o.Customer.division
	End if 
End if 