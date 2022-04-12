//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/29/08, 19:08:27
// ----------------------------------------------------
// Method: Http_UniqueIDMatch
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $tableName; $0)
$tableName:=$1
Case of 
	: ($tableName="Customer")
		If (Record number:C243([Customer:2])#[EventLog:75]customerRecNum:8)
			$tableName:=""
		End if 
	: ($tableName="Proposal")
		If ([Proposal:42]customerID:1#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="CallReport")
		If ([CallReport:34]customerID:1#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="ServiceRecord")
		If ([Service:6]customerID:1#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="Contact")
		If ([Contact:13]customerID:1#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="Document")
		If ([Document:100]customerID:7#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="LoadItems")
		If ([LoadItem:87]customerID:18#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="LoadTag")
		If ([LoadTag:88]customerID:23#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="Payment")
		If ([Payment:28]customerID:4#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="Service")
		If ([Service:6]customerID:1#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="WorkOrder")
		If ([WorkOrder:66]customerID:28#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="QACustomer")
		If ([QA:70]customerID:1#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="ItemSerial")
		If ([ItemSerial:47]customerID:9#[Customer:2]customerID:1)
			$tableName:=""
		End if 
	: ($tableName="Item")
		If ([Item:4]mfrid:53#[Customer:2]customerID:1)
			$tableName:=""
		End if 
End case 
$0:=$tableName
Case of 
	: ([EventLog:75]tableNum:9=2)  //customers
		
	: ([EventLog:75]tableNum:9=13)  //contacts
		
		
	: ([EventLog:75]tableNum:9=48)  //leads
		
		
	: ([EventLog:75]tableNum:9=(Table:C252(->[ManufacturerTerm:111])))  //reps
		If ($tableName="Item")
			
		End if 
End case 