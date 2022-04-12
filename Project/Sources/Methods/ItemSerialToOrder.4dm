//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-11-27T00:00:00, 16:13:32
// ----------------------------------------------------
// Method: ItemSerialToOrder
// Description
// Modified: 11/27/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------

Process_InitLocal
C_BOOLEAN:C305(allowAlerts_boo)
C_LONGINT:C283(myCycle; vHere)
C_LONGINT:C283(vi1; vi2; vi10)
C_POINTER:C301(ptCurTable)
allowAlerts_boo:=False:C215
ptCurTable:=(->[Order:3])
<>vbDoSrlNums:=True:C214
myCycle:=3
READ WRITE:C146([ItemSerial:47])
START TRANSACTION:C239
SET QUERY AND LOCK:C661(True:C214)
QUERY:C277([ItemSerial:47]; [ItemSerial:47]invoiceNum:10=-5)
If (OK=1)  // no locked records  (records in set("LockedSet")=0)
	CREATE EMPTY SET:C140([Order:3]; "Current")
	vi2:=Records in selection:C76([ItemSerial:47])
	ALERT:C41("Warranties: "+String:C10(vi2))
	ORDER BY:C49([ItemSerial:47]; [ItemSerial:47]vendorID:5; [ItemSerial:47]description:2)
	FIRST RECORD:C50([ItemSerial:47])
	vText10:=""
	REDUCE SELECTION:C351([Order:3]; 0)  // make sure there is not a random order selected
	For (vi1; 1; vi2)
		If ([Customer:2]customerID:1#[ItemSerial:47]vendorID:5)
			If (vi1>1)
				vMod:=True:C214
				booAccept:=True:C214
				acceptOrders
				ADD TO SET:C119([Order:3]; "Current")
			End if 
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[ItemSerial:47]vendorID:5)
			REDUCE SELECTION:C351([Order:3]; 0)
			NxPvOrders
		End if 
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemSerial:47]itemNum:1)
		
		[Item:4]qtySaleDefault:15:=1  // assure that it is one to match the serialized item.
		listItemsFill(->[Order:3]; True:C214)  //;$doReplace)
		vi9:=Size of array:C274(aOSerialNm)
		
		aODescpt{vi9}:=aODescpt{vi9}+" "+[ItemSerial:47]customerName:43
		ALERT:C41("Warranty: "+aODescpt{vi9})
		aOSerialNm{vi9}:=[ItemSerial:47]serialNum:4
		aOSerialRc{vi9}:=1
		[ItemSerial:47]invoiceNum:10:=-3
		SAVE RECORD:C53([ItemSerial:47])
		NEXT RECORD:C51([ItemSerial:47])
	End for 
	vMod:=True:C214
	booAccept:=True:C214
	acceptOrders
	ADD TO SET:C119([Order:3]; "Current")
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	ProcessTableOpen(Table:C252(->[Order:3]); ""; "Warranties")
Else 
	ALERT:C41("There are locked records: "+String:C10(Records in set:C195("LockedSet"))+".")
End if 
REDUCE SELECTION:C351([Order:3]; 0)  // make sure there is not a random order selected
REDUCE SELECTION:C351([ItemSerial:47]; 0)  // make sure there is not a random order selected
REDUCE SELECTION:C351([Customer:2]; 0)  // make sure there is not a random order selected
REDUCE SELECTION:C351([OrderLine:49]; 0)  // make sure there is not a random order selected
REDUCE SELECTION:C351([Item:4]; 0)  // make sure there is not a random order selected

SET QUERY AND LOCK:C661(False:C215)
VALIDATE TRANSACTION:C240
allowAlerts_boo:=True:C214