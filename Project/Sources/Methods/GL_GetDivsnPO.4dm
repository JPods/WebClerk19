//%attributes = {"publishedWeb":true}
//Procedure: GL_GetDivsnPO
//Noah Dykoski  June 25, 1998 / 5:48 PM=
var $0 : Text
var $1; $PONum : Integer
$PONum:=$1
$0:=Storage:C1525.default.division

If (process_o.PO=Null:C1517)
	process_o.PO:=New object:C1471
End if 
If (process_o.PO.poNum#$PONum)
	process_o.PO:=ds:C1482.PO.query("poNum = :1"; $PONum)
End if 
If (process_o.PO#Null:C1517)
	var $DoVendor : Boolean
	$DoVendor:=True:C214
	If (process_o.PO.idOrder#"")
		process_o.Order.query("id = :1"; process_o.PO.idOrder).first()
		If (process_o.Order#Null:C1517)
			process_o.Customer.query(" id = :1"; process_o.Order.idCustomer)
			If (process_o.Customer#Null:C1517)
				$0:=process_o.Customer.division
				$DoVendor:=False:C215
			End if 
		End if 
	End if 
	If ($DoVendor)
		process_o.Vendor:=ds:C1482.Vendor.query("id = :1"; process_o.PO.idVendor)
		If ((Records in selection:C76([Vendor:38])=1) & (process_o.Vendor.division#0))
			$0:=process_o.Vendor.division
		Else 
			$0:=Storage:C1525.default.division
		End if 
	End if 
Else 
	$0:=Storage:C1525.default.division
End if 