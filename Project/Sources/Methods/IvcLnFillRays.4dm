//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-11T00:00:00, 09:15:12
// ----------------------------------------------------
// Method: IvcLnFillRays
// Description
// Modified: 11/11/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($cntLines; $i; $w; $lnTest; $2; $doByInvoiceLines; $1)

If (Record number:C243([Invoice:26])>-1)
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
	$cntLines:=Records in selection:C76([InvoiceLine:54])
Else 
	REDUCE SELECTION:C351([InvoiceLine:54]; 0)
End if 

IvcLn_RaySize(0; 0; 0)
//
$lnTest:=0
//
viBoxCnt:=0
If ($cntLines>0)
	$lnTest:=0
	$k:=Records in selection:C76([InvoiceLine:54])
	FIRST RECORD:C50([InvoiceLine:54])
	ORDER BY:C49([InvoiceLine:54]; [InvoiceLine:54]sequence:28)
	C_LONGINT:C283(viSeq)
	viSeq:=0
	For ($i; 1; $k)
		IvcLineFillArrayElement($i; 1)
		// [InvoiceLine]Sequence
		SAVE RECORD:C53([InvoiceLine:54])
		NEXT RECORD:C51([InvoiceLine:54])
	End for 
End if 

// Modified by: William James (2013-11-11T00:00:00)

viInvcLnCnt:=MaxValueInArray(->aiLineNum)

//

If (Size of array:C274(aiSeq)>1)
	SORT ARRAY:C229(aiSeq; aiLineAction; aiLineNum; aiItemNum; aiAltItem; aiQtyOrder; aiQtyRemain; aiQtyShip; aiQtyBL; aiDescpt; aiUnitPrice; aiDiscnt; aiUnitPriceDiscounted; aiTaxCost; aiPrintThis; aiPQDIR; aiExtPrice; aiUnitCost; aiExtCost; aiTaxable; aiSaleTax; aiSaleComm; aiSalesRate; aiRepComm; aiRepRate; aiUnitMeas; aiUnitWt; aiLocationBin; aiExtWt; aiLocation; aiQtyOpen; aiSerialRc; aiSerialNm; aiPricePt; aiProdBy; aiLnComment; aiShipOrdSt; aiProfile1; aiProfile2; aiProfile3; aiUniqueID; aiLnOrdUnique)
End if 

