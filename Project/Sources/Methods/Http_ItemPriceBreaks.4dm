//%attributes = {"publishedWeb":true}


// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)


//  
//   //Method: Http_ItemPriceBreaks
// 
//   // Modified by: William James (2013-07-15T00:00:00)
// 
//   //  ?????  CLEAR THIS PROCEDURE   ?????  
// 
//   //
// itemDiscounts:=""
// If ([Item]UseQtyPriceBrks>0)
//   //TRACE
// pBasePrice:=Field(4;vUseBase)->
//   //pDiscnt:=OrdSetDiscount ($qty)
//   //
// QUERY([PriceMatrix];[PriceMatrix]ItemNum=[Item]ItemNum)
// C_Longint($i;$k)
// $k:=Records in sub_selection([Item]PriceBreaks)
// FIRST SUBRECORD([Item]PriceBreaks)
// C_TEXT($itemQty;$itemPrice)
// $itemPrice:=""
// $itemQty:=""
// Case of 
// : ([Item]UseQtyPriceBrks=1)
// $itemQty:="<TD align="+Char(34)+"right"+Char(34)+">Quantity</TD>"
// $itemPrice:=$itemPrice+"<TD align="+Char(34)+"right"+Char(34)+">Price</TD>"
// For ($i;1;$k)
// pUnitPrice:=DiscountApply (pBasePrice;;<>tcDecimalUP)
// $itemQty:=$itemQty+"<TD align="+Char(34)+"right"+Char(34)+">"+String()+"</TD>"
// $itemPrice:=$itemPrice+"<TD align="+Char(34)+"right"+Char(34)+">"+String(pUnitPrice;"###,###,##0.00")+"</TD>"
// NEXT SUBRECORD([Item]PriceBreaks)
// End for 
// itemDiscounts:="<TABLE Cellpadding="+Char(34)+"1"+Char(34)+"width="+Char(34)+"100%"+Char(34)+">"
// itemDiscounts:=itemDiscounts+"<TR>"+$itemQty+"</TR>"+"\r"+"<TR>"+$itemPrice+"</TR>"+"</TABLE>"
// Else 
// itemDiscounts:="<TABLE Cellpadding="+Char(34)+"3"+Char(34)+"width="+Char(34)+"100%"+Char(34)+">"
// itemDiscounts:=itemDiscounts+"\r"+"<TR><TD align="+Char(34)+"right"+Char(34)+">Low Quantity</TD><TD align="+Char(34)+"right"+Char(34)+">High Quantity</TD><TD align="+Char(34)+"right"+Char(34)+">Discount</TD><TD align="+Char(34)+"right"+Char(34)+">Unit Price</TD></TR>"
// For ($i;1;$k)
// pUnitPrice:=DiscountApply (pBasePrice;;<>tcDecimalUP)
// If ($i<$k)
// itemDiscounts:=itemDiscounts+"\r"+"<TR><TD align="+Char(34)+"right"+Char(34)+">"+String()+"</TD><TD align="+Char(34)+"right"+Char(34)+">"+String()+"</TD><TD align="+Char(34)+"right"+Char(34)+">"+String(;"#0.00")+"</TD><TD align="+Char(34)+"right"+Char(34)+">"+String(pUnitPrice;"###,###,##0.00")+"</TD></TR>"
// Else 
// itemDiscounts:=itemDiscounts+"\r"+"<TR><TD align="+Char(34)+"right"+Char(34)+">"+String()+"</TD><TD align="+Char(34)+"right"+Char(34)+">And UP</TD><TD align="+Char(34)+"right"+Char(34)+">"+String(;"#0.00")+"</TD><TD align="+Char(34)+"right"+Char(34)+">"+String(pUnitPrice;"###,###,##0.00")+"</TD></TR>"
// End if 
// NEXT SUBRECORD([Item]PriceBreaks)
// End for 
// itemDiscounts:=itemDiscounts+"</TABLE>"
// End case 
// End if 