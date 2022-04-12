//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/28/21, 07:35:06
// ----------------------------------------------------
// Method: Proposal_ShowOpen
// Description
// 
// Parameters
// ----------------------------------------------------




C_POINTER:C301(ptCurTable)

var $tableName; $vtScript; $vtAddTitle : Text
$tableName:="Proposal"
$vtScript:="echo_o:=ds.Proposal.query(\"complete = false \")"
var $oData : Object
$oData:=ds:C1482.Proposal.query("complete = false")
$vtAddTitle:="Open Proposals"
var $process_o : Object
// this seems wrong QQQ
$process_o:=New object:C1471("ents"; New object:C1471("Proposal"; $oData); \
"cur"; $oData; \
"sel"; New object:C1471; \
"pos"; -1; \
"entsOther"; New object:C1471("tableName"; New object:C1471); \
"task"; "currentData"; \
"tableName"; "Proposal"; \
"tableForm"; ""; \
"form"; "OutputDS"; "process"; Current process:C322; \
"title"; $vtAddTitle)
$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $process_o)
