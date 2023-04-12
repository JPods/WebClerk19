//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-14T06:00:00Z)
// Method: iLoPagePopUpMenuBar
// Description
// Parameters
// ----------------------------------------------------



var $1 : Variant
var $tableName : Text
Case of 
	: ((Value type:C1509($1)=Is longint:K8:6) | (Value type:C1509($1)=Is real:K8:4) | (Value type:C1509($1)=Is integer:K8:5))
		$tableName:=Table name:C256($1)
	: ((Value type:C1509($1)=Is text:K8:3) | (Value type:C1509($1)=Is string var:K8:2))
		$tableName:=$1
	: (Value type:C1509($1)=Is object:K8:27)
		$tableName:=$1
	: (Value type:C1509($1)=Is pointer:K8:14)
		$tableName:=Table name:C256($1)
	Else 
		$tableName:=process_o.dataClassName
End case 

Case of 
	: ($tableName="Control")
		jNavPalletPop("General")
		jSetMenuNums(1; 5; 6)
		//
	: ($tableName="Invoice")
		jNavPalletPop("General"; "Shipping"; "Customer/Service"; "Comments"; "Q&A"; "Docs"; "Object")  //;"LoadTag")
		jSetMenuNums(1; 5; 3)
		//
	: ($tableName="Order")
		jNavPalletPop("General"; "Shipping"; "Credit/Admin"; "Inv/POs"; "Customer"; "Wo's/Time"; "Q&A"; "Docs/Service"; "Object")  //;"LoadTag")
		jSetMenuNums(1; 4; 3)
		//
	: ($tableName="Customer")  //  ; "Orders/Invoices"
		jNavPalletPop("General"; "Credit/Admin"; "Shipping"; "Service/Calls"; "Q&A"; "Docs"; "Object")
		jSetMenuNums(1; 2; 3)
		//
	: ($tableName="Proposal")
		jSetMenuNums(1; 4; 3)
		jNavPalletPop("General"; "Shipping"; "Customer"; "Comments"; "Q&A"; "Docs/Service"; "Object")
		//
	: ($tableName="Contact")
		jNavPalletPop("General"; "Call Reports"; "Q&A"; "Object")
		jSetMenuNums(1; 2; 3)
		//
	: ($tableName="Lead")
		
		jNavPalletPop("General"; "Q&A"; "Object")
		jSetMenuNums(1; 2; 3)
		//
		//
	: ($tableName="Rep")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General"; "Quota/Territories"; "Orders/Invoices"; "Object")
		//
	: ($tableName="Item")
		jSetMenuNums(7; 9; 8)
		// ### bj ### 20200627_0035
		jNavPalletPop("General"; "Usage"; "Specification"; "BOM"; "Profiles"; "Documents"; "Inventory"; "Object")
		//
	: ($tableName="Project")
		jSetMenuNums(7; 9; 8)
		jNavPalletPop("Sales"; "Purchases"; "Service/Comments"; "WorkOrder"; "Object")
		//
	: (($tableName="PO") | ($tableName="POLine"))
		jSetMenuNums(7; 9; 8)
		
		If ($tableName="PO")
			jNavPalletPop("General"; "Vendor"; "Q&A"; "Object"; "Documents")  //  ;"Shipping")
		Else 
			jNavPalletPop("General"; "Vendor/Ship")
		End if 
		//
	: ($tableName="Vendor")
		jSetMenuNums(7; 9; 8)
		jNavPalletPop("General"; "POs/Sr#"; "Q&A"; "Object")
		//
	: ($tableName="ItemSerial")
		jSetMenuNums(7; 9; 8)
		jNavPalletPop("General"; "Details"; "Object")
		// ### jwm ### 20160505_1326 added dBOM
	: (($tableName="InventoryStack") | ($tableName="POReceipt") | ($tableName="BOM") | ($tableName="ItemSpec") | ($tableName="ItemXRef") | ($tableName="ItemSiteBucket") | ($tableName="ItemSerialAction"))
		jSetMenuNums(7; 9; 8)
		jNavPalletPop("General"; "Object")
		//
	: (($tableName="DInventory") | ($tableName="DBOM"))
		jSetMenuNums(7; 9; 8)
		jNavPalletPop("One Page Only")
		//
	: ($tableName="UsageSummary")
		jNavPalletPop("Usage Summary"; "Part Usage"; "Object")
		jSetMenuNums(10; 12; 11)
		//
	: ($tableName="Usage")
		jNavPalletPop("Monthy Usage"; "Daily Usage"; "Object")
		jSetMenuNums(10; 12; 11)
		//
	: ($tableName="Service")
		jNavPalletPop("Service"; "Credit"; "Ord/Inv"; "Q&A"; "Object")
		jSetMenuNums(1; 2; 3)
		
	: ($tableName="Employee")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General"; "Q&A"; "Email/Script"; "Object")
		//
	: ($tableName="Carrier")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General"; "Script"; "Object")
		//
	: ($tableName="Default")
		jNavPalletPop("General"; "Options"; "Credit Card"; "Settings"; "Object")
		jSetMenuNums(1; 6; 6)
		//
	: ($tableName="DefaultAccount")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General Accts"; "Pay Types")
		//
	: ($tableName="CallReport")
		jNavPalletPop("CallReport"; "Contact Details"; "ContactComments"; "Email Details"; "Object")
		jSetMenuNums(1; 2; 3)
		//
	: ($tableName="DivisionDefault")
		jNavPalletPop("General"; "Logos")
		jSetMenuNums(10; 12; 11)
		//
	: ($tableName="GenericParent")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General"; "Text"; "Object")
		//
	: ($tableName="GenericChild1")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General"; "Text"; "Object")
		//
	: ($tableName="GenericChild2")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General"; "Text"; "Object")
		//
	: ($tableName="WebClerk")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General"; "Certs"; "Object")
		
		
	: ($tableName="CronJob")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General"; "Instructions"; "Object")
		
	: ($tableName="EventLog")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General"; "Text"; "WebTemp"; "Object")
	: (($tableName="WOTemplate") | ($tableName="WOdraw") | ($tableName="WorkOrderTask") | ($tableName="WorkOrderEvent"))
		jSetMenuNums(7; 9; 8)
		jNavPalletPop("General")
	: ($tableName="WorkOrder")
		jSetMenuNums(7; 9; 8)
		jNavPalletPop("General"; "Addresses"; "MapTasQ"; "Objects"; "FlowChart")
		//
	: ($tableName="TechNote")
		jNavPalletPop("Edit"; "Discussions"; "Object")
		jSetMenuNums(10; 12; 11)
		
	: (($tableName="InvoiceLine") | ($tableName="OrderLine") | ($tableName="ProposalLine"))
		jNavPalletPop("General"; "Object")
		jSetMenuNums(1; 2; 3)
		
	: ($tableName="Reference")
		jNavPalletPop("General")
		jSetMenuNums(1; 2; 3)
		
	: ($tableName="Payment")
		jNavPalletPop("General"; "Object")
		jSetMenuNums(1; 2; 3)
		
	: ($tableName="Message")
		jNavPalletPop("General"; "BodyText"; "Header"; "Body"; "Comment"; "Script"; "Object")
		jSetMenuNums(1; 2; 3)
		
	: ($tableName="Objective")
		jNavPalletPop("General"; "Details"; "Object")
		jSetMenuNums(1; 2; 3)
		
	: ($tableName="SyncRelation")
		jNavPalletPop("General"; "Comments"; "Encryption"; "Object")
		jSetMenuNums(10; 12; 11)
		//
	: ($tableName="SyncRecord")
		jNavPalletPop("General"; "Objects")
		jSetMenuNums(10; 12; 11)
		//
	: ($tableName="EDISetID")
		jNavPalletPop("General"; "Object")
		jSetMenuNums(10; 12; 11)
		
	: ($tableName="Profile")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("One Page Only")
		
	: ($tableName="TallyMaster")
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("General"; "Objects")
		
	Else 
		jSetMenuNums(10; 12; 11)
		jNavPalletPop("One Page Only")
End case 
