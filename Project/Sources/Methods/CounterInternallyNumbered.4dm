//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-10-13T00:00:00, 11:33:20
// ----------------------------------------------------
// Method: CounterInternallyNumbered
// Description
// Modified: 10/13/16
// 
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptTable)
C_BOOLEAN:C305($0)
$ptTable:=$1
$0:=True:C214  // $returnOriginalValue
Case of 
	: (($ptTable=(->[QQQCustomer:2])) | ($ptTable=(->[QQQContact:13])) | ($ptTable=(->[Lead:48])))
		$0:=False:C215
	: (($ptTable=(->[QQQPOLine:40])) | ($ptTable=(->[OrderLine:49])))
		$0:=False:C215
	: (($ptTable=(->[QQQVendor:38])) | ($ptTable=(->[Rep:8])) | ($ptTable=(->[Employee:19])))
		$0:=False:C215
	: (($ptTable=(->[Order:3])) | ($ptTable=(->[Proposal:42])) | ($ptTable=(->[Invoice:26])) | ($ptTable=(->[PO:39])))
		$0:=False:C215
	: (($ptTable=(->[Item:4])) | ($ptTable=(->[Project:24])) | ($ptTable=(->[WorkOrder:66])))
		$0:=False:C215
		
	: (($ptTable=(->[CashJournal:52])) | ($ptTable=(->[SalesJournal:50])) | ($ptTable=(->[PurchaseJournal:51])))
		$0:=False:C215
		
	: (($ptTable=(->[EventLog:75])))
		$0:=False:C215
	: (($ptTable=(->[QQQCarrier:11])))
		$0:=False:C215
	: (($ptTable=(->[DefaultQQQ:15])))  // one record table
		$0:=False:C215
	: (($ptTable=(->[DefaultAccount:32])))  // one record table
		$0:=False:C215
	: (($ptTable=(->[WebClerk:78])))  // one record table
		$0:=False:C215  // use in CounterNew 
End case 

