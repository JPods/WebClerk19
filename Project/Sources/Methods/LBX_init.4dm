//%attributes = {}

// Modified by: Bill James (2022-04-11T05:00:00Z)
// Method: LBX_init
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($lb_Name : Text)->$return : Object
var $lb_o : Object




$lb_o:=New object:C1471($lb_Name; New object:C1471("type"; "listbox"; \
"left"; 3; \
"top"; 3; \
"width"; 746; \
"height"; 232; \
"events"; New collection:C1472; \
"alternateFill"; "#FFFAE6"; \
"movableRows"; True:C214; \
"listboxType"; "collection"; \
"dataSource"; $lb_name+".ents"; \
"currentItemSource"; $lb_name+".cur"; \
"currentItemPositionSource"; $lb_name+".pos"; \
"selectedItemsSource"; $lb_name+".sel"; \
"columns"; New collection:C1472))

$lb_o.events.push("onClick")
$lb_o.events.push("onDoubleClick")
$lb_o.events.push("onDataChange")
$lb_o.events.push("onSelectionChange")

$lb_o:=New object:C1471($lb_Name; New object:C1471("type"; "listbox"; \
"left"; 3; \
"top"; 3; \
"width"; 746; \
"height"; 232; \
"events"; New collection:C1472("onClick"; \
"onDoubleClick"; \
"onDataChange"; \
"onSelectionChange"); \
"alternateFill"; "#FFFAE6"; \
"movableRows"; True:C214; \
"listboxType"; "collection"; \
"dataSource"; $lb_name+".ents"; \
"currentItemSource"; $lb_name+".cur"; \
"currentItemPositionSource"; $lb_name+".pos"; \
"selectedItemsSource"; $lb_name+".sel"; \
"columns"; New collection:C1472))