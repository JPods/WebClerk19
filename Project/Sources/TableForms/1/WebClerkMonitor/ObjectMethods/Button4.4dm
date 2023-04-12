// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-16T00:00:00, 13:58:46
// ----------------------------------------------------
// Method: [Control].HTTPD_Monitor.Button4
// Description
// Modified: 08/16/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
//jitWebPath.txt   contains the path to the Storage.wc.webFolder

C_TEXT:C284($tempFold; $testName; $testPath; $parentPath)
$tempFold:=""


ProcessTableOpen(Table:C252(->[WebClerk:78]); "QUERY([WebClerk];[WebClerk]PathTojitWeb=Storage.wc.webFolder)"; "Active")





