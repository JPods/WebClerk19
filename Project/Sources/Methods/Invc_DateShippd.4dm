//%attributes = {"publishedWeb":true}
//Procedure: Invc_DateShippd
C_DATE:C307($0)  //the DateShipped
C_DATE:C307($1; $OtherDate)  //the date to use if not using [Order]ShipOnDate or curr date if not passed
If (Count parameters:C259>=1)
	$OtherDate:=$1
Else 
	$OtherDate:=Current date:C33
End if 

If (<>tcOtoIShipD)
	$0:=[Order:3]dateShipOn:31
Else 
	$0:=$OtherDate
End if 