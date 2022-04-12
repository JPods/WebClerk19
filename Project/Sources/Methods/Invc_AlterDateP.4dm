//%attributes = {"publishedWeb":true}
//Procedure: Invc_AlterDateP
C_POINTER:C301($0)  //the pointer to the alternate date for invoices as determined by defaults
Case of 
	: (<>tcPrIvDShip=1)
		$0:=(->[Invoice:26]dateInvoiced:35)
	: (<>tcPrIvDShip=2)
		$0:=(->[Invoice:26]dateLinked:31)
	Else 
		$0:=(->[Invoice:26]dateShipped:4)
End case 