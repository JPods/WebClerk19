//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
If ($1=0)
	UNLOAD RECORD:C212([Customer:2])
	UNLOAD RECORD:C212([Order:3])
	v2:=""  //clear the item number field
Else 
	If ([Order:3]customerID:1#[Customer:2]customerID:1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
	End if 
End if 
vi1:=[Order:3]idNum:2
v1:=[Order:3]customerPO:3
v3:=[Customer:2]company:2
v4:=[Customer:2]phone:13
v5:=[Customer:2]fax:66
v6:=[Order:3]attention:44
v7:=[Order:3]city:18
v8:=[Order:3]status:59
v9:=[Order:3]salesNameID:10
v10:=[Order:3]takenBy:36
v11:=[Order:3]actionBy:55
vDate1:=[Order:3]dateNeeded:5
vTime1:=[Order:3]actionTime:37
vDate2:=[Order:3]dateDocument:4
vTime2:=[Order:3]timeOrdered:58
jDateTimeRecov([Order:3]dtProdRelease:56; ->vDate3; ->vTime3)
jDateTimeRecov([Order:3]dtProdCompl:57; ->vDate4; ->vTime4)
vDate5:=[Order:3]dateInvoiceComp:6
//  Put  the formating in the form  jFormatPhone(->v4; ->v5)
//
