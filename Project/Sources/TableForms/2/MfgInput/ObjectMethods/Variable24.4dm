If (bChangeRec=1)
	jUniqueAcctCode(->[Customer:2]; ->[Customer:2]customerID:1; ->srAcct)
Else 
	SrCustomerRec(->[Customer:2]; ->[Customer:2]customerID:1; ->srAcct; bChangeRec; False:C215)
End if 