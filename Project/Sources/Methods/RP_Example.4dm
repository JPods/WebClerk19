//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/06/19, 15:28:57
// ----------------------------------------------------
// Method: RP_Example
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (Shift down:C543)
	
End if 
If (vText13="")
	vText13:="Before"
End if 
Case of 
	: (vtRPCommand="ItemsVirtualInventory")
		Case of 
			: (vText13="Before")
				QUERY:C277([Item:4]; [Item:4]itemNum:1="bb@")
			: (vText13="EachRecord")
				
			Else 
				
		End case 
	: (vtRPCommand="ItemstoVendor")
		Case of 
			: (vText13="Before")
				QUERY:C277([Item:4]; [Item:4]itemNum:1="bb@")
			: (vText13="EachRecord")
				
			Else 
				
		End case 
	: (vtRPCommand="ItemstoCustomer")
		
		Case of 
			: (vText13="Before")
				QUERY:C277([Item:4]; [Item:4]itemNum:1="bb@")
			: (vText13="EachRecord")
				
			Else 
				
		End case 
	: (vtRPCommand="ItemstoRep")
		
		Case of 
			: (vText13="Before")
				QUERY:C277([Item:4]; [Item:4]itemNum:1="bb@")
			: (vText13="EachRecord")
				
			Else 
				
		End case 
	: (vtRPCommand="ItemstoAlly")
		Case of 
			: (vText13="Before")
				QUERY:C277([Item:4]; [Item:4]itemNum:1="bb@")
			: (vText13="EachRecord")
				
			Else 
				
		End case 
		
	: (vtRPCommand="Project")
		Case of 
			: (vText13="Before")
				QUERY:C277([Project:24]; [Project:24]active:3=True:C214)
			: (vText13="EachRecord")
				
			Else 
				
		End case 
		
	: (vtRPCommand="POstoVendor")
		Case of 
			: (vText13="Before")
				QUERY:C277([PO:39]; [PO:39]poNum:5=11)
			: (vText13="EachRecord")
				
			Else 
				
		End case 
		
		
	: (vtRPCommand="SOtoPOtoVendorSO")
		Case of 
			: (vText13="Before")
				QUERY:C277([Order:3]; [Order:3]orderNum:2=2007)
			: (vText13="EachRecord")
				
			Else 
				
		End case 
		
		
	: (vtRPCommand="SOtoCustomerPO")
		Case of 
			: (vText13="Before")
				QUERY:C277([Order:3]; [Order:3]orderNum:2>2007)
			: (vText13="EachRecord")
				
			Else 
				
		End case 
		
	: (vtRPCommand="SORemotetoSOInternal")
		Case of 
			: (vText13="Before")
				QUERY:C277([Order:3]; [Order:3]orderNum:2>2006; *)
				QUERY:C277([Order:3];  & [Order:3]orderNum:2<2009)
			: (vText13="EachRecord")
				
			Else 
				
		End case 
		
	: (vtRPCommand="Shipments")
		Case of 
			: (vText13="Before")
				QUERY:C277([LoadTag:88]; [LoadTag:88]idUnique:1<4)
			: (vText13="EachRecord")
				
			Else 
				
		End case 
		
	: (vtRPCommand="SpecialDiscounts")
		Case of 
			: (vText13="Before")
				QUERY:C277([SpecialDiscount:44]; [SpecialDiscount:44]TypeSale:1#"")
			: (vText13="EachRecord")
				
			Else 
				
		End case 
		
End case 
