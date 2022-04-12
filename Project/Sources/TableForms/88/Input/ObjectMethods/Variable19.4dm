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
	QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[LoadTag:88]invoiceNum:19)
	[LoadTag:88]CustPONum:37:=[Invoice:26]customerPoNum:29
	[LoadTag:88]Status:6:="Shipped"
	SAVE RECORD:C53([LoadTag:88])
	FIRST RECORD:C50([LoadItem:87])
	For ($incRecs; 1; $cntRecs)
		[LoadItem:87]CustPONum:17:=[LoadTag:88]CustPONum:37
		[LoadItem:87]invoiceNum:14:=[LoadTag:88]invoiceNum:19
		SAVE RECORD:C53([LoadItem:87])
		NEXT RECORD:C51([LoadItem:87])
	End for 
	
End if 