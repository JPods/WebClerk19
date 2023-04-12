//%attributes = {}

// Modified by: Bill James (2022-06-18T05:00:00Z)
// Method: Init_obGeneral
// Description 
// Parameters
// ----------------------------------------------------

// add this to triggers at some point
var $0 : Object
$0:=New object:C1471(\
"keyTags"; ""; \
"keyText"; ""; \
"id_TallyChange"; ""; \
"rev"; New object:C1471(\
"date"; current data; \
"who"; Current user:C182); \
"health"; New collection:C1472; \
"voState"; New object:C1471; \
"docPaths"; New object:C1471; \
"history"; New collection:C1472)