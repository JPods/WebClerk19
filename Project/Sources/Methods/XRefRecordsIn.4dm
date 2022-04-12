//%attributes = {"publishedWeb":true}


// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)
// 
// If (False)
//   //Method: XRefRecordsIn
//   //Date: 03/11/03
//   //Who: Bill
//   //Description: 
// End if 
// CLOSE DOCUMENT(myDoc)
// 
// If (False)
// C_LONGINT($i;$k;$incXRef;$cntXRef)
// C_Longint($i;$k;$baseCondition;$xRefStart)
// If (Count parameters>0)
// myDocName:=$1
// Else 
// myDocName:=""
// End if 
// myDoc:=Open document(myDocName)
// TRACE
// If (OK=1)
// $dtNow:=DateTime_Enter 
// Repeat 
// RECEIVE PACKET(myDoc;$theText;"\r")
// If (OK=1)
// $baseItem:=""
// $baseRelation:=0
// $baseDescription:=""
// TextToArray ($theText;->aText8;"\t")
// $k:=Size of array(aText8)
// If ($k>3)
// $w:=XMLFindInArray ("<XRefRelation>";->aText8)+1
// If ($w>1)
// $baseRelation:=Num(aText8{$w})
// End if 
// $xRefStart:=XMLFindInArray ("<XRef>";->aText8)+1
// $xRefEnd:=XMLFindInArray ("</XRef>";->aText8)-1
// If (($xRefEnd-$xRefStart>0) & ($xRefStart>1))  //&($xRefEnd>0))
// $baseItem:=aText8{$xRefStart}
// End if 
// If (($baseItem#"") & ($baseRelation>0))
// $w:=XMLFindInArray ("<Description>";->aText8)+1
// If ($w>1)
// $baseDescription:=aText8{$w}
// End if 
// QUERY([Item];[Item]ItemNum=$baseItem)
// If (Records in selection([Item])=1)
// If ($baseDescription="")
// $baseDescription:=[Item]Description
// End if 
// If ($baseRelation=9)
// QUERY([ItemXRef];[ItemXRef]ItemNumMaster=$baseItem)
// If (Records in selection([ItemXRef])>0)
// DELETE SELECTION([ItemXRef])
// End if 
// End if 
// $startPoint:=$xRefStart+1  //step over base item
// For ($i;$startPoint;$xRefEnd)
// QUERY([Item];[Item]ItemNum=aText8{$i})
// If (Records in selection([Item])=1)
// QUERY([ItemXRef];[ItemXRef]ItemNumMaster=$baseItem;*)
// QUERY([ItemXRef]; & [ItemXRef]ItemNumXRef=aText8{$i})
// End if 
// $cntXRef:=Records in selection([ItemXRef])
// Case of 
// : ($cntXRef=1)
//   //do nothing
// [ItemXRef]ItemNumMaster:=$baseItem
// [ItemXRef]DescriptionMaster:=$baseDescription
// [ItemXRef]ItemNumXRef:=[Item]ItemNum
// [ItemXRef]DescriptionXRef:=[Item]Description
// [ItemXRef]Cost:=[Item]PriceA
// [ItemXRef]XRefLinked:=0
// [ItemXRef]PriceA:=[Item]PriceA
// [ItemXRef]PriceB:=[Item]PriceB
// [ItemXRef]PriceC:=[Item]PriceC
// [ItemXRef]PriceD:=[Item]PriceD
// [ItemXRef]Publish:=[Item]Publish
// SAVE RECORD([ItemXRef])
// : ($cntXRef>1)
// FIRST RECORD([ItemXRef])
// For ($incXRef;1;$cntXRef)
// [ItemXRef]Action:="too many"
// SAVE RECORD([ItemXRef])
// NEXT RECORD([ItemXRef])
// End for 
// Else 
// CREATE RECORD([ItemXRef])
// 
// [ItemXRef]ItemNumMaster:=$baseItem
// [ItemXRef]DescriptionMaster:=$baseDescription
// [ItemXRef]ItemNumXRef:=aText8{$i}
// [ItemXRef]DescriptionXRef:=[Item]Description
// [ItemXRef]Cost:=[Item]PriceA
// [ItemXRef]XRefLinked:=0
// [ItemXRef]PriceA:=[Item]PriceA
// [ItemXRef]PriceB:=[Item]PriceB
// [ItemXRef]PriceC:=[Item]PriceC
// [ItemXRef]PriceD:=[Item]PriceD
// [ItemXRef]Publish:=[Item]Publish
// SAVE RECORD([ItemXRef])
// End case 
// End for 
// End if 
// End if 
// End if 
// End if 
// Until (OK=0)
// End if 
// 
// End if 
// 
// 
// TRACE
// 
// C_LONGINT($i;$k;$incXRef;$cntXRef)
// C_Longint($i;$k;$baseCondition;$xRefStart)
// If (Count parameters>0)
// myDocName:=$1
// Else 
// myDocName:=""
// End if 
// myDoc:=Open document(myDocName)
// TRACE
// If (OK=1)
// vText1:=""
// $dtNow:=DateTime_Enter 
// Repeat 
// RECEIVE PACKET(myDoc;$theText;"\r")
// If (OK=1)
// $baseItem:=""
// $baseRelation:=0
// $baseDescription:=""
// TextToArray ($theText;->aText8;"\t")
// $k:=Size of array(aText8)-1
// If ($k>0)
// $baseItem:=aText8{1}
// QUERY([Item];[Item]ItemNum=$baseItem)
// If (Records in selection([Item])=0)
// vText1:=vText1+$baseItem+"\r"
// Else 
// ALL SUBRECORDS([Item]RelatedDetails)
// QUERY SUBRECORDS([Item]RelatedDetails;=22)
// If (Records in sub_selection([Item]RelatedDetails)=0)
// CREATE SUBRECORD([Item]RelatedDetails)
// :=22
// SAVE RECORD([Item])
// End if 
// DELETE FROM ARRAY(aText8;1;1)
// $baseDescription:=[Item]Description
// For ($i;1;$k)
// QUERY([ItemXRef];[ItemXRef]ItemNumMaster=$baseItem;*)
// QUERY([ItemXRef]; & [ItemXRef]ItemNumXRef=aText8{$i})
// Case of 
// : (Records in selection([ItemXRef])>1)
// REDUCE SELECTION([ItemXRef];Records in selection([ItemXRef])-1)
// DELETE SELECTION([ItemXRef])
// QUERY([ItemXRef];[ItemXRef]ItemNumMaster=$baseItem;*)
// QUERY([ItemXRef];[ItemXRef]ItemNumXRef=aText8{$i})
// : (Records in selection([ItemXRef])=0)
// CREATE RECORD([ItemXRef])
// 
// [ItemXRef]ItemNumMaster:=$baseItem
// [ItemXRef]ItemNumXRef:=aText8{$i}
// End case 
// QUERY([Item];[Item]ItemNum=aText8{$i})
// If (Records in selection([Item])=0)
// [ItemXRef]DescriptionXRef:="missing ItemRec"
// End if 
// [ItemXRef]DescriptionMaster:=$baseDescription
// [ItemXRef]ItemNumXRef:=aText8{$i}
// [ItemXRef]Cost:=[Item]CostAverage
// [ItemXRef]XRefLinked:=0
// [ItemXRef]PriceA:=[Item]PriceA
// [ItemXRef]PriceB:=[Item]PriceB
// [ItemXRef]PriceC:=[Item]PriceC
// [ItemXRef]PriceD:=[Item]PriceD
// [ItemXRef]Publish:=[Item]Publish
// [ItemXRef]DescriptionXRef:=[Item]Description
// SAVE RECORD([ItemXRef])
// End for 
// End if 
// End if 
// End if 
// Until (OK=0)
// CLOSE DOCUMENT(myDoc)
// If (vText1#"")
// SET TEXT TO PASTEBOARD(vText1)
// End if 
// End if 
// 