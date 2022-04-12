//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/15/21, 11:50:51
// ----------------------------------------------------
// Method: WCapiTask_Make
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($tableName; $vtUserName; $vtID)
C_POINTER:C301($ptTable)
$tableName:=WCapi_GetParameter("tableName")
$ptTable:=STR_GetTablePointer($tableName)
C_OBJECT:C1216($obRec)
If (Is nil pointer:C315($ptTable))
	vResponse:="Error: tableName not correcly defined: "+$tableName
Else 
	vResponse:="Error: Endpoint incorrect: "+voState.url+" for "+$tableName
	$vtID:=WCapi_GetParameter("id")
	Case of 
		: (($tableName="Proposal") & (voState.url="@MakeOrder@"))
			$obRec:=ds:C1482.Proposal.query("id = :1"; $vtID).first()
			If (False:C215)
				$vtID:="4E7574F2D10340B38EEE09CEA2C103D5"
				$obRec:=ds:C1482.Proposal.query("id = :1"; $vtID).first()
			End if 
			USE ENTITY SELECTION:C1513($obRec)
			QUERY:C277([Proposal:42]; [Proposal:42]id:89=$vtID)
			If (Records in selection:C76([Proposal:42])=1)
				// change the entities
				CREATE RECORD:C68([Order:3])
				http_Pp2Order
				C_OBJECT:C1216($voOrderRec)
				$voOrderRec:=Create entity selection:C1512([Order:3])
				vResponse:=WCapiTask_RecordToObject("Order"; $voOrderRec.first())  // $voSelection[0])  before using .first():=
			Else 
				vResponse:="Error: Proposals found "+String:C10(Records in selection:C76([Proposal:42]))
			End if 
			
			//createOrderProp  //must follow OrdLnFillRays
			// booWarn:=False
			// setCustFinance
			
		: (($tableName="Order") & (voState.url="@MakeInvoice@"))
			//createInvoice
			$vtID:=WCapi_GetParameter("id"; "")
			$tableName:=WCapi_GetParameter("TableName"; "")
			$obRec:=ds:C1482.Order.query("id = :1"; $vtID).first()
			If (False:C215)
				$vtID:="704118AB5E474774BE873C162BE30EDC"
				$obRec:=ds:C1482.Order.query("id = :1"; $vtID).first()
			End if 
			USE ENTITY SELECTION:C1513($obRec)
			QUERY:C277([Order:3]; [Order:3]id:139=$vtID)
			If (Records in selection:C76([Order:3])#1)
				vResponse:="Error: No Orders Record for id "+$vtUUIDKey
			Else 
				NxPvOrders  //no parameters
				Find Ship Zone(->[Order:3]zip:20; ->[Order:3]zone:14; ->[Order:3]shipVia:13; ->[Order:3]country:21; ->[Order:3]siteID:106)
				WccInvoiceOrderLines($socket; ->vText11)
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
				C_OBJECT:C1216($voInvoiceRec)
				$voInvoiceRec:=Create entity selection:C1512([Invoice:26])
				vResponse:=WCapiTask_RecordToObject("Invoice"; $voInvoiceRec.first())
			End if 
			If (False:C215)
				Make_Invoice
			End if 
			
		: (($tableName="Order") & (voState.url="MakePayment"))
			// 333Http_PayAdd
			Make_Payment
		: (($tableName="Invoice") & (voState.url="MakePayment"))
			// 333Http_PayAdd
			Make_Payment
			
	End case 
End if 