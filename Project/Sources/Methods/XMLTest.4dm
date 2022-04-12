//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/02/12, 14:41:06
// ----------------------------------------------------
// Method: XML_DataMemMakeOrders
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(vRef; vtCode)
C_LONGINT:C283($myDays)
//$myDays:=!09/11/12!-Current date

C_TEXT:C284(vRef; vtCode)
C_LONGINT:C283($myDays)
C_BOOLEAN:C305(vbDoName; vboolean1)
C_TEXT:C284(attribValue; Struct_Ref; vFound; vComment; v)
C_TEXT:C284(vRefInvoice; vRefCustomer; vRefOrder; vRefItems; vRefPayments; vRefPaymentMethod)


KeyModifierCurrent

Case of 
	: ((CapKey=1) & (OptKey=1))
		ALERT:C41(String:C10([TallyResult:73]idNum:35)+": "+HTTPClient_Response)
	: (CapKey=1)
		SET TEXT TO PASTEBOARD:C523(HTTPClient_Response)
	: ((CmdKey=1) & (OptKey=1) & (ShftKey=1))
		
	: (Record number:C243([TallyResult:73])>-1)
		HTTPClient_Response:=[TallyResult:73]textBlk2:6
	Else 
		HTTPClient_Response:=Get text from pasteboard:C524
End case 


If (Length:C16(HTTPClient_Response)>0)
	
	Struct_Ref:=""
	vFound:=""
	C_BOOLEAN:C305(vboolean1)
	C_TEXT:C284(Struct_Ref; vFound)
	vboolean1:=allowAlerts_boo
	allowAlerts_boo:=False:C215
	
	
	Struct_Ref:=DOM Parse XML variable:C720(HTTPClient_Response)  //get reference to XML response
	
	vRefOrder:=DOM Find XML element:C864(Struct_Ref; "response/orders/order")
	//Customer
	//Shipping
	//Billing
	//Items
	vRefCustomer:=DOM Find XML element:C864(vRefOrder; "order/customer")  //CustomerName and SalesRep
	
	vRefItems:=DOM Find XML element:C864(vRefOrder; "order/items")  //Get list of item records and create line items
	//Get list of item records and create line items
	vRefPayments:=DOM Find XML element:C864(vRefOrder; "order/invoices/invoice/payments")
	//count payments out of vRefPayments
	//ALERT("start: "+Struct_Ref)
	CREATE RECORD:C68([Customer:2])
	
	
	If (vRefOrder#"000@")
		
		vi9:=XML_ReturnValue(vRefCustomer; "customer/email"; ->[Customer:2]email:81; ->vComment)
		If (vi9=1)
			[Order:3]email:82:=[Customer:2]email:81
		End if 
		
		vi9:=XML_ReturnValue(vRefCustomer; "customer/firstname"; ->[Customer:2]nameFirst:73; ->vComment)
		
		vi9:=XML_ReturnValue(vRefCustomer; "customer/lastname"; ->[Customer:2]nameLast:23; ->vComment)
		
		vFound:=DOM Find XML element:C864(vRefCustomer; "customer/firstname")  // find transit response
		If (vFound#"0000@")
			DOM GET XML ELEMENT VALUE:C731(vFound; vtCode)
			[Customer:2]nameFirst:73:=vtCode
		End if 
		vFound:=DOM Find XML element:C864(vRefCustomer; "customer/lastname")  // find transit response
		If (vFound#"0000@")
			DOM GET XML ELEMENT VALUE:C731(vFound; vtCode)
			[Customer:2]nameLast:23:=vtCode
		End if 
		
		
		
		
	End if 
	
End if 




