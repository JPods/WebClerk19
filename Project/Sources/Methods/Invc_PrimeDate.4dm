//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-26T06:00:00Z)
// Method: Invc_PrimeDate
// Description
// Parameters
// ----------------------------------------------------

var $0 : Date

Case of 
	: (<>tcPrIvDShip=1)
		$0:=ent.dateShipped
	: (<>tcPrIvDShip=2)
		$0:=ent.dateLinked
	Else 
		$0:=ent.dateDocument
End case 