//%attributes = {"publishedWeb":true}
//Method: Item_New
C_LONGINT:C283($1)
C_TEXT:C284($2; $3; $itemNum; $typeID)  //itemNun; typeID
C_REAL:C285($4; $5; $qtySale; $bundleQty)
$bundleQty:=1
$qtySale:=1
$typeID:=""
If (Count parameters:C259=0)
	$itemNum:=vPartNum
Else 
	If (Count parameters:C259>0)
		$itemNum:=vPartNum
		If (Count parameters:C259>1)
			$itemNum:=$2
			If (Count parameters:C259>2)
				$typeID:=$3
				If (Count parameters:C259>3)
					$qtySale:=$4
					If (Count parameters:C259>4)
						$bundleQty:=$5
					End if 
				End if 
			End if 
		End if 
	End if 
End if 
[Item:4]qtySaleDefault:15:=1
[Item:4]tallyByType:19:=True:C214
If (($itemNum#"") & ($itemNum#"zzz"))
	[Item:4]itemNum:1:=$itemNum
	vPartNum:=""
	OBJECT SET ENTERABLE:C238(srItemNum; False:C215)
Else 
	[Item:4]itemNum:1:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Item:4]))
	OBJECT SET ENTERABLE:C238(srItemNum; True:C214)
End if 
[Item:4]barCode:34:=[Item:4]itemNum:1
[Item:4]commissionA:29:=100
[Item:4]commissionB:30:=100
[Item:4]commissionC:31:=100
[Item:4]commissionD:32:=100
[Item:4]discountable:28:=True:C214
[Item:4]taxID:17:="tax"
[Item:4]printNot:112:=1
[Item:4]description:7:="Enter a Description"  // ### jwm ### 20171219_1537
HIGHLIGHT TEXT:C210([Item:4]description:7; 1; 35)  // ### jwm ### 20171219_1539

If ($typeID#"")
	[Item:4]type:26:=$typeID
	READ ONLY:C145([GLAccount:53])
	QUERY:C277([GLAccount:53]; [GLAccount:53]fileRefNum:2=4; *)
	QUERY:C277([GLAccount:53];  & [GLAccount:53]typeID:3=[Item:4]type:26)
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([GLAccount:53])
	FIRST RECORD:C50([GLAccount:53])
	For ($i; 1; $k)
		Case of 
			: (([GLAccount:53]typeAcct:5="Inco@") | ([GLAccount:53]typeAcct:5="Rev@"))
				[Item:4]salesGlAccount:21:=[GLAccount:53]account:1
			: (([GLAccount:53]typeAcct:5="Cost@") | ([GLAccount:53]typeAcct:5="CoG@") | ([GLAccount:53]typeAcct:5="Exp@"))
				[Item:4]costGLAccount:22:=[GLAccount:53]account:1
			: (([GLAccount:53]typeAcct:5="Current ass@") | ([GLAccount:53]typeAcct:5="Ass@"))
				[Item:4]inventoryGlAccount:23:=[GLAccount:53]account:1
		End case 
		NEXT RECORD:C51([GLAccount:53])
	End for 
	READ WRITE:C146([GLAccount:53])
	REDUCE SELECTION:C351([GLAccount:53]; 0)
End if 
If ([Item:4]salesGlAccount:21="")
	READ ONLY:C145([DefaultAccount:32])
	GOTO RECORD:C242([DefaultAccount:32]; 0)
	[Item:4]salesGlAccount:21:=[DefaultAccount:32]itemSalesAcct:24
	[Item:4]costGLAccount:22:=[DefaultAccount:32]itemCostofGoods:25
	[Item:4]inventoryGlAccount:23:=[DefaultAccount:32]itemInventory:26
	UNLOAD RECORD:C212([DefaultAccount:32])
	READ WRITE:C146([DefaultAccount:32])
End if 
If ($1=1)
	OBJECT SET ENTERABLE:C238([Item:4]itemNum:1; True:C214)
	OBJECT SET ENTERABLE:C238([Item:4]costAverage:13; True:C214)
	OBJECT SET ENTERABLE:C238([Item:4]barCode:34; True:C214)
	OBJECT SET ENTERABLE:C238([Item:4]qtyOnHand:14; True:C214)
End if 