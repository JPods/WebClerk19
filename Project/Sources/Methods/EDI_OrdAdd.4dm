//%attributes = {"publishedWeb":true}
//Procedure: EDI_OrdAdd
CREATE RECORD:C68([Order:3])
<>passMeText1:=""
If (Record number:C243([Customer:2])>=0)
	myCycle:=3  //add customer info into order
Else 
	myCycle:=0  //add order w/o customer, hope EDI fills in
End if 
ptCurTable:=->[Order:3]
vHere:=2
bExchange:=0
allowAlerts_boo:=False:C215  //prevents code surrounded by blocking ifs
NxPvOrders
allowAlerts_boo:=True:C214