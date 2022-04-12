//%attributes = {"publishedWeb":true}

If (vHere=0)
	jsetDefaultFile(->[Lead:48])
End if 
If (Records in selection:C76([Lead:48])>20)
	REDUCE SELECTION:C351([Lead:48]; 0)
End if 
jSrchCustLoad(->[Lead:48]; ->[Lead:48]Company:5; ->srCustomer; False:C215)
booPreNext:=True:C214