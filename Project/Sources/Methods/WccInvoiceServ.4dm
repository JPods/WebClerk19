//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/30/20, 09:11:14
// ----------------------------------------------------
// Method: WccInvoiceServ
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)
C_POINTER:C301($2)
//

C_LONGINT:C283($recordNum; $recordID)
vResponse:="Table is not available."
$doPage:=WC_DoPage("Error.html"; "")
$recordNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
$customerID:=WCapi_GetParameter("customerID"; "")
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
returnValue:=WCapi_GetParameter("returnValue"; "")
returnTable:=WCapi_GetParameter("returnTable"; "")
returnField:=WCapi_GetParameter("returnField"; "")
// returnPage

C_LONGINT:C283($pageControl)
Case of 
	: (voState.url="/Wcc_InvoiceItemAdd@")  //Complex Transactions  
		//currently only one item at a time.    
		$pageControl:=2
		$itemNum:=WCapi_GetParameter("ItemNum"; "")
		$OrderStr:=WCapi_GetParameter("OrderNum"; "")
		$Qty2Order:=WCapi_GetParameter("Qty2Order"; "")
		$typeSale:=WCapi_GetParameter("TypeSale"; "")
		$useType:=WCapi_GetParameter("UseType"; "")
		$zipEnd:=WCapi_GetParameter("zipEnd"; "")
		QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=Num:C11(returnValue))
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)
		If ((Records in selection:C76([Item:4])=1) & (Records in selection:C76([Invoice:26])=1))
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
			
			IvcLnFillRays  //vLineCnt set if no order
			$existingTypeSale:=[Invoice:26]typeSale:49
			pPartNum:=[Item:4]itemNum:1
			pDescript:=[Item:4]description:7
			
			If ($typeSale#"")
				[Invoice:26]typeSale:49:=$typeSale
			End if 
			IvcLnAdd((Size of array:C274(aiLineAction)+1); 1; False:C215)
			pQtyShip:=Num:C11($Qty2Order)  // Qty is set to [Item] default
			aiQtyOrder{aiLineAction}:=pQtyShip
			aiQtyRemain{aiLineAction}:=0  //maintain as original, zero for new
			aiQtyShip{aiLineAction}:=pQtyShip
			IvcLnExtend(aiLineAction)
			[Invoice:26]typeSale:49:=$existingTypeSale
			booAccept:=True:C214
			vMod:=True:C214
			acceptInvoice
			QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
		End if 
	: (voState.url="/WCC_InvoiceShoppingCart@")  //Complex Transactions    
		
		WCCInvoiceShoppingCart($1; $2)
		
		
	: (voState.url="/WCC_InvoiceOrderLines@")  //Complex Transactions 
		// ### bj ### 20200323_0148
		C_TEXT:C284($tableName; $vtUUIDKey)
		$vtUUIDKey:=WCapi_GetParameter("id"; "")
		$tableName:=WCapi_GetParameter("TableName"; "")
		
		If (($vtUUIDKey="") | ($tableName#"Order"))
			vResponse:="Missing id"+$vtUUIDKey+" or TableName of Orders"
		Else 
			QUERY:C277([Order:3]; [Order:3]id:139=$vtUUIDKey)
			If (Records in selection:C76([Order:3])#1)
				vResponse:="No Orders Record for id "+$vtUUIDKey
			Else 
				//Http_OrdFill ($1;$2;True)
				NxPvOrders  //no parameters
				//
				// WC_Parse (Table(->[Order]);$2)
				//
				Find Ship Zone(->[Order:3]zip:20; ->[Order:3]zone:14; ->[Order:3]shipVia:13; ->[Order:3]country:21; ->[Order:3]siteID:106)
				//
				WccInvoiceOrderLines($1; $2)
				
				C_BOOLEAN:C305($doReCalc)
				$doReCalc:=False:C215
				booAccept:=True:C214
				vMod:=True:C214
				booAccept:=True:C214
				// Before_New (->[Order];Current user)
				acceptOrders
				$endingExecute:=WCapi_GetParameter("ScriptEnd"; "")
				If ($endingExecute#"")
					Execute_TallyMaster("WccOrders"; $endingExecute)
				End if 
				vMod:=True:C214
				booAccept:=True:C214
				acceptInvoice
			End if 
			$pageControl:=1
		End if 
		
	: (voState.url="/WCC_ServiceAction@")  //Complex Transactions    
		$action:=WCapi_GetParameter("Action"; "")
		QUERY:C277([Service:6]; [Service:6]action:20>=$action; *)
		QUERY:C277([Service:6];  & [Service:6]dtComplete:18=0)
		$pageControl:=1
End case 
Case of 
	: (Records in selection:C76([Invoice:26])=0)
		$doPage:=WC_DoPage("Comment.html"; "")
	: (Records in selection:C76([Invoice:26])=1)
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		$doPage:=WC_DoPage("WccInvoicesOne.html"; $jitPageOne)
	Else 
		$jitPageList:=WCapi_GetParameter("jitPageList"; "")
		$doPage:=WC_DoPage("WccInvoicesList.html"; $jitPageList)
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)