//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/12/13, 15:46:34
// ----------------------------------------------------
// Method: CreateItemSiteRecord
// Description
// 
//
//### jwm ### 20130220_1625 added 3rd parameter to pass initial quantity
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $siteID; $2; $itemNum)
C_REAL:C285($3; $qty)  //### jwm ### 20130220_1625 added 3rd parameter to pass initial quantity

$siteID:=$1
$itemNum:=$2

CREATE RECORD:C68([ItemSiteBucket:136])

[ItemSiteBucket:136]siteid:4:=$siteID
[ItemSiteBucket:136]itemNum:2:=$itemNum
[ItemSiteBucket:136]auditedBy:7:=Current user:C182
READ ONLY:C145([Item:4])
QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemSiteBucket:136]itemNum:2)
[ItemSiteBucket:136]itemDescription:3:=[Item:4]description:7
If (Count parameters:C259=3)  //### jwm ### 20130220_1625 added 3rd parameter to pass initial quantity
	$qty:=$3  //### jwm ### 20130220_1625 added 3rd parameter to pass initial quantity
	[ItemSiteBucket:136]qtyOnHand:5:=$qty
End if 
REDUCE SELECTION:C351([Item:4]; 0)
SAVE RECORD:C53([ItemSiteBucket:136])
