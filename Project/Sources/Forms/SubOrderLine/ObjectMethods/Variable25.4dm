// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 04/20/10, 13:57:40
// ----------------------------------------------------
// Method: Object Method: <>aShipVia
// Description
// Form: [Order]iOrders_9
//
// Parameters
// ----------------------------------------------------
If (False:C215)  // <>FreightService=2)
	If (Self:C308->=1)
		XML_FedExRateRequest
		ARRAY TEXT:C222(<>aShipVia; 4)
		<>aShipVia{1}:="ShipVia Request"
		<>aShipVia{2}:=vtGround+" $"+vtGroundValue
		<>aShipVia{3}:=vtGround+" $"+vtGroundValue
		<>aShipVia{4}:=vtGround+" $"+vtGroundValue
	Else 
		[Order:3]shipVia:13:=(Self:C308->{Self:C308->})
	End if 
Else 
	entryEntity.shipVia:=DE_PopUpArray(Self:C308)
	Find Ship Zone(->[Order:3]zip:20; ->[Order:3]zone:14; ->[Order:3]shipVia:13; ->[Order:3]country:21; ->[Order:3]siteid:106)
	// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]shipVia:13)
End if 