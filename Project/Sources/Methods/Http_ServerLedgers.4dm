//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/19/10, 11:29:47
// ----------------------------------------------------
// Method: Http_ServerLedgers
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $err; $InvoiceNum; $k)
C_POINTER:C301($2)
$suffix:=""
$doThis:=0
vResponse:="No records meet requirements"
C_TEXT:C284($doPage)
$suffix:=""
$thePage:="Error.html"
If (Record number:C243([Customer:2])>-1)
	$tableName:=WCapi_GetParameter("TableName"; "")
	C_TEXT:C284($UnpaidInvoices; $customerPO)
	$documentID:=Num:C11(WCapi_GetParameter("documentID"; ""))
	$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
	Case of 
		: ($tableName="Ledger")
			QUERY:C277([Ledger:30]; [Ledger:30]idNum:2=$documentID; *)
			QUERY:C277([Ledger:30];  & [Ledger:30]customerID:1=[Customer:2]customerID:1)
			If (Records in selection:C76([Ledger:30])=0)
				vResponse:="No valid Ledger by you for "+String:C10($documentID)
			Else 
				vResponse:="Record found."
				$doPage:=WC_DoPage("LedgersOne.html"; $jitPageOne)
			End if 
		: ($tableName="Invoice")
			QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=$documentID; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]customerID:3=[Customer:2]customerID:1)
			If (Records in selection:C76([Invoice:26])=0)
				vResponse:="No valid Invoice by you for "+String:C10($documentID)
			Else 
				vResponse:="Record found."
				P_IvcHeadVars
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
				$doPage:=WC_DoPage("InvoicesOne.html"; $jitPageOne)
			End if 
		: ($tableName="Payment")
			QUERY:C277([Payment:28]; [Payment:28]customerID:4=[Customer:2]customerID:1; *)
			QUERY:C277([Payment:28];  & [Payment:28]idNum:8=$documentID)
			If (Records in selection:C76([Payment:28])=0)
				vResponse:="No valid Payment by you for "+String:C10($documentID)
			Else 
				vResponse:="Record found."
				$doPage:=WC_DoPage("PaymentsOne.html"; $jitPageOne)
			End if 
	End case 
Else 
	vResponse:=vResponse+"Must be a customer to check Invoice status, remote user relates to :"+Table name:C256([EventLog:75]tableNum:9)+"\r"
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
vItemRelated:=""


If (False:C215)  //upgrade data
	READ WRITE:C146([Ledger:30])
	ALL RECORDS:C47([Ledger:30])
	FIRST RECORD:C50([Ledger:30])
	vi2:=Records in selection:C76([Ledger:30])
	For (vi1; 1; vi2)
		If ([Ledger:30]tableNum:3=26)
			[Ledger:30]tableName:13:="Invoice"
		Else 
			[Ledger:30]tableName:13:="Payment"
		End if 
		SAVE RECORD:C53([Ledger:30])
		NEXT RECORD:C51([Ledger:30])
	End for 
	UNLOAD RECORD:C212([Ledger:30])
End if 