If (b27=1)
	QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=srAcct)
Else 
	QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=srAcct; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]balanceDue:44#0)
End if 
//  //  CHOPPED FillInvArrays(Records in selection([Invoice]); 0; 0; eIvc2Pay)