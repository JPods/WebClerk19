//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Method: XRefItem_Fill
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_TEXT:C284($1; $2; $curItemNum; $curItemDesc)
If ([ItemXRef:22]idNum:28=0)
	
End if 
[ItemXRef:22]itemNumMaster:1:=$1
[ItemXRef:22]descriptionMaster:8:=$2
[ItemXRef:22]itemNumXRef:2:=[Item:4]itemNum:1
[ItemXRef:22]descriptionXRef:3:=[Item:4]description:7
[ItemXRef:22]cost:7:=[Item:4]priceA:2
[ItemXRef:22]xRefLinked:17:=1
[ItemXRef:22]priceA:20:=[Item:4]priceA:2
[ItemXRef:22]priceB:21:=[Item:4]priceB:3
[ItemXRef:22]priceC:22:=[Item:4]priceC:4
[ItemXRef:22]priceD:23:=[Item:4]priceD:5
[ItemXRef:22]publish:19:=[Item:4]publish:60
[ItemXRef:22]typeid:9:=[Item:4]typeid:26
[ItemXRef:22]mfrID:25:=[Item:4]mfrID:53