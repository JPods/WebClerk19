//%attributes = {"publishedWeb":true}
//ORDER BY([InvStack];[InvStack]ReceiptID;[InvStack]DocID)
//vi2:=Size of array(aTmpLong1)
//FIRST RECORD([InvStack])
//vi9:=0//ReceiptNum
//vi8:=0//PONum
//For (vi1;1;vi2)
//vi7:=Size of array(aTmpLong1)+1
//INSERT ELEMENT(aTmpLong1;vi7;1)
//INSERT ELEMENT(aTmpLong2;vi7;1)
//INSERT ELEMENT(aTmpLong3;vi7;1)
//INSERT ELEMENT(aTmpLong4;vi7;1)
//INSERT ELEMENT(aTmpLong1;vi7;1)
//INSERT ELEMENT(aTmpLong1;vi7;1)
//INSERT ELEMENT(aTmpLong1;vi7;1)
//aTmpLong1{vi7}:=[InvStack]ReceiptID
//aTmpLong2{vi7}:=[InvStack]DocID
//aTmpLong3{vi7}:=[InvStack]ReceiptID
//aTmpLong4{vi7}:=[InvStack]ReceiptID
//aTmpLong5{vi7}:=[InvStack]ReceiptID
//
//
//
//If (vi8#[InvStack]DocID)
//vi8:=[InvStack]DocID
//QUERY(
