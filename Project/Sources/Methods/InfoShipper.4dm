//%attributes = {"publishedWeb":true}


// Modified by: Bill James (2022-01-30T06:00:00Z)
// Method: InfoShipper
// Description 
// Parameters
// ----------------------------------------------------

var $1 : Text
var $o : Object
If (vShipper#$1)
	$o:=ds:C1482.Carrier.query("carrierID = :1 & active =  :2"; $1; True:C214).first()
	If ($o#Null:C1517)
		vShipper:=$o.carrierid  //vShipper
		vShipperID:=$o.shipperid  //vShipperID
		vFrghtType:=$o.freightType  //vFrghtType
	Else 
		vShipper:=$1
		vShipperID:=""
		vFrghtType:=""
	End if 
End if 