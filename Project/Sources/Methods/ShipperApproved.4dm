//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/06/17, 14:45:01
// ----------------------------------------------------
// Method: ShipperApproved
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20171206_1542 named selection automatically keeps sort order and selectted record

C_LONGINT:C283($i; $k)
C_TEXT:C284($myCarrier)
If ([QQQCarrier:11]Active:6=True:C214)
	TRACE:C157
	C_BOOLEAN:C305($markActive; $doSortCheck)
	$markActive:=True:C214
	$doSortCheck:=False:C215
	C_LONGINT:C283($selectRec)
	$selectRec:=[QQQCarrier:11]idUnique:44
	//CREATE SET([Carrier];"Current")
	COPY NAMED SELECTION:C331([QQQCarrier:11]; "Current")  // ### jwm ### 20171206_1542 named selection automatically keeps sort order and selectted record
	$myCarrier:=[QQQCarrier:11]CarrierID:10
	PUSH RECORD:C176([QQQCarrier:11])
	QUERY:C277([QQQCarrier:11]; [QQQCarrier:11]CarrierID:10=$myCarrier; *)
	QUERY:C277([QQQCarrier:11];  & [QQQCarrier:11]Active:6=True:C214)
	If (Records in selection:C76([QQQCarrier:11])>0)
		CONFIRM:C162("Dissapprove the other approved record for "+[QQQCarrier:11]CarrierID:10+".")
		If (Ok=1)
			FIRST RECORD:C50([QQQCarrier:11])
			$k:=Records in selection:C76([QQQCarrier:11])
			For ($i; 1; $k)
				If ([QQQCarrier:11]idUnique:44#$selectRec)  // ### jwm ### 20171206_1550 skip selected carrier record
					If (Locked:C147([QQQCarrier:11]))  // ### jwm ### 20170719_0002  
						ALERT:C41("Carrier Record Locked")
						$markActive:=False:C215
					Else 
						[QQQCarrier:11]Active:6:=False:C215
						SAVE RECORD:C53([QQQCarrier:11])
					End if 
				End if 
				NEXT RECORD:C51([QQQCarrier:11])
			End for 
		Else 
			$markActive:=False:C215
		End if 
	End if 
	POP RECORD:C177([QQQCarrier:11])
	[QQQCarrier:11]Active:6:=$markActive
	SAVE RECORD:C53([QQQCarrier:11])
	//USE SET("Current")
	USE NAMED SELECTION:C332("Current")
	CLEAR NAMED SELECTION:C333("Current")
	// ### jwm ### 20150720_1926 QQQQQQQQ
	If ((booSorted) & (False:C215))  // ### jwm ### 20150422_1044 where is booSorted set?
		jCancelButton
	Else 
		//GOTO SELECTED RECORD([Carrier];$selectRec)
	End if 
	//CLEAR SET("Current")
End if 