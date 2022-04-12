//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/03/07, 01:34:33
// ----------------------------------------------------
// Method: IEA_SaveRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_LONGINT:C283($w)
C_BOOLEAN:C305(allowAlerts_boo)
$skipSave:=1
$0:=""
Case of 
	: ($1=(->[Customer:2]))
		If ([Customer:2]customerID:1="")
			[Customer:2]customerID:1:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Customer:2]))
		End if 
		$0:=[Customer:2]customerID:1
	: ($1=(->[Item:4]))
		If ([Item:4]itemNum:1="")
			[Item:4]itemNum:1:=String:C10(CounterNew($1))
		End if 
		$0:=[Item:4]itemNum:1
	: ($1=(->[Rep:8]))
		If ([Rep:8]repID:1="")
			[Rep:8]repID:1:=String:C10(CounterNew($1))
		End if 
		$0:=[Rep:8]repID:1
	: ($1=(->[Vendor:38]))
		If ([Vendor:38]vendorID:1="")
			[Vendor:38]vendorID:1:=String:C10(CounterNew($1))
		End if 
		$0:=[Vendor:38]vendorID:1
		
		
	: ($1=(->[Order:3]))
		If ([Order:3]orderNum:2=0)
			[Order:3]orderNum:2:=CounterNew($1)
		End if 
		$0:=String:C10([Order:3]orderNum:2)
	: ($1=(->[Invoice:26]))
		If ([Invoice:26]invoiceNum:2=0)
			[Invoice:26]invoiceNum:2:=CounterNew($1)
		End if 
		$0:=String:C10([Invoice:26]invoiceNum:2)
	: ($1=(->[PO:39]))
		If ([PO:39]poNum:5=0)
			[PO:39]poNum:5:=CounterNew($1)
		End if 
		$0:=String:C10([PO:39]poNum:5)
	: ($1=(->[Proposal:42]))
		If ([Proposal:42]proposalNum:5=0)
			[Proposal:42]proposalNum:5:=CounterNew($1)
		End if 
		$0:=String:C10([Proposal:42]proposalNum:5)
	: ($1=(->[WorkOrder:66]))
		If ([WorkOrder:66]woNum:29=0)
			[WorkOrder:66]woNum:29:=CounterNew($1)
		End if 
		$0:=String:C10([WorkOrder:66]woNum:29)
	: ($1=(->[Project:24]))
		If ([Project:24]projectNum:1=0)
			[Project:24]projectNum:1:=CounterNew($1)
		End if 
		$0:=String:C10([Project:24]projectNum:1)
End case 

