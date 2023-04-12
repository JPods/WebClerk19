//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/15/21, 21:21:31
// ----------------------------------------------------
// Method: WCapiTask_SaveMinimums
// Description
// 
//
// Parameters
// ----------------------------------------------------
//WC_Parse
//$minOK:=WC_ParseMinRequired(Table($tableNum);$2)
// add procedure for table specific requirements
//WccAcceptTasks($ptTable;$newRecord;$doSave;$2)
C_OBJECT:C1216($2; $0; $obRec)
C_TEXT:C284($1; $tableName)
$tableName:=$1
$obRec:=$2
$obRec.statusConnect:=New object:C1471
Case of 
	: ($tableName="Order")
		If ($obRec.orderNum=0)
			$obRec.orderNum:=CounterNew(->[Order:3])
			// $0:=False
			// vResponse:="Echo of another order. Check for commands on a page."
		End if 
	: ($tableName="Invoice")
		If ($obRec.invoiceNum=0)
			$obRec.invoiceNum:=CounterNew(->[Invoice:26])
		End if 
		If ($obRec.orderNum=0)
			$obRec.orderNum:=1
		End if 
	: ($tableName="Customer")
		If ($obRec.customerID="")
			$obRec.customerID:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Customer:2]))
		End if 
		If ($obRec.company="")
			$obRec.company:=$obRec.nameLast+((", ")*Num:C11($obRec.nameLast#""))+$obRec.nameFirst
			$obRec.individual:=True:C214
		End if 
	: ($tableName="Item")
		If ($obRec.itemNum="")
			$obRec.itemNum:=String:C10(CounterNew(->[Item:4]))
		End if 
	: ($tableName="Rep")
		If ($obRec.repID="")
			$obRec.repID:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Rep:8]))
		End if 
	: ($tableName="Vendor")
		If ($obRec.vendorID="")
			$obRec.vendorID:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Vendor:38]))
		End if 
	: ($tableName="Payment")
		C_REAL:C285($tendered; $payChange)
		If ($obRec.dateLinked#!00-00-00!)
			vResponse:="Error: Payment is linked and cannot be modified."
			$obRec.statusConnect:="Error: Payment is linked and cannot be modified."
		Else 
			If ($obRec.statusConnect="")  //any payment not cleared with not journalize
				$obRec.statusConnect:="HOLD_web"
			End if 
			$obRec.dateReceived:=Current date:C33
			$obRec.dtSync:=DateTime_DTTo
			If ($obRec.isNew())
				$obRec.change:=0
				$obRec.amount:=$obRec.tendered
				$obRec.amountAvailable:=$obRec.tendered
			Else 
				$obRec.change:=$obRec.tendered-$obRec.obGeneral.old.tendered
				$obRec.amount:=$obRec.amount+$obRec.change
				$obRec.amountAvailable:=$obRec.amountAvailable+$obRec.change
			End if 
			$obRec.takeBy:=[RemoteUser:57]userName:2
			// QQQ???? Fix this
		End if 
	: ($tableName="PO")
		If ($obRec.poNum=0)
			$obRec.poNum:=CounterNew(->[PO:39])
		End if 
	: ($tableName="Proposal")
		If ($obRec.proposalNum=0)
			$obRec.proposalNum:=CounterNew(->[Proposal:42])
		End if 
		
	: ($tableName="OrderLine")
		If ($obRec.orderNum=0)
			$obRec.statusConnect:="Error: You must have an existing Order to save an Order Line"
		Else 
			// QQQ???? Fix this and dInventory
		End if 
	: ($tableName="InvoiceLine")
		If ($obRec.invoiceNum=0)
			$obRec.saveStatus:="Error: You must have an existing Invoice to save an Invoice Line"
		Else 
			// QQQ???? Fix this and dInventory
		End if 
	: ($tableName="ProposalLine")
		If ($obRec.proposalNum=0)
			$obRec.statusConnect:="Error: You must have an existing Proposal to save an Proposal Line"
		End if 
		
	: ($tableName="POLine")
		If ($obRec.poNum=0)
			$obRec.statusConnect:="Error: You must have an existing PO to save an PO Line"
		End if 
End case 