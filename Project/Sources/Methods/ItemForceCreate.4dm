//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/25/06, 13:07:56
// ----------------------------------------------------
// Method: ItemForceCreate
// Description
// Version_0602
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($2)
CREATE RECORD:C68([Item:4])
[Item:4]itemNum:1:=$1  ////"OverRide"
[Item:4]description:7:=$2  //"OverRide"
[Item:4]qtySaleDefault:15:=1
[Item:4]priceA:2:=0
[Item:4]priceB:3:=0
[Item:4]priceC:4:=0
[Item:4]priceD:5:=0
[Item:4]notTracked:56:=True:C214
[Item:4]taxid:17:="Tax"
[Item:4]costGLAccount:22:="CostGL"
[Item:4]inventoryGlAccount:23:="InventoryGL"
[Item:4]salesGlAccount:21:="SalesGL"
SAVE RECORD:C53([Item:4])
