//%attributes = {"publishedWeb":true}
//C_LONGINT($k)
//C_REAL($TaxRate)
//$TaxRate:=sTaxRate
//Case of 
//: (ptCurFile=([Order]))
//$k:=acShipZip
//[Order]Company:=acShipCo{$k}
//[Order]Address1:=acShipAddr1{$k}
//[Order]Address2:=acShipAddr2{$k}
//[Order]City:=acShipCity{$k}
//[Order]State:=acShipSt{$k}
//[Order]Zip:=acShipZip{$k}
//[Order]Zone:=acShipZone{$k}
//[Order]Country:=acShipCntry{$k}
//[Order]ShipVia:=acShipVia{$k}
//[Order]TaxJuris:=acShipTax{$k}
//[Order]Attention:=acShipAttn{$k}
//TaxDoReCalc (sTaxRate;[Order]TaxJuris;[Customer]TaxExemptID
//;doTax;[Order]SalesTax;aOSaleTax;aOTaxable;aOExtPrice)
//: (ptCurFile=([Invoice]))
//$k:=acShipZip
//[Invoice]Company:=acShipCo{$k}
//[Invoice]Address1:=acShipAddr1{$k}
//[Invoice]Address2:=acShipAddr2{$k}
//[Invoice]City:=acShipCity{$k}
//[Invoice]State:=acShipSt{$k}
//[Invoice]Zip:=acShipZip{$k}
//[Invoice]Zone:=acShipZone{$k}
//[Invoice]Country:=acShipCntry{$k}
//[Invoice]ShipVia:=acShipVia{$k}
//[Invoice]TaxJuris:=acShipTax{$k}
//[Invoice]Attention:=acShipAttn{$k}
//TaxDoReCalc (sTaxRate;[Invoice]TaxJuris;[Customer]TaxExemptID
//;doTax;[Invoice]SalesTax;aiSaleTax;aiTaxable;aiExtPrice)
//: (ptCurFile=([Proposal]))
//$k:=acShipZip
//[Proposal]Company:=acShipCo{$k}
//[Proposal]Address1:=acShipAddr1{$k}
//[Proposal]Address2:=acShipAddr2{$k}
//[Proposal]City:=acShipCity{$k}
//[Proposal]State:=acShipSt{$k}
//[Proposal]Zip:=acShipZip{$k}
//[Proposal]Zone:=acShipZone{$k}
//[Proposal]Country:=acShipCntry{$k}
//[Proposal]ShipVia:=acShipVia{$k}
//[Proposal]TaxJuris:=acShipTax{$k}
//[Proposal]Attention:=acShipAttn{$k}
//TaxDoReCalc (sTaxRate;[Proposal]TaxJuris;[Customer]TaxExemptID
//;doTax;[Proposal]SalesTax;aPSaleTax;aPTaxable;aPExtPrice)
//End case 