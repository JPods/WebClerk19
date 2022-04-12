//%attributes = {"publishedWeb":true}
//Procedure: Invc_PrimeDateP
C_LONGINT:C283($0)  //the pointer to the primary date for invoices as determined by defaults
Case of 
	: (<>tcPrIvDShip=1)
		<>ptInvoiceDateFld:=(->[Invoice:26]dateShipped:4)
	: (<>tcPrIvDShip=2)
		<>ptInvoiceDateFld:=(->[Invoice:26]dateLinked:31)
	Else 
		<>ptInvoiceDateFld:=(->[Invoice:26]dateInvoiced:35)
End case 