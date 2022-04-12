//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: ItemExpanderFill
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//

C_TEXT:C284($1; $itemNum)
$itemNum:=$1
C_TEXT:C284($2; $3; $4; $5)  //SKUadd, DescrptAdd;

QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)
$masterItemNum:=[Item:4]itemNum:1
$masterDesc:=[Item:4]description:7
$recNum:=Record number:C243([Item:4])
QUERY:C277([Item:4]; [Item:4]itemNum:1=$masterItemNum+$2)
If (Records in selection:C76([Item:4])=0)
	GOTO RECORD:C242([Item:4]; $recNum)
	DUPLICATE RECORD:C225([Item:4])
	[Item:4]itemNum:1:=$masterItemNum+$2
	[Item:4]description:7:=$masterDesc+", "+$3
	[Item:4]profile5:93:="Expanded"
	SAVE RECORD:C53([Item:4])
End if 
$seq:=0
QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumMaster:1=$masterItemNum; *)
QUERY:C277([ItemXRef:22];  & [ItemXRef:22]itemNumXRef:2=[Item:4]itemNum:1)
If (Records in selection:C76([ItemXRef:22])=0)
	CREATE RECORD:C68([ItemXRef:22])
	
	$seq:=$seq+1
	[ItemXRef:22]itemNumMaster:1:=$masterItemNum
	[ItemXRef:22]itemNumXRef:2:=[Item:4]itemNum:1
	[ItemXRef:22]descriptionMaster:8:=$masterDesc
	[ItemXRef:22]descriptionXRef:3:=[Item:4]description:7
	[ItemXRef:22]relationship:27:=$4
	[ItemXRef:22]seq:24:=$seq+1
	[ItemXRef:22]skuComponents:29:=$5
	[ItemXRef:22]siteid:11:="Dup"
	//aText5{2}+"//"+aText5{5}+", "+aText5{3}+"//"+aText5{4}
	SAVE RECORD:C53([ItemXRef:22])
End if 