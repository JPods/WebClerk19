//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-26T00:00:00, 23:23:14
// ----------------------------------------------------
// Method: IEA_UniqueByTables
// Description
// Modified: 04/26/17
// 
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1)
C_TEXT:C284($uniqueStr)
C_LONGINT:C283($uniqueLong)
C_BOOLEAN:C305($doSave)
$doSave:=True:C214
Case of 
	: ($1=(->[Lead:48]))
		$doSave:=IEA_UniqueThisTable(->[Lead:48]idNum:32)
		
	: ($1=(->[Customer:2]))
		$doSave:=IEA_UniqueThisTable(->[Customer:2]customerID:1)
	: ($1=(->[Forum:80]))
		$doSave:=IEA_UniqueThisTable(->[Forum:80]idNum:8)
	: ($1=(->[Order:3]))
		$doSave:=IEA_UniqueThisTable(->[Order:3]orderNum:2)
	: ($1=(->[Item:4]))
		$doSave:=IEA_UniqueThisTable(->[Item:4]itemNum:1)
	: ($1=(->[Rep:8]))
		$doSave:=IEA_UniqueThisTable(->[Rep:8]repID:1)
	: ($1=(->[TaxJurisdiction:14]))
		$doSave:=IEA_UniqueThisTable(->[TaxJurisdiction:14]taxJurisdiction:1)
	: ($1=(->[Service:6]))
		$doSave:=IEA_UniqueThisTable(->[Service:6]idNum:26)
	: ($1=(->[Process:16]))
		$doSave:=IEA_UniqueThisTable(->[Process:16]process:2)
	: ($1=(->[Employee:19]))
		$doSave:=IEA_UniqueThisTable(->[Employee:19]nameID:1)
	: ($1=(->[Territory:25]))
		$doSave:=IEA_UniqueThisTable(->[Territory:25]idNum:7)
	: ($1=(->[Invoice:26]))
		$doSave:=IEA_UniqueThisTable(->[Invoice:26]invoiceNum:2)
	: ($1=(->[InventoryStack:29]))
		$doSave:=IEA_UniqueThisTable(->[InventoryStack:29]idNum:1)
	: ($1=(->[Term:37]))
		$doSave:=IEA_UniqueThisTable(->[Term:37]termID:1)
	: ($1=(->[Vendor:38]))
		$doSave:=IEA_UniqueThisTable(->[Vendor:38]vendorID:1)
	: ($1=(->[PO:39]))
		$doSave:=IEA_UniqueThisTable(->[PO:39]poNum:5)
	: ($1=(->[Proposal:42]))
		$doSave:=IEA_UniqueThisTable(->[Proposal:42]proposalNum:5)
	: ($1=(->[Usage:5]))
		$doSave:=IEA_UniqueThisTable(->[Usage:5]idNum:28)
	: ($1=(->[SpecialDiscount:44]))
		$doSave:=IEA_UniqueThisTable(->[SpecialDiscount:44]idNum:4)
	: ($1=(->[ItemSerial:47]))
		$doSave:=IEA_UniqueThisTable(->[ItemSerial:47]idNum:18)
	: ($1=(->[Payment:28]))
		$doSave:=IEA_UniqueThisTable(->[Payment:28]idNum:8)
		Ledger_PaySave
	: ($1=(->[TechNote:58]))
		$doSave:=IEA_UniqueThisTable(->[TechNote:58]idNum:1)
	: ($1=(->[CronJob:82]))
		$doSave:=IEA_UniqueThisTable(->[CronJob:82]idNum:1)
End case 
$0:=$doSave