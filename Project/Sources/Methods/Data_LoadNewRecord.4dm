//%attributes = {"shared":true}

// Modified by: Bill James (2022-01-28T06:00:00Z)
// Method: Data_LoadB4
// Description 
// Parameters
// ----------------------------------------------------
var $1; $2; $from_o; $to_o; $contact_o : Object



$to_o.action:=$from_o.action
$to_o.actionBy:=$from_o.actionBy
$to_o.actionDate:=$from_o.actionDate
$to_o.actionTime:=$from_o.actionTime

$to_o.bill2Company:=$from_o.company
$to_o.customerID:=$from_o.customerID
$to_o.typeSale:=$from_o.typeSale  //ititialize values  
$to_o.sector:=$from_o.sector  //ititialize values       
$to_o.repID:=$from_o.repID
$to_o.salesNameID:=$from_o.salesNameID
//vComRep:=CM_FindRate(->$to_o.repID; -><>aReps; -><>aRepRate)
//vComSales:=CM_FindRate(->$to_o.salesNameID; -><>aComNameID; -><>aEmpRate)
$to_o.status:="Open"
$to_o.complete:=False:C215
$to_o.shipPartial:=$from_o.shipPartial
$to_o.taxExemptid:=$from_o.taxExemptid


If ($from_o.contactBillTo>0)
	$to_o.contactBillTo:=$from_o.contactBillTo
	$to_o.contactShipTo:=$from_o.contactShipTo
End if 
If ($to_o.contactShipTo>0)
	$contact_o:=ds:C1482.Contact.query("idNum= :1"; $to_o.contactShipTo)
	$to_o.shipVia:=$contact_o.shipVia
	$to_o.attention:=$contact_o.nameFirst+" "+$contact_o.nameLast
	$to_o.zone:=$contact_o.zone
	$to_o.taxJuris:=$contact_o.taxJuris
	$to_o.contactShipTo:=$contact_o.idNum
	If ($contact_o.phone="")
		$to_o.phone:=$from_o.phone
	Else 
		$to_o.phone:=$contact_o.phone
	End if 
	If ($contact_o.fax="")
		$to_o.fax:=$from_o.fax
	Else 
		$to_o.fax:=$contact_o.fax
	End if 
	If ($contact_o.email="")
		$to_o.email:=$from_o.email
	Else 
		$to_o.email:=$contact_o.email
	End if 
Else 
	If (<>vbEmptyShip2)
		$to_o.company:="NoPrimeShip2"
		$to_o.company:=""
		$to_o.address1:=""
		$to_o.address2:=""
		$to_o.city:=""
		$to_o.state:=""
		$to_o.zip:=""
		$to_o.country:=""
		$to_o.zone:=-1
		$to_o.attention:=""
	Else 
		$to_o.shipVia:=$from_o.shipVia
		//Proposal_FillAddress("Customer")
		$to_o.zone:=$from_o.zone
		$to_o.attention:=$from_o.nameFirst+(" "*Num:C11($from_o.nameFirst#""))+$from_o.nameLast
	End if 
	$to_o.shipVia:=$from_o.shipVia
	$to_o.taxJuris:=$from_o.taxJuris
	$to_o.phone:=$from_o.phone
	$to_o.fax:=$from_o.fax
	$to_o.email:=$from_o.email
End if 
$to_o.phone:=$from_o.phone
$to_o.terms:=$from_o.terms
$to_o.adSource:=$from_o.adSource
$to_o.dateDocument:=Current date:C33
$to_o.shipAdjustments:=0
$to_o.fob:=Storage:C1525.default.fob
