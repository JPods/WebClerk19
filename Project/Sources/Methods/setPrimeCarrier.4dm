//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-05-28T00:00:00, 14:39:32
// ----------------------------------------------------
// Method: setPrimeCarrier
// Description
// Modified: 05/28/15
// 
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($i; $k)
C_TEXT:C284($ShipZip)


READ ONLY:C145([QQQCarrier:11])
<>aShipVia:=1
jCenterWindow(108; 144; 1)
DIALOG:C40([QQQCarrier:11]; "diaSetPrime")
CLOSE WINDOW:C154
If (myOK=1)
	QUERY:C277([QQQCustomer:2])
	If ((OK=1) & (Records in selection:C76([QQQCustomer:2])>0))
		QUERY:C277([QQQCarrier:11]; [QQQCarrier:11]Active:6=True:C214; *)
		QUERY:C277([QQQCarrier:11];  & [QQQCarrier:11]CarrierID:10=<>aShipVia{<>aShipVia})
		CREATE EMPTY SET:C140([QQQCustomer:2]; "PrimeNot")
		FIRST RECORD:C50([QQQCustomer:2])
		$k:=Records in selection:C76([QQQCustomer:2])
		For ($i; 1; $k)
			MESSAGE:C88("Processing Customer Record "+String:C10($i)+" of "+String:C10($k)+".")
			LOAD RECORD:C52([QQQCustomer:2])
			If (Not:C34(Locked:C147([QQQCustomer:2])))
				$ShipZip:=Substring:C12([QQQCustomer:2]zip:8; 1; [QQQCarrier:11]ZipLength:19)
				QUERY:C277([CarrierZone:143]; [CarrierZone:143]CarrierID:7=[QQQCarrier:11]CarrierID:10; *)
				QUERY:C277([CarrierZone:143];  & [CarrierZone:143]ZipLow:1>=$ShipZip; *)
				QUERY:C277([CarrierZone:143];  & [CarrierZone:143]ZipHigh:2<=$ShipZip)
				If (Records in selection:C76([CarrierZone:143])>0)
					If (Records in selection:C76([CarrierZone:143])>1)
						ORDER BY:C49([CarrierZone:143]; [CarrierZone:143]ZipLow:1)
					End if 
					[QQQCustomer:2]zone:57:=[CarrierZone:143]Zone:3
					[QQQCustomer:2]shipVia:12:=[QQQCarrier:11]CarrierID:10
					SAVE RECORD:C53([QQQCustomer:2])
				Else 
					ADD TO SET:C119([QQQCustomer:2]; "PrimeNot")
				End if 
			Else 
				ADD TO SET:C119([QQQCustomer:2]; "PrimeNot")
			End if 
			NEXT RECORD:C51([QQQCustomer:2])
		End for 
		USE SET:C118("PrimeNot")
		CLEAR SET:C117("PrimeNot")
		If (Records in set:C195("PrimeNot")>0)
			ALERT:C41("There were "+String:C10(Records in set:C195("PrimeNot"))+" which were not changed.  Show Current Selection to view this Customers.")
		End if 
	End if 
End if 
READ WRITE:C146([QQQCarrier:11])
<>aShipVia:=1

REDRAW WINDOW:C456