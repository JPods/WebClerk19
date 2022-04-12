QUERY:C277([LoadItem:87]; [LoadItem:87]LoadTagID:8=[LoadTag:88]idUnique:1)
$notLocked:=True:C214
$cntRecs:=Records in selection:C76([LoadItem:87])
FIRST RECORD:C50([LoadItem:87])
For ($incRecs; 1; $cntRecs)
	LOAD RECORD:C52([LoadItem:87])
	If (Locked:C147([LoadItem:87]))
		$notLocked:=False:C215
		$incRecs:=$cntRecs
		ALERT:C41("At least one LoadItems record is locked.")
	End if 
End for 
If ($notLocked)
	[LoadTag:88]invoiceNum:19:=0
	[LoadTag:88]Status:6:="Pending"
	FIRST RECORD:C50([LoadItem:87])
	For ($incRecs; 1; $cntRecs)
		[LoadItem:87]CustPONum:17:=""
		[LoadItem:87]invoiceNum:14:=0
		SAVE RECORD:C53([LoadItem:87])
		NEXT RECORD:C51([LoadItem:87])
	End for 
	SAVE RECORD:C53([LoadTag:88])
End if 