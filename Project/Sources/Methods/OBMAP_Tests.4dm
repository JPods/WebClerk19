//%attributes = {}
If (False:C215)
	
	C_BOOLEAN:C305($vbAllowed)
	$vbAllowed:=USR_IsAllowedTo("ViewRecords"; "interactions")
	$vbAllowed:=USR_IsAllowedTo("ViewRecord"; "interactions"; "34959")
	$vbAllowed:=USR_IsAllowedTo("EditRecord"; "interactions"; "34959")
	$vbAllowed:=USR_IsAllowedTo("ViewRecord"; "interactions"; "25670")
	$vbAllowed:=USR_IsAllowedTo("EditRecord"; "interactions"; "25670")
	$vbAllowed:=USR_IsAllowedTo("CreateRecords"; "interactions")
	$vbAllowed:=USR_IsAllowedTo("ApproveRecords"; "interactions")
	$vbAllowed:=USR_IsAllowedTo("ViewResourceSummary"; "interactions")
	
End if 



C_OBJECT:C1216($voWrapper)

C_COLLECTION:C1488($vcRecords; $vcIDs)
//$vcRecords:=ds.RemoteUser.query("( Groups = '@Interactions@' OR Groups = '@CRM@' ) AND SecurityLevel >= 2").toCollection("customerID, UserName")
$vcRecords:=ds:C1482.RemoteUser.all().toCollection("customerID, userName")

$vcRecords:=$vcRecords.map("OBMAP_AddProps"; New collection:C1472(New object:C1471("NewProperty1"; "NewValue1"); New object:C1471("NewProperty2"; "NewValue2")))

// this failes
$vcRecords:=$vcRecords.map("OBMAP_RemoveProps"; New collection:C1472("NewProperty1"; "NewProperty2"))

$vcRecords:=$vcRecords.map("OBMAP_AddProp"; New object:C1471("NewProperty1"; "NewValue1"))
$vcRecords:=$vcRecords.map("OBMAP_RemoveProp"; "NewProperty1")

$vcRecords:=$vcRecords.map("OBMAP_RenameProp"; "UserName"; "UserAccount")

$vcIDs:=$vcRecords.map("OBMAP_ExtractPropIntoCollection"; "customerID")




