//%attributes = {}

// Modified by: Bill James (2021-12-01T06:00:00Z)
// Method: Contact_FillObj
// Description 
// Parameters
// ----------------------------------------------------
// Method: Contact_FillFrom
$parent_ent:=$1

var $1; $0; $parent_ent; $rec_ent : Object
$rec_ent:=ds:C1482.Contact.new()

$rec_ent.title:=$parent_ent.title
$rec_ent.nameFirst:=$parent_ent.nameFirst
$rec_ent.nameLast:=$parent_ent.nameLast
$rec_ent.fax:=$parent_ent.fax
$rec_ent.phone:=$parent_ent.phone
$rec_ent.phoneCell:=$parent_ent.phoneCell
$rec_ent.email:=$parent_ent.email
$rec_ent.shipVia:=$parent_ent.shipVia
$rec_ent.company:=$parent_ent.company
$rec_ent.address1:=$parent_ent.address1
$rec_ent.address2:=$parent_ent.address2
$rec_ent.city:=$parent_ent.city
$rec_ent.state:=$parent_ent.state
$rec_ent.zip:=$parent_ent.zip
$rec_ent.country:=$parent_ent.country
$rec_ent.taxJuris:=$parent_ent.taxJuris
$rec_ent.zone:=$parent_ent.zone
$rec_ent.customerID:=$parent_ent.customerID
$rec_ent.save()
$0:=$rec_ent