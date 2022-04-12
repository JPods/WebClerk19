//%attributes = {"publishedWeb":true}
////Method: WnOp_ImportWine
//myDoc:=Open document("")
//If (OK=1)
//ARRAY TEXT($aIncoming; 11)
//RECEIVE PACKET(myDoc; $aIncoming{1}; "\r")
//If (OK=1)
//Repeat 
//RECEIVE PACKET(myDoc; $aIncoming{1}; "\t")  //sku
//RECEIVE PACKET(myDoc; $aIncoming{2}; "\t")  //wine
//RECEIVE PACKET(myDoc; $aIncoming{3}; "\t")  //vintage
//RECEIVE PACKET(myDoc; $aIncoming{4}; "\t")  //Quantity
//RECEIVE PACKET(myDoc; $aIncoming{5}; "\t")  //US_price
//RECEIVE PACKET(myDoc; $aIncoming{6}; "\t")  //native_Price
//RECEIVE PACKET(myDoc; $aIncoming{7}; "\t")  //native_Currency
//RECEIVE PACKET(myDoc; $aIncoming{8}; "\t")  //supplier
//RECEIVE PACKET(myDoc; $aIncoming{9}; "\t")  //case_size
//RECEIVE PACKET(myDoc; $aIncoming{10}; "\t")  //bottle_volume
//RECEIVE PACKET(myDoc; $aIncoming{11}; "\r")  //offer_date
//If (OK=1)
//If (Character code($aIncoming{1})=10)
//$aIncoming{1}:=Substring($aIncoming{1}; 2)
//End if 
//QUERY([Item]; [Item]itemNum=$aIncoming{1})
//If (Records in selection([Item])=0)
//CREATE RECORD([Item])
//Item_New(1; $aIncoming{1}; ""; 1; 1)
//SAVE RECORD([Item])
//[Item]publish:=1
//End if 
//QUERY([ItemSpec]; [ItemSpec]itemNum=[Item]itemNum)
//If (Records in selection([ItemSpec])=0)
//CREATE RECORD([ItemSpec])

//[ItemSpec]itemNum:=[Item]itemNum
//SAVE RECORD([ItemSpec])
//End if 
//[Item]description:=$aIncoming{2}
//[Item]profile2:=$aIncoming{3}
//[Item]qtyVi:=Num($aIncoming{4})
//[Item]costLastInShip:=Num($aIncoming{5})+10
//[Item]priceA:=[Item]costLastInShip*1.2
//[Item]priceB:=Round([Item]priceA*0.95; 2)
//[Item]priceC:=Round([Item]priceA*0.9; 2)
//[Item]priceD:=Round([Item]priceA*0.85; 2)
////
////[ItemSpec]Profile12:=$aIncoming{6}//native_Price
////[ItemSpec]Profile13:=$aIncoming{7}//native_Currency
//QUERY([Word]; [Word]tableNum=3; *)
//QUERY([Word];  & ; [Word]alternate=[Item]itemNum)
//FIRST RECORD([Word])
//C_LONGINT($i; $k)
//C_BOOLEAN($found)
//$k:=Records in selection([Word])
//$found:=False

//// Modified by: William James (2014-01-06T00:00:00)
////  YYYYY Because this will not be used now but Words need to be added if ever used
////For ($i;1;$k)
////If ([Item]KeySub'Reference="Currency")
////$found:=True
////[Item]KeySub'WordReference:=$aIncoming{7}
////End if 
////End for 
////If ($found=False)
////CREATE RECORD([Word])
//// 
////[Word]TableNum:=Table(->[Item])
////[Word]ItemNumAlternate:=[Item]ItemNum
////[Word]Reference:=$aLabels{$i}
////[Word]WordOnly:=$aValues{$i}
////[Word]WordCombined:=$aValues{$i}+$aLabels{$i}
////SAVE RECORD([Word])
////End if 
////
//[Item]vendorID:=$aIncoming{8}
////
//[ItemSpec]profile21:=Num($aIncoming{9})
//[ItemSpec]profile20:=Num($aIncoming{10})
//[ItemSpec]profile15:=Date($aIncoming{11})
//SAVE RECORD([Item])
//SAVE RECORD([ItemSpec])
//End if 
////sku	wine	vintage	quantity	us_price	native_price	native_currency	supplier
////	case_size	bottle_volume	offer_date
////sku	wine	type	winery	country	region	appellation	classification
//Until (OK=0)
//End if 
//End if 