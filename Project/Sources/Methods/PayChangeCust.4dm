//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($0)
doSearch:=0
srCustomer:=[Customer:2]company:2
srPhone:=[Customer:2]phone:13
srAcct:=[Customer:2]customerID:1
srZip:=[Customer:2]zip:8
srDivision:=String:C10(Cust_GetDivision)
If (b27=1)
	QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=srAcct)
	If (bpayAlt=0)
		QUERY:C277([Payment:28]; [Payment:28]customerID:4=srAcct)
	End if 
Else 
	QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=srAcct; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]balanceDue:44#0)
	If (bpayAlt=0)
		QUERY:C277([Payment:28]; [Payment:28]customerID:4=srAcct; *)
		QUERY:C277([Payment:28];  & [Payment:28]amountAvailable:19#0)
	End if 
End if 
If (bpayAlt=0)
	//  //  CHOPPED FillPayArrays(Records in selection([Payment]); 0; 0; ePay2App)
End if 
//  //  CHOPPED FillInvArrays(Records in selection([Invoice]); 0; 0; eIvc2Pay)
v1:=""
v2:=""
v3:=""
v4:=""
$0:=True:C214