//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/24/09, 01:17:06
// ----------------------------------------------------
// Method: AcceptBOM
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160505_1329 set [dBOM]DTEvent

C_TEXT:C284($comment)
$comment:=""

CREATE RECORD:C68([DBOM:129])
[DBOM:129]dtEvent:7:=DateTime_DTTo  // ### jwm ### 20160505_1329
[DBOM:129]changedBy:10:=Current user:C182
[DBOM:129]itemParent:3:=Old:C35([BOM:21]itemNum:1)
[DBOM:129]itemChild:4:=Old:C35([BOM:21]childItem:2)
[DBOM:129]itemParentNew:5:=[BOM:21]itemNum:1
[DBOM:129]itemChildNew:6:=[BOM:21]childItem:2
[DBOM:129]quantityOld:8:=Old:C35([BOM:21]qtyInAssembly:3)
[DBOM:129]quantityNew:9:=[BOM:21]qtyInAssembly:3

// last change is logged to Reason all changes are logged to the comment field
If ([BOM:21]itemNum:1#Old:C35([BOM:21]itemNum:1))
	[DBOM:129]reason:11:="ItemNum Changed"
	$comment:=String:C10(Current date:C33; 1)+";  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - "+[DBOM:129]reason:11+"\r"
	[DBOM:129]comment:12:=[DBOM:129]comment:12+$comment  // append
End if 

If ([BOM:21]childItem:2#Old:C35([BOM:21]childItem:2))
	[DBOM:129]reason:11:="ChildItem Changed"
	$comment:=String:C10(Current date:C33; 1)+";  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - "+[DBOM:129]reason:11+"\r"
	[DBOM:129]comment:12:=[DBOM:129]comment:12+$comment  // append
End if 

If ([BOM:21]qtyInAssembly:3#Old:C35([BOM:21]qtyInAssembly:3))
	[DBOM:129]reason:11:="Qty Changed"
	$comment:=String:C10(Current date:C33; 1)+";  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - "+[DBOM:129]reason:11+"\r"
	[DBOM:129]comment:12:=[DBOM:129]comment:12+$comment  // append
End if 

If (Is new record:C668([BOM:21]))  // because of CREATE RECORD([dBOM]) it is always going to be a new record 
	[DBOM:129]reason:11:="New BOM Record"
	$comment:=String:C10(Current date:C33; 1)+";  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - "+[DBOM:129]reason:11+"\r"
	[DBOM:129]comment:12:=[DBOM:129]comment:12+$comment  // append
End if 

SAVE RECORD:C53([DBOM:129])
UNLOAD RECORD:C212([DBOM:129])
SAVE RECORD:C53([BOM:21])
