//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: ItemXRefRefresh
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([ItemXRef:22])
ORDER BY:C49([ItemXRef:22]; [ItemXRef:22]itemNumMaster:1)
FIRST RECORD:C50([ItemXRef:22])
For ($i; 1; $k)
	If ([ItemXRef:22]itemNumXRef:2#[Item:4]itemNum:1)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemXRef:22]itemNumXRef:2)
	End if 
	If (Records in selection:C76([Item:4])=1)
		[ItemXRef:22]descriptionXRef:3:=[Item:4]description:7
		[ItemXRef:22]cost:7:=[Item:4]costAverage:13
		[ItemXRef:22]priceA:20:=[Item:4]priceA:2
		[ItemXRef:22]priceB:21:=[Item:4]priceB:3
		[ItemXRef:22]priceC:22:=[Item:4]priceC:4
		[ItemXRef:22]priceD:23:=[Item:4]priceD:5
		[ItemXRef:22]publish:19:=[Item:4]publish:60
		[ItemXRef:22]typeid:9:=[Item:4]typeid:26
		[ItemXRef:22]mfrID:25:=[Item:4]mfrID:53
		[ItemXRef:22]specid:26:=[Item:4]specid:62
	Else 
		[ItemXRef:22]typeid:9:="orphan"
		[ItemXRef:22]mfrID:25:="orphan"
	End if 
	SAVE RECORD:C53([ItemXRef:22])
	NEXT RECORD:C51([ItemXRef:22])
End for 