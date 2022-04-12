//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-26T00:00:00, 12:10:22
// ----------------------------------------------------
// Method:  
// Description
// Modified: 01/26/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


Case of 
	: (ptCurTable=(->[Order:3]))
		FIRST RECORD:C50([OrderLine:49])
		pvItemNum:=[OrderLine:49]itemNum:4
		pvAltItem:=[OrderLine:49]altItem:31
		pvDescription:=[OrderLine:49]description:5
		pvUnitMeas:=[OrderLine:49]unitofMeasure:19
		pvLocation:=String:C10([OrderLine:49]location:22; <>tcFormatTt)
		pvUnitWt:=String:C10([OrderLine:49]unitWt:20; <>tcFormatTt)
		pvExtWt:=String:C10([OrderLine:49]extendedWt:21; <>tcFormatTt)
		pvUnitPrice:=String:C10(DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP); <>tcFormatUP)
		pvExtPrice:=String:C10([OrderLine:49]extendedPrice:11; <>tcFormatTt)
	: (ptCurTable=(->[Invoice:26]))
		FIRST RECORD:C50([InvoiceLine:54])
		pvItemNum:=[InvoiceLine:54]itemNum:4
		pvAltItem:=[InvoiceLine:54]altItem:29
		pvDescription:=[InvoiceLine:54]description:5
		pvUnitMeas:=[InvoiceLine:54]unitofMeasure:19
		pvLocation:=String:C10([InvoiceLine:54]location:22; <>tcFormatTt)
		pvUnitWt:=String:C10([InvoiceLine:54]unitWt:20; <>tcFormatTt)
		pvExtWt:=String:C10([InvoiceLine:54]extendedWt:21; <>tcFormatTt)
		pvUnitPrice:=String:C10(DiscountApply([InvoiceLine:54]unitPrice:9; [InvoiceLine:54]discount:10; <>tcDecimalUP); <>tcFormatUP)
		pvExtPrice:=String:C10([InvoiceLine:54]extendedPrice:11; <>tcFormatTt)
	: (ptCurTable=(->[Proposal:42]))
		FIRST RECORD:C50([ProposalLine:43])
		pvItemNum:=[ProposalLine:43]itemNum:2
		pvAltItem:=[ProposalLine:43]altItemNum:34
		pvDescription:=[ProposalLine:43]description:4
		pvUnitMeas:=[ProposalLine:43]saleUnitofMeas:13
		pvLocation:=String:C10([ProposalLine:43]location:12; <>tcFormatTt)
		pvUnitWt:=String:C10([ProposalLine:43]unitWeight:22; <>tcFormatTt)
		pvExtWt:=String:C10([ProposalLine:43]extendedWt:19; <>tcFormatTt)
		pvUnitPrice:=String:C10(DiscountApply([ProposalLine:43]unitPrice:15; [ProposalLine:43]discount:17; <>tcDecimalUP); <>tcFormatUP)
		pvExtPrice:=String:C10([ProposalLine:43]extendedPrice:16; <>tcFormatTt)
	: (ptCurTable=(->[PO:39]))
		FIRST RECORD:C50([QQQPOLine:40])
		pvItemNum:=[QQQPOLine:40]itemNum:2
		pvAltItem:=[QQQPOLine:40]altItemNum:20
		pvDescription:=[QQQPOLine:40]description:6
		pvUnitMeas:=[QQQPOLine:40]unitOfMeasure:12
		pvUnitCost:=String:C10(DiscountApply([QQQPOLine:40]unitCost:7; [QQQPOLine:40]discount:8; <>tcDecimalUP); <>tcFormatUP)
		pvExtPrice:=String:C10([QQQPOLine:40]extendedCost:9; <>tcFormatTt)
End case 