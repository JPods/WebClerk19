
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/27/20, 21:35:47
// ----------------------------------------------------
// Method: [Control].DeptSales.pbProducts
// Description
// 
//
// Parameters
// ----------------------------------------------------

//<declarations>
//==================================
//  Type variables 
//==================================

// <>tcPrsMemory;$childProcess
C_LONGINT:C283($viTableNum)
C_TEXT:C284($vtAddTitle; $vtScript; $tableName)

//==================================
//  Initialize variables 
//==================================

$viTableNum:=0
$vtAddTitle:=""
$vtScript:=""
$tableName:=""
//</declarations>

$vtScript:="Query By Formula([Item] ; (([Item]LifecycleStatus=\"Active\") & ([Item]Retired=false)))"

$vtAddTitle:=""
$viTableNum:=Table:C252(->[Item:4])
$tableName:=Table name:C256($viTableNum)

//ProcessTableQuery (Current process;$vtScript;$vtAddTitle;$viTableNum;True;True)  // ### jwm ### 20190701_1317 open in new process
$childProcess:=New process:C317("ProcessTableQuery"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+$tableName; Current process:C322; $vtScript; $vtAddTitle; $viTableNum; True:C214; True:C214)
