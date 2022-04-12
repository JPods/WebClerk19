//%attributes = {}

// Modified by: Bill James (2022-01-27T06:00:00Z)
// Method: Data_AddressCopy
// Description 
// Parameters
// ----------------------------------------------------



var $1; $2; $from; $to : Object
$from:=$1
$to:=$2
If ($to.company#Null:C1517)
	$to.company:=$from.company
End if 
$to.address1:=$from.address1
$to.address2:=$from.address2
$to.city:=$from.city
$to.state:=$from.state
$to.zip:=$from.zip
$to.country:=$from.country
$to.lat:=$from.lat
$to.lng:=$from.lng
Case of 
	: (($from.nameFirst#Null:C1517) & ($to.nameFirst#Null:C1517))
		$to.nameFirst:=$from.nameFirst
		$to.nameLast:=$from.nameLast
	: (($from.nameFirst#Null:C1517) & ($to.nameFirst=Null:C1517))
		$to.attention:=$from.nameFirst+(" "*Num:C11($from.nameFirst#""))+$from.nameLast
		$to.objectGeneral.attention:=New object:C1471("first"; $from.nameFirst; "last"; $from.nameLast)
	: (($from.attention#Null:C1517) & ($to.attention#Null:C1517))
		$to.attention:=$from.attention
	: (($from.attention#Null:C1517) & ($to.nameFirst#Null:C1517))
		$to.objectGeneral.attention:=$from.attention
End case 

If ($from.attention=Null:C1517)
	$to.attention:=$from.nameFirst+(" "*Num:C11($from.nameFirst#""))+$from.nameLast
End if 
$to.fax:=$from.fax
$to.phone:=$from.phone
$to.phoneCell:=$from.phoneCell
$to.email:=$from.email


