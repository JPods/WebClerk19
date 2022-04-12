//%attributes = {"publishedWeb":true}
//Method: Discount_SetDiscount
C_REAL:C285($1; $2; $0)  //pDiscnt:=(pUnitPrice-pDscntPrice)/pUnitPrice*100
If ($1#0)
	$0:=($1-$2)/$1*100
Else 
	$0:=100
End if 


If (False:C215)  //example of importing data means to calculate discount and discounted unit price.  
	// 
	Case of 
		: ([OrderLine:49]qtyOrdered:6=0)  //
			[OrderLine:49]discountedPrice:64:=[OrderLine:49]extendedPrice:11
		: ([OrderLine:49]qtyOrdered:6=1)  //
			[OrderLine:49]discountedPrice:64:=[OrderLine:49]extendedPrice:11
		Else 
			[OrderLine:49]discountedPrice:64:=[OrderLine:49]extendedPrice:11/[OrderLine:49]qtyOrdered:6
	End case 
	If ([OrderLine:49]discountedPrice:64#[OrderLine:49]unitPrice:9)
		pDiscnt:=Discount_SetDiscount([OrderLine:49]unitPrice:9; [OrderLine:49]discountedPrice:64)
		[OrderLine:49]discountedPrice:64:=DiscountApply([OrderLine:49]unitPrice:9; pDiscnt; 2)
		[OrderLine:49]discount:10:=pDiscnt
	End if 
	
	
End if 