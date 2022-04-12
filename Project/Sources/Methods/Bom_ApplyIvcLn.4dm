//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/21/13, 12:20:01
// ----------------------------------------------------
// Method: Bom_ApplyIvcLn
// Description
// File: Bom_ApplyIvcLn.txt
// Parameters
// ----------------------------------------------------
//### jwm ### 20130321_1229 changed <>tcsiteID to [InvoiceLine]siteID
//### jwm ### 20130321_1230 changed <>tcsiteID to [InvoiceLine]siteID
If (UserInPassWordGroup("Costing"))
	C_LONGINT:C283($i; $k; $e; $f; $totalCnt)
	C_TEXT:C284($partNum)
	C_REAL:C285($qtyTotal)
	CONFIRM:C162("Are you sure, changes CANNOT be undone?")
	If (OK=1)
		ORDER BY:C49([InvoiceLine:54]itemNum:4)
		$i:=0
		$k:=Records in selection:C76([InvoiceLine:54])
		FIRST RECORD:C50([InvoiceLine:54])
		While ($i<$k)
			$totalCnt:=0
			$partNum:=[InvoiceLine:54]itemNum:4
			Repeat 
				$i:=$i+1
				$totalCnt:=$totalCnt+[InvoiceLine:54]qtyShipped:7
				NEXT RECORD:C51([InvoiceLine:54])
			Until ([InvoiceLine:54]itemNum:4#$partNum)
			QUERY:C277([BOM:21]; [BOM:21]itemNum:1=$partNum)
			$f:=Records in selection:C76([BOM:21])
			If ($f>0)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=$partNum)
				If (Records in selection:C76([Item:4])>0)
					QUERY:C277([BOM:21]; [BOM:21]itemNum:1=$partNum)
					BOM_BuildExtend($partNum)
					Bom_CostItems
					Invt_dRecCreate("BM"; [BOM:21]idNum:10; 0; "BOM"; 0; "Build by BOM"; 1; 0; $partNum; -$totalCnt; 0; vr1; ""; vsiteID; 0)
					FIRST RECORD:C50([BOM:21])
					For ($e; 1; $f)
						$qtyTotal:=[BOM:21]qtyInAssembly:3*$totalCnt*-1
						QUERY:C277([Item:4]; [Item:4]itemNum:1=$partNum)
						/// QQQ
						// ### bj ### 20210213_2006 replaced with [BOM]UniqueID
						Invt_dRecCreate("BM"; [BOM:21]idNum:10; 0; "BOM"; 0; $partNum; 1; 0; [BOM:21]childItem:2; $qtyTotal; 0; [Item:4]costAverage:13; ""; vsiteID; 0)
						NEXT RECORD:C51([BOM:21])
					End for 
				End if 
			End if 
		End while 
		INVT_dInvtApply
	End if 
End if 