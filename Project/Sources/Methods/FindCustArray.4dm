//%attributes = {"publishedWeb":true}
C_LONGINT:C283(vHere)
If (vHere=0)
	Process_InitLocal
	jsetDefaultFile(->[Customer:2])
End if 
If (Records in selection:C76([Customer:2])>20)
	REDUCE SELECTION:C351([Customer:2]; 0)
End if 
jSrchCustLoad(->[Customer:2]; ->[Customer:2]company:2; ->srCustomer; False:C215)
booPreNext:=True:C214