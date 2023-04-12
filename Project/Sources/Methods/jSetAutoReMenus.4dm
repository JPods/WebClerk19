//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-14T06:00:00Z)
// Method: jSetAutoReMenus
// Description 
// Parameters
// ----------------------------------------------------



// MustFixQQQZZZ: Bill James (2022-01-14T06:00:00Z)
// rework to have no sr and only one set of menus
Case of   //Turn on/off the appropriate choices    
	: (process_o=Null:C1517)
		var process_o : Object
		process_o:=New object:C1471("ents"; New object:C1471; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; -1; \
			"tableName"; ""; \
			"tableForm"; ""; \
			"form"; ""; \
			"task"; "Splash"; \
			"entsOther"; New object:C1471("tableName"; New object:C1471); \
			"entities"; New object:C1471)
	: (process_o.dataClassName=Null:C1517)
		
	: (process_o.dataClassName="Order")
		If (vHere=0)
			//MENU BAR(1)
			ENABLE MENU ITEM:C149(4; 8)
			ENABLE MENU ITEM:C149(4; 9)
			ENABLE MENU ITEM:C149(4; 10)
			ENABLE MENU ITEM:C149(4; 11)
			ENABLE MENU ITEM:C149(4; 13)
			DISABLE MENU ITEM:C150(4; 14)
			ENABLE MENU ITEM:C149(4; 15)
		Else 
			ENABLE MENU ITEM:C149(4; 6)
			ENABLE MENU ITEM:C149(4; 7)
			If (srAcct#[Order:3]customerID:1)
				srCustomer:=[Customer:2]company:2
				srPhone:=[Customer:2]phone:13
				srAcct:=[Customer:2]customerID:1
				srZip:=[Customer:2]zip:8
			End if 
			// DISABLE MENU ITEM(5;5)  // ### jwm ### 20150219_1011 removed disable of Show OrderLines
		End if 
	: (process_o.dataClassName="Invoice")
		If (vHere=0)
			//   MENU BAR(1)
		Else 
			ENABLE MENU ITEM:C149(5; 5)
		End if 
	: (process_o.dataClassName="Proposal")
		DISABLE MENU ITEM:C150(4; 6)
		DISABLE MENU ITEM:C150(4; 7)
		DISABLE MENU ITEM:C150(4; 12)
		ENABLE MENU ITEM:C149(4; 16)
		ENABLE MENU ITEM:C149(4; 18)
		If (srAcct#[Order:3]customerID:1)
			srCustomer:=[Customer:2]company:2
			srPhone:=[Customer:2]phone:13
			srAcct:=[Customer:2]customerID:1
			srZip:=[Customer:2]zip:8
		End if 
	: (process_o.dataClassName="Item")
		ENABLE MENU ITEM:C149(3; 4)
	: (process_o.dataClassName="Service")
		DISABLE MENU ITEM:C150(3; 15)
	: ((process_o.dataClassName="PO") | (process_o.dataClassName="POLine"))
		ENABLE MENU ITEM:C149(5; 6)
		ENABLE MENU ITEM:C149(5; 7)
		ENABLE MENU ITEM:C149(5; 8)
		srCustomer:=[Vendor:38]company:2
		srPhone:=[Vendor:38]phone:10
		srAcct:=[Vendor:38]vendorID:1
		srZip:=[Vendor:38]zip:8
	: (process_o.dataClassName="Contact")
		DISABLE MENU ITEM:C150(3; 2)
End case 
//If (vHere>2)
//DISABLE ITEM(2;2)
//Else 
//ENABLE ITEM(2;2)
//End if 
//End if 
If (Screen width:C187<520)
	OBJECT SET ENTERABLE:C238(srItem; False:C215)
	OBJECT SET ENTERABLE:C238(srItemDscrp; False:C215)
	OBJECT SET ENTERABLE:C238(srItemType; False:C215)
	OBJECT SET ENTERABLE:C238(srItemsProfile1; False:C215)
	OBJECT SET ENTERABLE:C238(srItemsProfile2; False:C215)
	OBJECT SET ENTERABLE:C238(srItemsProfile3; False:C215)
	OBJECT SET ENTERABLE:C238(srItemsProfile4; False:C215)
	OBJECT SET ENTERABLE:C238(srItemMfgItemNum; False:C215)
End if 