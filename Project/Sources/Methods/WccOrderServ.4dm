//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-09T00:00:00, 00:39:11
// ----------------------------------------------------
// Method: WccOrderServ
// Description
// Modified: 11/09/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1)
C_POINTER:C301($2)
C_TEXT:C284($jitBillTo; pvTask)
C_TEXT:C284($tableName; $vtUUIDKey)
//
vResponse:="No records available."
$pageDo:=WC_DoPage("Error.html"; "")
$tableName:="Order"  //WCapi_GetParameter("TableName";"")
//$recordNum:=Num(WCapi_GetParameter("RecordNum";""))
//TRACE
C_LONGINT:C283($pageControl)
Case of 
	: (voState.url="/Wcc_OrderFromProposal@")
		// ### bj ### 20200330_0954
		$tableName:=WCapi_GetParameter("tableName"; "")
		$vtUUIDKey:=WCapi_GetParameter("id"; "")
		$pageControl:=-1
		If ($vtUUIDKey="")
			vResponse:="id not defined"
		Else 
			QUERY:C277([Proposal:42]; [Proposal:42]id:89=$vtUUIDKey)
			If (Records in selection:C76([Proposal:42])#1)
				vResponse:="id not defined"
			Else 
				If (Locked:C147([Proposal:42]))
					vResponse:="Proposal Record is locked."
				Else 
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerID:1)
					WC_ProposalToOrder
					// $jitPageOne:=WCapi_GetParameter ("jitPageOne";"")
					$pageControl:=2  // get the page or use default Wcc page
				End if 
			End if 
		End if 
	: (voState.url="/Wcc_OrderItemAdd@")  //Complex Transactions  
		//currently only one item at a time.    
		$pageControl:=2
		returnValue:=WCapi_GetParameter("returnValue"; "")
		returnTable:=WCapi_GetParameter("returnTable"; "")
		returnField:=WCapi_GetParameter("returnField"; "")
		
		$itemNum:=WCapi_GetParameter("ItemNum"; "")
		$OrderStr:=WCapi_GetParameter("OrderNum"; "")
		$Qty2Order:=WCapi_GetParameter("Qty2Order"; "")
		$typeSale:=WCapi_GetParameter("TypeSale"; "")
		$useType:=WCapi_GetParameter("UseType"; "")
		$zipEnd:=WCapi_GetParameter("zipEnd"; "")
		QUERY:C277([Order:3]; [Order:3]idNum:2=Num:C11($OrderStr))
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)
		If ((Records in selection:C76([Item:4])=1) & (Records in selection:C76([Order:3])=1))
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
			OrdLnFillRays
			pPartNum:=[Item:4]itemNum:1
			pDescript:=[Item:4]description:7
			viOrdLnCnt:=viOrdLnCnt+1
			$existingTypeSale:=[Order:3]typeSale:22
			If ($typeSale#"")
				[Order:3]typeSale:22:=$typeSale
			End if 
			OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; False:C215)
			aOQtyOrder{aoLineAction}:=Num:C11($Qty2Order)  // Qty is set to [Item] default
			OrdLnExtend(aoLineAction)
			[Order:3]typeSale:22:=$existingTypeSale
			booAccept:=True:C214
			vMod:=True:C214
			acceptOrders
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
		End if 
	: (voState.url="/WCC_OrdersFill@")  //find bill to  
		$pageReturn:=WCapi_GetParameter("jitPageReturn"; "")
		$recordReturn:=WCapi_GetParameter("RecordReturn"; "")
		pvRecordReturn:=$recordReturn
		$tableReturn:=WCapi_GetParameter("TableReturn"; "")
		$taskReturn:=WCapi_GetParameter("TaskReturn"; "")
		$tableName:=WCapi_GetParameter("TableName"; "")
		$recordNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
		$pageControl:=1
		vResponse:="Filling order "+$taskReturn
		If ($tableReturn="Order")
			$pageDo:=WC_DoPage("WccOrdersOne.html"; $pageReturn)
			GOTO RECORD:C242([Order:3]; Num:C11(pvRecordReturn))
			Case of 
				: ($tableName="Customer")
					GOTO RECORD:C242([Customer:2]; $recordNum)
					$doCustomer:=True:C214
					
				: ($tableName="Contact")
					GOTO RECORD:C242([Contact:13]; $recordNum)
					$doContact:=True:C214
			End case 
			Case of 
				: ($taskReturn="BillTo")
					[Order:3]customerID:1:=[Customer:2]customerID:1
					LoadCustOrder
					Ship_LoadCust(->[Order:3])
					GOTO RECORD:C242([Customer:2]; $recordNum)
					$doSave:=True:C214
				: ($taskReturn="ShipTo")
					Case of 
						: ($doCustomer)
							Ship_LoadCust(->[Order:3])
							$doSave:=True:C214
						: ($doContact)
							$doSave:=True:C214
							$doTax:=Contact_ShipTo(Self:C308; ->[Order:3])
							vMod:=calcOrder(True:C214)
					End case 
			End case 
			If ($doSave)
				SAVE RECORD:C53([Order:3])
				$pageControl:=3
			End if 
			ptCurTable:=(->[Order:3])
			RelatedRelease
		End if 
	: (voState.url="/WCC_OrderOpen@")  //Complex Transactions    
		$custID:=WCapi_GetParameter("customerID"; "")
		If ($custID#"")
			QUERY:C277([Order:3]; [Order:3]customerID:1=$custID; *)
			QUERY:C277([Order:3];  & [Order:3]complete:83<2)
		Else 
			QUERY:C277([Order:3]; [Order:3]complete:83<2)
		End if 
		$pageControl:=1
	: (voState.url="/WCC_OrderPeriod@")  //Complex Transactions   
		GOTO RECORD:C242([RemoteUser:57]; vWccRemoteUserRec)
		$dateBegin:=Date:C102(WCapi_GetParameter("dateBegin"; ""))
		$dateEnd:=Date:C102(WCapi_GetParameter("dateEnd"; ""))
		QUERY:C277([Order:3]; [Order:3]dateDocument:4>=$dateBegin; *)
		QUERY:C277([Order:3];  & [Order:3]dateDocument:4<=$dateEnd; *)
		$doSearch:=True:C214
		Case of 
			: (vWccSecurity>4999)
				
			: (vWccTableNum=Table:C252(->[Employee:19]))
				QUERY:C277([Order:3];  & [Order:3]salesNameID:10=[RemoteUser:57]customerID:10; *)
			: (vWccTableNum=Table:C252(->[Rep:8]))
				QUERY:C277([Order:3];  & [Order:3]repID:8=[RemoteUser:57]customerID:10; *)
			Else 
				$doSearch:=False:C215
		End case 
		If ($doSearch)
			QUERY:C277([Order:3])
		Else 
			REDUCE SELECTION:C351([Order:3]; 0)
		End if 
		$pageControl:=1
	: (voState.url="/WCC_OrderPeriod@")  //Complex Transactions   
		$orderNum:=Num:C11(WCapi_GetParameter("orderNum"; ""))
		QUERY:C277([Order:3]; [Order:3]idNum:2=$orderNum)
		$pageControl:=2
	: (voState.url="/WCC_OrderNum@")  //Complex Transactions   
		$orderNum:=Num:C11(WCapi_GetParameter("orderNum"; ""))
		QUERY:C277([Order:3]; [Order:3]idNum:2=$orderNum)
		If (Records in selection:C76([Order:3])=1)
			//QUERY([Customer];[Customer]customerID=[Order]customerID)
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
			ptCurTable:=(->[Order:3])
			RelatedRelease
			$pageControl:=2
		End if 
	: (voState.url="/Wcc_OrderZipRange@")  //Complex Transactions       
		$zipBegin:=WCapi_GetParameter("zipBegin"; "")
		$zipEnd:=WCapi_GetParameter("zipEnd"; "")
		QUERY:C277([Order:3]; [Order:3]zip:20>=$zipBegin; *)
		QUERY:C277([Order:3];  & [Order:3]zip:20<=$zipEnd)
		$pageControl:=1
End case 
If (Records in selection:C76([Order:3])>0)
	Case of 
		: ($pageControl=1)
			$jitPageList:=WCapi_GetParameter("jitPageList"; "")
			$pageDo:=WC_DoPage("Wcc"+$tableName+"List.html"; $jitPageList)
		: ($pageControl=2)
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
			$pageDo:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
		: ($pageControl=3)
			
		: ($pageControl=-1)
			// pass vResponse
			$pageDo:="Error.html"
			
	End case 
End if 
$err:=WC_PageSendWithTags($1; $pageDo; 0)
//