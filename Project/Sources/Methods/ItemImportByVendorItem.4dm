//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: ItemImportByVendorItem
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
CLOSE DOCUMENT:C267(myDoc)
CLOSE DOCUMENT:C267(sumDoc)
If (Count parameters:C259=1)
	$myDoc:=$1
Else 
	$myDoc:=""
End if 
myDoc:=Open document:C264($myDoc)
If (OK=1)
	$docShortName:=HFS_ShortName(document)
	$docParent:=HFS_ParentName(document)
	sumDoc:=Create document:C266($docParent+"vendErr"+$docShortName)
	RECEIVE PACKET:C104(myDoc; $theLine; "\r")  //clear header
	Repeat 
		RECEIVE PACKET:C104(myDoc; $theLine; "\r")
		If (OK=1)
			TextToArray($theLine; ->aText5; "\t"; True:C214)
			QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=aText5{1}; *)
			QUERY:C277([Item:4];  & [Item:4]vendorID:45=aText5{2})
			If (Records in selection:C76([Item:4])=1)
				[Item:4]costLastInShip:47:=Num:C11(aText5{3})
				[Item:4]priceA:2:=Num:C11(aText5{4})
				//
				[Item:4]mfrID:53:=aText5{5}
				[Item:4]mfrName:91:=aText5{6}
				[Item:4]mfrItemNum:39:=aText5{7}
				// [Item]Description:=aText5{8}
				[Item:4]indicator1:95:=Num:C11(aText5{9})
				[Item:4]dtReviewed:85:=DateTime_Enter(Date:C102("1/1/"+aText5{10}))
				[Item:4]publish:60:=Num:C11(aText5{11})
				[Item:4]indicator1:95:=Num:C11(aText5{12})
				
			Else 
				SEND PACKET:C103(sumDoc; $theLine+"\r")
			End if 
		End if 
	Until (OK=0)
	CLOSE DOCUMENT:C267(myDoc)
	CLOSE DOCUMENT:C267(sumDoc)
End if 
