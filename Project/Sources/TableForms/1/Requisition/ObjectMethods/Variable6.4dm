C_LONGINT:C283($i; $k; $bomCnt; $bomIdx)
TRACE:C157
$k:=Size of array:C274(aReqsLns)
READ ONLY:C145([Item:4])
READ ONLY:C145([Vendor:38])
If ($k>0)
	For ($i; 1; $k)
		BOM_BuildExtend(aOItemNum{aReqsLns{$i}})
		$bomCnt:=Size of array:C274(aRptPartNum)
		For ($bomIdx; 1; $bomCnt)
			$w:=Size of array:C274(aRqRecNum)+1
			Rq_FillArrays(-3; $w; 1)
			aRqStatus{$w}:="Request"
			If ([Item:4]itemNum:1#aRptPartNum{$bomIdx})
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aRptPartNum{$bomIdx})
			End if 
			Case of 
				: (aOPricePt{aReqsLns{$i}}="Or")
					aRqOrdNum{$w}:=aOSerialRc{aReqsLns{$i}}  //orderNum
					aRqOrdLn{$w}:=aOLineNum{aReqsLns{$i}}
					If ([Order:3]idNum:2#aOSerialRc{aReqsLns{$i}})
						QUERY:C277([Order:3]; [Order:3]idNum:2=aOSerialRc{aReqsLns{$i}})
					End if 
					aRqCustID{$w}:=[Order:3]customerID:1
					aRqCustomer{$w}:=[Order:3]billToCompany:76
					//
				: (aOPricePt{aReqsLns{$i}}="PO")
					aRqPONum{$w}:=aOSerialRc{aReqsLns{$i}}  //PONum
					aRqPoLn{$w}:=aOLineNum{aReqsLns{$i}}
					If ([PO:39]idNum:5#aOSerialRc{aReqsLns{$i}})
						QUERY:C277([PO:39]; [PO:39]idNum:5=aOSerialRc{aReqsLns{$i}})
					End if 
					aRqVendorID{$w}:=[PO:39]vendorID:1
					aRqVendor{$w}:=[PO:39]vendorCompany:39
					//
				: (aOPricePt{aReqsLns{$i}}="PP")
					aRqPpNum{$w}:=aOSerialRc{aReqsLns{$i}}  //PpNum
					aRqPpLn{$w}:=aOLineNum{aReqsLns{$i}}
					If ([Proposal:42]idNum:5#aOSerialRc{aReqsLns{$i}})
						QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=aOSerialRc{aReqsLns{$i}})
					End if 
					aRqCustID{$w}:=[Proposal:42]customerID:1
					aRqCustomer{$w}:=[Proposal:42]bill2Company:57
					//
				: (aOPricePt{aReqsLns{$i}}="It")
					If ([Vendor:38]vendorID:1#[Item:4]vendorID:45)
						QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[Item:4]vendorID:45)
					End if 
					aRqVendorID{$w}:=[Item:4]vendorID:45
					aRqVendor{$w}:=[Vendor:38]company:2
			End case   //      : (aOPricePt{aReqsLns{$i}}="It")
			aRqActDate{$w}:=Current date:C33
			//  aRqNeed{$w}:=[Requistion]DTNeeded
			aRqCost{$w}:=[Item:4]costLastInShip:47
			aRqQty{$w}:=aOQtyOrder{aReqsLns{$i}}*aQtyAct{$bomIdx}
			aRqLeadTime{$w}:=[Item:4]leadTimePo:55
			aRqItem{$w}:=aRptPartNum{$bomIdx}
			aRqItemDesc{$w}:=[Item:4]description:7
			aRqItemPar{$w}:=aOItemNum{aReqsLns{$i}}
			aRqItemDPar{$w}:=aODescpt{aReqsLns{$i}}
			aRqRecNum{$w}:=-3
		End for 
	End for 
	//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
	READ WRITE:C146([Item:4])
	READ WRITE:C146([Vendor:38])
	UNLOAD RECORD:C212([Item:4])
	UNLOAD RECORD:C212([Vendor:38])
Else 
	BEEP:C151
	BEEP:C151
End if 