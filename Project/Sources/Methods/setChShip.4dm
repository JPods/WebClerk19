//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/04/09, 14:47:33
// ----------------------------------------------------
// Method: setChShip
// Description
// 
//
// Parameters
// ----------------------------------------------------

CREATE SET:C116([QQQCarrier:11]; "Current")
READ ONLY:C145([QQQCarrier:11])
QUERY:C277([QQQCarrier:11]; [QQQCarrier:11]Active:6=True:C214)
SELECTION TO ARRAY:C260([QQQCarrier:11]CarrierID:10; <>aShipVia)
SORT ARRAY:C229(<>aShipVia; >)
INSERT IN ARRAY:C227(<>aShipVia; 1; 1)
<>aShipVia{1}:="ShipVia"
<>aShipVia:=1
READ WRITE:C146([QQQCarrier:11])
USE SET:C118("Current")
CLEAR SET:C117("Current")
UNLOAD RECORD:C212([QQQCarrier:11])