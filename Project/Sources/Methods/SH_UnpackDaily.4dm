//%attributes = {"publishedWeb":true}
//Procedure: SH_UnpackDaily
//of what use is this
//looks like finding and building array while printing from the Cust or Rep file
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_DATE:C307($3; $4)
C_LONGINT:C283($i; $k)
READ ONLY:C145([Invoice:26])
READ ONLY:C145([Order:3])
READ ONLY:C145([DInventory:36])
CREATE EMPTY SET:C140([DInventory:36]; "Current")
If ($1=1)
	QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=$2; *)
Else 
	QUERY:C277([Invoice:26]; [Invoice:26]repID:22=$2; *)
End if 
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld->>=$3; *)
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><=$4)
$k:=Records in selection:C76([Invoice:26])
FIRST RECORD:C50([Invoice:26])
For ($i; 1; $k)
	QUERY:C277([DInventory:36]; [DInventory:36]docid:9=[Invoice:26]invoiceNum:2; *)
	QUERY:C277([DInventory:36]; [DInventory:36]typeid:14="IV")
	CREATE SET:C116([DInventory:36]; "Temp")
	UNION:C120("Current"; "Temp"; "Current")
	CLEAR SET:C117("Temp")
	NEXT RECORD:C51([Invoice:26])
End for 
If ($1=1)
	QUERY:C277([Order:3]; [Order:3]customerID:1=$2; *)
Else 
	QUERY:C277([Order:3]; [Order:3]repID:8=$2; *)
End if 
QUERY:C277([Order:3]; [Order:3]customerID:1=$2; *)
QUERY:C277([Order:3];  & [Order:3]dateOrdered:4>=$3; *)
QUERY:C277([Order:3];  & [Order:3]dateOrdered:4<=$4)
$k:=Records in selection:C76([Order:3])
FIRST RECORD:C50([Order:3])
For ($i; 1; $k)
	QUERY:C277([DInventory:36]; [DInventory:36]docid:9=[Order:3]orderNum:2; *)
	QUERY:C277([DInventory:36]; [DInventory:36]typeid:14="OR")
	CREATE SET:C116([DInventory:36]; "Temp")
	UNION:C120("Current"; "Temp"; "Current")
	CLEAR SET:C117("Temp")
	NEXT RECORD:C51([Order:3])
End for 
USE SET:C118("Current")
CLEAR SET:C117("current")
SH_OrderElem