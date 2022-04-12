//%attributes = {"publishedWeb":true}



C_OBJECT:C1216(voState)
C_OBJECT:C1216($voCompany)
$voCompany:=New object:C1471("Company"; Storage:C1525.default.company; "Address"; Storage:C1525.default.address; "Phone"; Storage:C1525.default.phone; "Fax"; Storage:C1525.default.fax; "Email"; Storage:C1525.default.email)
$voCompany:=ds:C1482.Default.query("primeDefault = 1 ").first()
Storage:C1525.default.address:=jConcat($voCompany.company; "\r")+jConcat($voCompany.address1; "\r")+jConcat($voCompany.address2; "\r")+jConcat($voCompany.city; ", ")+jConcat($voCompany.state; "  ")+jConcat($voCompany.zip; "\r")+jConcat($voCompany.country)
Storage:C1525.default.address:=Txt_TrimTrailingCR(Storage:C1525.default.address)

C_OBJECT:C1216($voChanges; $voList)
$vrQtyNew:=0
$vrPrice:=0
$vrDiscount:=0
$vtDescription:=""
$vtUUIDKey:=""
$vtItemNum:=""
$voList:=New object:C1471
$voChanges:=New object:C1471
$voChanges.qtyOrdered:=$vrQtyNew
$voChanges.discount:=$vrDiscount
$voChanges.unitPrice:=$vrPrice
$voChanges.remoteUser:="Bill"
$voChanges.qtyBackLogged:=$vrQtyBackLogged
$voList.changes:=$voChanges

