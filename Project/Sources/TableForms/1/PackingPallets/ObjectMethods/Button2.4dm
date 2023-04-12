If (<>orderPacking>0)
	READ ONLY:C145([Order:3])
	QUERY:C277([Order:3]; [Order:3]idNum:2=<>orderPacking)
	// $packID:=j//CounterNew (->[LoadTag])  //get uniqueID for pallet
	CREATE RECORD:C68([LoadTag:88])
	[LoadTag:88]containerType:26:=2
	[LoadTag:88]status:6:="Pending"
	[LoadTag:88]trackingid:7:="Not Assigned"
	[LoadTag:88]carrierid:8:=[Order:3]shipVia:13
	[LoadTag:88]customerID:23:=[Order:3]customerID:1
	[LoadTag:88]idNumOrder:29:=[Order:3]idNum:2
	[LoadTag:88]tableNum:34:=3
	[LoadTag:88]documentID:17:=[LoadTag:88]idNumOrder:29
	[LoadTag:88]dtShipOn:10:=DateTime_DTTo
	SAVE RECORD:C53([LoadTag:88])
	PKArrayManage22(-3; 1; 1)
	PKArrayManage22(-6; 1; 1)
	//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
Else 
	ALERT:C41("There must be an associated Order.")
End if 