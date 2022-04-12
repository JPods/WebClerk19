//%attributes = {"publishedWeb":true}
$k:=Records in selection:C76([Item:4])
SELECTION TO ARRAY:C260([Item:4]; aTmpLong1)
UNLOAD RECORD:C212([Item:4])
For ($i; 1; $k)
	GOTO RECORD:C242([Item:4]; aTmpLong1{$i})
	If (([Item:4]countBulk:84>1) & ([Item:4]class:92#"FromBulk"))
		If (Length:C16([Item:4]itemNum:1)>32)
			ALERT:C41("ItemNum has too many characters: "+[Item:4]itemNum:1)
		Else 
			pvItemNum:=[Item:4]itemNum:1
			PUSH RECORD:C176([Item:4])
			QUERY:C277([Item:4]; [Item:4]itemNum:1="BLK"+pvItemNum)
			If (Records in selection:C76([Item:4])=0)
				POP RECORD:C177([Item:4])
				//
				CREATE RECORD:C68([BOM:21])
				[BOM:21]ItemNum:1:=pvItemNum
				[BOM:21]ChildItem:2:="BLK"+pvItemNum
				[BOM:21]Description:6:=[Item:4]description:7
				[BOM:21]QtyInAssembly:3:=Round:C94(1/[Item:4]countBulk:84; 5)
				
				
				SAVE RECORD:C53([BOM:21])
				DUPLICATE RECORD:C225([Item:4])
				//
				[Item:4]itemNum:1:="BLK"+pvItemNum
				[Item:4]countBulk:84:=1
				[Item:4]qtyOnHand:14:=0
				[Item:4]qtySaleDefault:15:=1
				[Item:4]qtyAllocated:72:=0
				[Item:4]qtyBundleSell:79:=0
				[Item:4]qtyBundleSell:79:=0
				[Item:4]qtyBundleSell:79:=0
				[Item:4]qtyOnHand:14:=0
				SAVE RECORD:C53([Item:4])
				
				//
				GOTO RECORD:C242([Item:4]; aTmpLong1{$i})
				$bulkCnt:=[Item:4]countBulk:84
				[Item:4]qtyOnHand:14:=Round:C94([Item:4]qtyOnHand:14*$bulkCnt; 2)
				[Item:4]qtyOnHand:14:=0
				[Item:4]countBulk:84:=1
				[Item:4]unitOfMeasure:11:="each"
				[Item:4]costAverage:13:=Round:C94([Item:4]costAverage:13/vR1; 2)
				[Item:4]weightAverage:8:=Round:C94([Item:4]weightAverage:8/vR1; 2)
				[Item:4]qtySaleDefault:15:=1
				[Item:4]bomHasChild:48:=True:C214
				SAVE RECORD:C53([Item:4])
				
			Else 
				POP RECORD:C177([Item:4])
			End if 
		End if 
	End if 
End for 