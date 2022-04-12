$k:=Size of array:C274(aReqsLns)
C_LONGINT:C283($i; $k)
If ($k>0)
	READ ONLY:C145([Item:4])
	READ ONLY:C145([Vendor:38])
	For ($i; 1; $k)
		$w:=Size of array:C274(aRqRecNum)+1
		Rq_FillArrays(-3; $w; 1)
		aRqStatus{$w}:="Request"
		If ([Item:4]itemNum:1#aOItemNum{aReqsLns{$i}})
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{aReqsLns{$i}})
		End if 
		Case of 
			: (aOPricePt{aReqsLns{$i}}="Or")
				aRqOrdNum{$w}:=aOSerialRc{aReqsLns{$i}}  //orderNum
				QUERY:C277([Order:3]; [Order:3]idNum:2=aOSerialRc{aReqsLns{$i}})
				aRqOrdLn{$w}:=aOLineNum{aReqsLns{$i}}
				aRqCustID{$w}:=[Order:3]customerID:1
				aRqCustomer{$w}:=[Order:3]billToCompany:76
			: (aOPricePt{aReqsLns{$i}}="PP")
				
				aRqPpNum{$w}:=aOSerialRc{aReqsLns{$i}}  //Proposal      
				QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=aOSerialRc{aReqsLns{$i}})
				aRqPpLn{$w}:=aOLineNum{aReqsLns{$i}}
				aRqCustID{$w}:=[Proposal:42]customerID:1
				aRqCustomer{$w}:=[Proposal:42]bill2Company:57
			: (aOPricePt{aReqsLns{$i}}="PO")
				aRqPONum{$w}:=aOSerialRc{aReqsLns{$i}}  //PO       
				QUERY:C277([PO:39]; [PO:39]idNum:5=aOSerialRc{aReqsLns{$i}})
				aRqPoLn{$w}:=aOLineNum{aReqsLns{$i}}
				aRqCustID{$w}:=[PO:39]customervendorID:57
				aRqCustomer{$w}:=[PO:39]refCustomer:47
				aRqVendor{$w}:=[PO:39]vendorCompany:39
				aRqVendorID{$w}:=[PO:39]vendorID:1
			: (aOPricePt{aReqsLns{$i}}="It")
				aRqCustID{$w}:=""
				aRqCustomer{$w}:=""
				aRqVendorID{$w}:=[Item:4]vendorID:45
		End case 
		aRqActDate{$w}:=Current date:C33
		aRqCost{$w}:=[Item:4]costLastInShip:47
		aRqQty{$w}:=aOQtyOrder{aReqsLns{$i}}
		aRqLeadTime{$w}:=[Item:4]leadTimePo:55
		aRqVendorID{$w}:=[Item:4]vendorID:45
		If ([Vendor:38]vendorID:1#[Item:4]vendorID:45)
			QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[Item:4]vendorID:45)
		End if 
		aRqVendor{$w}:=[Vendor:38]company:2
		
		aRqItem{$w}:=aOItemNum{aReqsLns{$i}}
		aRqItemDesc{$w}:=[Item:4]description:7
		aRqItemPar{$w}:=aOItemNum{aReqsLns{$i}}
		aRqItemDPar{$w}:=[Item:4]description:7
		aRqRecNum{$w}:=-3
	End for 
	//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
	UNLOAD RECORD:C212([Item:4])
	UNLOAD RECORD:C212([Vendor:38])
	READ WRITE:C146([Item:4])
	READ WRITE:C146([Vendor:38])
Else 
	BEEP:C151
	BEEP:C151
End if 