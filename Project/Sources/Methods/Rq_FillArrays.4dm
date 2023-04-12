//%attributes = {"publishedWeb":true}
//Procedure: Procedure: Rq_FillArrays
C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay; $diff)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aRqGroupID; 0)  //[Requistion]GroupID    
		ARRAY LONGINT:C221(aRqUniqueID; 0)  //[Requistion]UniqueID  
		ARRAY LONGINT:C221(aRqPONum; 0)  //[Requistion]PONum
		ARRAY LONGINT:C221(aRqPpNum; 0)  //[Requistion]PPNum
		ARRAY LONGINT:C221(aRqOrdNum; 0)  //[Requistion]OrderNum//
		ARRAY DATE:C224(aRqActDate; 0)  //[Requistion]ActionDate
		ARRAY TEXT:C222(aRqAction; 0)  //[Requistion]Action
		ARRAY TEXT:C222(aRqStatus; 0)  //[Requistion]Status
		ARRAY TEXT:C222(aRqNameID; 0)  //[Requistion]nameID
		ARRAY DATE:C224(aRqNeed; 0)  ////[Requistion]DTNeeded
		ARRAY REAL:C219(aRqCost; 0)  //[Requistion]CurCost
		ARRAY REAL:C219(aRqQty; 0)  //[Requistion]CurQty
		ARRAY LONGINT:C221(aRqLeadTime; 0)  //[Requistion]LeadDays
		ARRAY TEXT:C222(aRqVendor; 0)  //[Requistion]Vendor
		ARRAY TEXT:C222(aRqVendorID; 0)  //[Requistion]VendorID
		ARRAY TEXT:C222(aRqVendorIt; 0)  //[Requistion]VendorID
		ARRAY TEXT:C222(aRqCustomer; 0)  //[Requistion]Customer
		ARRAY TEXT:C222(aRqCustID; 0)  //[Requistion]customerID
		ARRAY LONGINT:C221(aRqPpLn; 0)  //[Requistion]proposalLineID
		ARRAY LONGINT:C221(aRqPoLn; 0)  //[Requistion]poLineID
		ARRAY LONGINT:C221(aRqOrdLn; 0)  //[Requistion]OrderLineID
		ARRAY TEXT:C222(aRqItem; 0)  //[Requistion]ItemNum
		ARRAY TEXT:C222(aRqItemDesc; 0)  //[Requistion]Description
		ARRAY TEXT:C222(aRqItemPar; 0)  //[Requistion]ItemParent
		ARRAY TEXT:C222(aRqItemDPar; 0)  //[Requistion]DescriptionPar
		ARRAY LONGINT:C221(aRqRecNum; 0)  //Record number
		//
		ARRAY LONGINT:C221(aReqSelLns; 0)  //selector  
	: ($1>0)
		SELECTION TO ARRAY:C260([Requisition:83]idNumPO:2; aRqPONum; [Requisition:83]idNumProposal:3; aRqPpNum; [Requisition:83]idNumOrder:4; aRqOrdNum; [Requisition:83]actionDate:7; aRqActDate; [Requisition:83]dtNeeded:6; aTmpLong1; [Requisition:83]curCost:22; aRqCost; [Requisition:83]curQty:23; aRqQty; [Requisition:83]leadDays:25; aRqLeadTime)
		SELECTION TO ARRAY:C260([Requisition:83]vendor:31; aRqVendor; [Requisition:83]vendorID:30; aRqVendorID; [Requisition:83]customer:33; aRqCustomer; [Requisition:83]customerID:32; aRqCustID; [Requisition:83]proposalLineIDNum:34; aRqPpLn; [Requisition:83]nameID:9; aRqNameID; [Requisition:83]action:10; aRqAction; [Requisition:83]vendorItem:45; aRqVendorIt; [Requisition:83]status:47; aRqStatus)
		SELECTION TO ARRAY:C260([Requisition:83]poLineID:35; aRqPoLn; [Requisition:83]orderLineID:36; aRqOrdLn; [Requisition:83]itemNum:38; aRqItem; [Requisition:83]description:39; aRqItemDesc; [Requisition:83]itemParent:40; aRqItemPar; [Requisition:83]descriptionPar:41; aRqItemDPar; [Requisition:83]; aRqRecNum; [Requisition:83]idNum:1; aRqUniqueID; [Requisition:83]groupid:46; aRqGroupID)
		ARRAY DATE:C224(aRqNeed; $1)
		For ($i; 1; $1)
			DateTime_DTFrom(aTmpLong1{$i}; ->aRqNeed{$i}; ->vTime1)
		End for 
		ARRAY LONGINT:C221(aTmpLong1; 0)
		ARRAY LONGINT:C221(aRqRecLn; 0)
	: ($1=-1)  //delete an element
		If (aRqRecNum{$2}>-1)
			READ WRITE:C146([Requisition:83])
			GOTO RECORD:C242([Requisition:83]; aRqRecNum{$2})
			DELETE RECORD:C58([Requisition:83])
			READ ONLY:C145([Requisition:83])
		End if 
		DELETE FROM ARRAY:C228(aRqUniqueID; $2; $3)  //[Requistion]UniqueID
		DELETE FROM ARRAY:C228(aRqGroupID; $2; $3)  //[Requistion]GroupID
		DELETE FROM ARRAY:C228(aRqPONum; $2; $3)  //[Requistion]PONum
		DELETE FROM ARRAY:C228(aRqPpNum; $2; $3)  //[Requistion]PPNum
		DELETE FROM ARRAY:C228(aRqOrdNum; $2; $3)  //[Requistion]OrderNum//
		DELETE FROM ARRAY:C228(aRqActDate; $2; $3)  //[Requistion]ActionDate
		DELETE FROM ARRAY:C228(aRqNeed; $2; $3)  ////[Requistion]DTNeeded
		DELETE FROM ARRAY:C228(aRqAction; $2; $3)  //[Requistion]Action
		DELETE FROM ARRAY:C228(aRqStatus; $2; $3)  //[Requistion]Status
		DELETE FROM ARRAY:C228(aRqNameID; $2; $3)  //[Requistion]nameID
		DELETE FROM ARRAY:C228(aRqCost; $2; $3)  //[Requistion]CurCost
		DELETE FROM ARRAY:C228(aRqQty; $2; $3)  //[Requistion]CurQty
		DELETE FROM ARRAY:C228(aRqLeadTime; $2; $3)  //[Requistion]LeadDays
		DELETE FROM ARRAY:C228(aRqVendor; $2; $3)  //[Requistion]Vendor
		DELETE FROM ARRAY:C228(aRqVendorID; $2; $3)  //[Requistion]VendorID
		DELETE FROM ARRAY:C228(aRqVendorIt; $2; $3)  //[Requistion]VendorIt
		DELETE FROM ARRAY:C228(aRqCustomer; $2; $3)  //[Requistion]Customer
		DELETE FROM ARRAY:C228(aRqCustID; $2; $3)  //[Requistion]customerID
		DELETE FROM ARRAY:C228(aRqPpLn; $2; $3)  //[Requistion]proposalLineID
		DELETE FROM ARRAY:C228(aRqPoLn; $2; $3)  //[Requistion]poLineID
		DELETE FROM ARRAY:C228(aRqOrdLn; $2; $3)  //[Requistion]OrderLineID
		DELETE FROM ARRAY:C228(aRqItem; $2; $3)  //[Requistion]ItemNum
		DELETE FROM ARRAY:C228(aRqItemDesc; $2; $3)  //[Requistion]Description
		DELETE FROM ARRAY:C228(aRqItemPar; $2; $3)  //[Requistion]ItemParent
		DELETE FROM ARRAY:C228(aRqItemDPar; $2; $3)  //[Requistion]DescriptionPar
		DELETE FROM ARRAY:C228(aRqRecNum; $2; $3)  //Record number  
		
	: ($1=-3)  //insert an element
		INSERT IN ARRAY:C227(aRqUniqueID; $2; $3)  //[Requistion]UniqueID
		INSERT IN ARRAY:C227(aRqGroupID; $2; $3)  //[Requistion]GroupID    
		INSERT IN ARRAY:C227(aRqPONum; $2; $3)  //[Requistion]PONum
		INSERT IN ARRAY:C227(aRqPpNum; $2; $3)  //[Requistion]PPNum
		INSERT IN ARRAY:C227(aRqOrdNum; $2; $3)  //[Requistion]OrderNum//
		INSERT IN ARRAY:C227(aRqActDate; $2; $3)  //[Requistion]ActionDate
		INSERT IN ARRAY:C227(aRqAction; $2; $3)  //[Requistion]Action
		INSERT IN ARRAY:C227(aRqStatus; $2; $3)  //[Requistion]Status
		INSERT IN ARRAY:C227(aRqNameID; $2; $3)  //[Requistion]nameID
		INSERT IN ARRAY:C227(aRqNeed; $2; $3)  ////[Requistion]DTNeeded
		INSERT IN ARRAY:C227(aRqCost; $2; $3)  //[Requistion]CurCost
		INSERT IN ARRAY:C227(aRqQty; $2; $3)  //[Requistion]CurQty
		INSERT IN ARRAY:C227(aRqLeadTime; $2; $3)  //[Requistion]LeadDays
		INSERT IN ARRAY:C227(aRqVendor; $2; $3)  //[Requistion]Vendor
		INSERT IN ARRAY:C227(aRqVendorID; $2; $3)  //[Requistion]VendorID
		INSERT IN ARRAY:C227(aRqVendorIt; $2; $3)  //[Requistion]VendorIt
		INSERT IN ARRAY:C227(aRqCustomer; $2; $3)  //[Requistion]Customer
		INSERT IN ARRAY:C227(aRqCustID; $2; $3)  //[Requistion]customerID
		INSERT IN ARRAY:C227(aRqPpLn; $2; $3)  //[Requistion]proposalLineID
		INSERT IN ARRAY:C227(aRqPoLn; $2; $3)  //[Requistion]poLineID
		INSERT IN ARRAY:C227(aRqOrdLn; $2; $3)  //[Requistion]OrderLineID
		INSERT IN ARRAY:C227(aRqItem; $2; $3)  //[Requistion]ItemNum
		INSERT IN ARRAY:C227(aRqItemDesc; $2; $3)  //[Requistion]Description
		INSERT IN ARRAY:C227(aRqItemPar; $2; $3)  //[Requistion]ItemParent
		INSERT IN ARRAY:C227(aRqItemDPar; $2; $3)  //[Requistion]DescriptionPar
		INSERT IN ARRAY:C227(aRqRecNum; $2; $3)  //Record number  
		$k:=$2+$3-1
		For ($i; $2; $k; 1)
			aRqRecNum{$i}:=-3  //Record number
		End for 
	: ($1=-4)  //Fill a record
		If (aRqRecNum{$2}>-1)
			GOTO RECORD:C242([Requisition:83]; aRqRecNum{$2})
		Else 
			CREATE RECORD:C68([Requisition:83])
			
		End if 
		[Requisition:83]groupid:46:=aRqGroupID{$2}
		[Requisition:83]idNumPO:2:=aRqPONum{$2}  //
		[Requisition:83]idNumProposal:3:=aRqPpNum{$2}  //
		[Requisition:83]idNumOrder:4:=aRqOrdNum{$2}  ////
		[Requisition:83]vendor:31:=aRqVendor{$2}  //
		[Requisition:83]vendorID:30:=aRqVendorID{$2}  //
		[Requisition:83]vendorItem:45:=aRqVendorIt{$2}
		[Requisition:83]customer:33:=aRqCustomer{$2}  //
		[Requisition:83]customerID:32:=aRqCustID{$2}  //
		[Requisition:83]proposalLineIDNum:34:=aRqPpLn{$2}  //
		[Requisition:83]poLineID:35:=aRqPoLn{$2}  //
		[Requisition:83]orderLineID:36:=aRqOrdLn{$2}  //
		[Requisition:83]itemNum:38:=aRqItem{$2}  //
		[Requisition:83]description:39:=aRqItemDesc{$2}  //
		[Requisition:83]itemParent:40:=aRqItemPar{$2}  //
		[Requisition:83]descriptionPar:41:=aRqItemDPar{$2}  //
		[Requisition:83]curCost:22:=aRqCost{$2}  //
		[Requisition:83]curQty:23:=aRqQty{$2}  //
		[Requisition:83]leadDays:25:=aRqLeadTime{$2}  //
		//
		[Requisition:83]status:47:=aRqStatus{$2}
		[Requisition:83]action:10:=aRqAction{$2}
		[Requisition:83]actionDate:7:=aRqActDate{$2}
		[Requisition:83]nameID:9:=aRqNameID{$2}
		[Requisition:83]dtNeeded:6:=DateTime_DTTo(aRqNeed{$2})  ////    
		//
		SAVE RECORD:C53([Requisition:83])
		aRqRecNum{$2}:=Record number:C243([Requisition:83])
	: ($1=-5)  //array to selection
		//
	: ($1=-6)  //Update an array
		aRqUniqueID{$2}:=[Requisition:83]idNum:1
		aRqGroupID{$2}:=[Requisition:83]groupid:46
		aRqPONum{$2}:=[Requisition:83]idNumPO:2
		aRqPpNum{$2}:=[Requisition:83]idNumProposal:3
		aRqOrdNum{$2}:=[Requisition:83]idNumOrder:4
		aRqActDate{$2}:=[Requisition:83]actionDate:7
		DateTime_DTFrom([Requisition:83]dtNeeded:6; ->aRqNeed{$2}; ->vTime1)
		aRqCost{$2}:=[Requisition:83]curCost:22
		aRqQty{$2}:=[Requisition:83]curQty:23
		aRqLeadTime{$2}:=[Requisition:83]leadDays:25
		aRqVendor{$2}:=[Requisition:83]vendor:31
		aRqVendorID{$2}:=[Requisition:83]vendorID:30
		aRqVendorIt{$2}:=[Requisition:83]vendorItem:45
		aRqCustomer{$2}:=[Requisition:83]customer:33
		aRqCustID{$2}:=[Requisition:83]customerID:32
		aRqPpLn{$2}:=[Requisition:83]proposalLineIDNum:34
		aRqPoLn{$2}:=[Requisition:83]poLineID:35
		aRqOrdLn{$2}:=[Requisition:83]orderLineID:36
		aRqItem{$2}:=[Requisition:83]itemNum:38
		aRqItemDesc{$2}:=[Requisition:83]description:39
		aRqItemPar{$2}:=[Requisition:83]itemParent:40
		aRqItemDPar{$2}:=[Requisition:83]descriptionPar:41  //
		aRqStatus{$2}:=[Requisition:83]status:47
		aRqAction{$2}:=[Requisition:83]action:10
		aRqNameID{$2}:=[Requisition:83]nameID:9
		//
		aRqRecNum{$2}:=Record number:C243([Requisition:83])
		
	: ($1=-7)
		
	: ($1=-8)  //Clone lines    
		$i:=Size of array:C274(aRqRecNum)+1
		Rq_FillArrays(-3; $i; 1)
		//INSERT ELEMENT(aRqUniqueID;$i;1)//[Requistion]UniqueID
		//INSERT ELEMENT(aRqGroupID;$i;1)//[Requistion]GroupID    
		//INSERT ELEMENT(aRqPONum;$i;1)//[Requistion]PONum
		//INSERT ELEMENT(aRqPpNum;$i;1)//[Requistion]PPNum
		//INSERT ELEMENT(aRqOrdNum;$i;1)//[Requistion]OrderNum//
		//INSERT ELEMENT(aRqActDate;$i;1)//[Requistion]ActionDate
		//INSERT ELEMENT(aRqAction;$i;1)//[Requistion]Action
		//INSERT ELEMENT(aRqStatus;$i;$1)//[Requistion]Status
		//INSERT ELEMENT(aRqNameID;$i;1)//[Requistion]nameID
		//INSERT ELEMENT(aRqNeed;$i;1)////[Requistion]DTNeeded
		//INSERT ELEMENT(aRqCost;$i;1)//[Requistion]CurCost
		//INSERT ELEMENT(aRqQty;$i;1)//[Requistion]CurQty
		//INSERT ELEMENT(aRqLeadTime;$i;1)//[Requistion]LeadDays
		//INSERT ELEMENT(aRqVendor;$i;1)//[Requistion]Vendor
		//INSERT ELEMENT(aRqVendorID;$i;1)//[Requistion]VendorID
		//INSERT ELEMENT(aRqVendorIt;$i;1)//[Requistion]VendorID
		//INSERT ELEMENT(aRqCustomer;$i;1)//[Requistion]Customer
		//INSERT ELEMENT(aRqCustID;$i;1)//[Requistion]customerID
		//INSERT ELEMENT(aRqPpLn;$i;1)//[Requistion]proposalLineID
		//INSERT ELEMENT(aRqPoLn;$i;1)//[Requistion]poLineID
		//INSERT ELEMENT(aRqOrdLn;$i;1)//[Requistion]OrderLineID
		//INSERT ELEMENT(aRqItem;$i;1)//[Requistion]ItemNum
		//INSERT ELEMENT(aRqItemDesc;$i;1)//[Requistion]Description
		//INSERT ELEMENT(aRqItemPar;$i;1)//[Requistion]ItemParent
		//INSERT ELEMENT(aRqItemDPar;$i;1)//[Requistion]DescriptionPar
		//INSERT ELEMENT(aRqRecNum;$i;1)//Record number      
		
		
		aRqGroupID{$i}:=aRqGroupID{$2}  //[Requistion]GroupID    
		aRqPONum{$i}:=aRqPONum{$2}  //[Requistion]PONum
		aRqPpNum{$i}:=aRqPpNum{$2}  //[Requistion]PPNum
		aRqOrdNum{$i}:=aRqOrdNum{$2}  //[Requistion]OrderNum//
		aRqActDate{$i}:=aRqActDate{$2}  //[Requistion]ActionDate
		aRqAction{$i}:=aRqAction{$2}  //[Requistion]Action
		aRqStatus{$i}:=aRqStatus{$2}  //[Requistion]Status
		aRqNameID{$i}:=aRqNameID{$2}  //[Requistion]nameID
		aRqNeed{$i}:=aRqNeed{$2}  ////[Requistion]DTNeeded
		aRqCost{$i}:=aRqCost{$2}  //[Requistion]CurCost
		aRqQty{$i}:=aRqQty{$2}  //[Requistion]CurQty
		aRqLeadTime{$i}:=aRqLeadTime{$2}  //[Requistion]LeadDays
		aRqVendor{$i}:=aRqVendor{$2}  //[Requistion]Vendor
		aRqVendorID{$i}:=aRqVendorID{$2}  //[Requistion]VendorID
		aRqVendorIt{$i}:=aRqVendorIt{$2}  //[Requistion]VendorItem
		aRqCustomer{$i}:=aRqCustomer{$2}  //[Requistion]Customer
		aRqCustID{$i}:=aRqCustID{$2}  //[Requistion]customerID
		aRqPpLn{$i}:=aRqPpLn{$2}  //[Requistion]proposalLineID
		aRqPoLn{$i}:=aRqPoLn{$2}  //[Requistion]poLineID
		aRqOrdLn{$i}:=aRqOrdLn{$2}  //[Requistion]OrderLineID
		aRqItem{$i}:=aRqItem{$2}  //[Requistion]ItemNum
		aRqItemDesc{$i}:=aRqItemDesc{$2}  //[Requistion]Description
		aRqItemPar{$i}:=aRqItemPar{$2}  //[Requistion]ItemParent
		aRqItemDPar{$i}:=aRqItemDPar{$2}  //[Requistion]DescriptionPar
		aRqRecNum{$i}:=-3  //Record number   
End case 