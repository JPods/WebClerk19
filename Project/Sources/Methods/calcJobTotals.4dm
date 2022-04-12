//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $ii; $k)
C_REAL:C285($value)
C_POINTER:C301($ptFile; $ptFileAmt; $ptAmt)
For ($ii; 1; 5)
	Case of 
		: ($ii=1)
			$ptFile:=->[Order:3]
			$ptFileAmt:=->[Order:3]amount:24
			$ptAmt:=->[Project:24]orderTotal:6
		: ($ii=2)
			$ptFile:=->[Invoice:26]
			$ptFileAmt:=->[Invoice:26]amount:14
			$ptAmt:=->[Project:24]invoiceTotal:7
		: ($ii=3)
			$ptFile:=->[PO:39]
			$ptFileAmt:=->[PO:39]amount:19
			$ptAmt:=->[Project:24]poTotal:8
		: ($ii=4)
			$ptFile:=->[Proposal:42]
			$ptFileAmt:=->[Proposal:42]amount:26
			$ptAmt:=->[Project:24]proposalTotal:5
		: ($ii=5)
			$ptFile:=->[InventoryStack:29]
			$ptFileAmt:=->[InventoryStack:29]ExtendedCost:17
			$ptAmt:=->[Project:24]inventoryTotal:12
	End case 
	$k:=Records in selection:C76($ptFile->)
	$value:=0
	FIRST RECORD:C50($ptFile->)
	For ($i; 1; $k)
		$value:=$value+$ptFileAmt->
		NEXT RECORD:C51($ptFile->)
	End for 
	$ptAmt->:=$value
End for 