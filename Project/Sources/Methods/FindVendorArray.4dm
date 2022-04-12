//%attributes = {"publishedWeb":true}
If (vHere=0)
	jsetDefaultFile(->[QQQVendor:38])
End if 
jSrchCustLoad(->[QQQVendor:38]; ->[QQQVendor:38]Company:2; ->srCustomer; False:C215)
booPreNext:=True:C214