If (b27=1)
	QUERY:C277([Payment:28]; [Payment:28]customerID:4=srAcct)
Else 
	QUERY:C277([Payment:28]; [Payment:28]customerID:4=srAcct; *)
	QUERY:C277([Payment:28];  & [Payment:28]amountAvailable:19#0)
End if 
//  //  CHOPPED FillPayArrays(Records in selection([Payment]); 0; 0; ePay2App)