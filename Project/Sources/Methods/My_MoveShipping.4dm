//%attributes = {"publishedWeb":true}
//C_LONGINT($i;$k;$r;$t)
//CONFIRM("Convert Alternate Ship To's to Contacts?")
//If (OK=1)
//ALL RECORDS([Customer])
//FIRST RECORD([Customer])
//$k:=Records in selection([Customer])
//ThermoInitExit ("Processing ShipTo's to Contacts.";$k;True)
//For ($i;1;$k)
//ThermoUpdate ($i)
//If (<>ThermoAbort)
//$i:=$k
//End if 
//ALL SUBRECORDS([Customer]ShipTo)
//$t:=Records in sub_selection([Customer]ShipTo)
//If ($t>0)
//For ($r;1;$t)
//CREATE RECORD([Contact])

//[Contact]customerID:=[Customer]customerID
//[Contact]Company:=[Customer]ShipTo'LnCompany
//[Contact]Address1:=[Customer]ShipTo'LnAddress1
//[Contact]Address2:=[Customer]ShipTo'LnAddress2
//[Contact]City:=[Customer]ShipTo'LnCity
//[Contact]State:=[Customer]ShipTo'LnState
//[Contact]Zip:=[Customer]ShipTo'LnZip
//[Contact]Country:=[Customer]ShipTo'LnCountry
//[Contact]LastName:=[Customer]ShipTo'LnAttn
//[Contact]Profile1:=[Customer]ShipTo'LnPhone
//[Contact]Zone:=[Customer]ShipTo'LnZone
//[Contact]ShipVia:=[Customer]ShipTo'LnShipVia
//[Contact]TaxJuris:=[Customer]ShipTo'LnTaxJuris
//If ([Contact]LastName="")
//[Contact]LastName:=[Contact]Zip
//End if 
//SAVE RECORD([Contact])
//NEXT SUBRECORD([Customer]ShipTo)
//End for 
//jdeleteAllSubRe ([Customer]ShipTo)
//End if 
//NEXT RECORD([Customer])
//End for 
//ThermoClose 
//End if 