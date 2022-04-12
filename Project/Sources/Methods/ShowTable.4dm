//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 06/26/19, 10:12:21
// ----------------------------------------------------
// Method: ShowTable
// Description
// open output layput for selected table
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($viTableNum)
C_TEXT:C284($vtAddTitle; $vtScript)

$viTableNum:=0
$vtAddTitle:=""
$vtScript:=""
//</declarations>

If (<>aTableNames>0)  // ### jwm ### 20190131_0836
	C_LONGINT:C283($viNameNum)
	$tableName:=<>aTableNames{<>aTableNames}
	$viNameNum:=<>aTableNames
	$viTableNum:=<>aTableNums{$viNameNum}
	//ProcessTableOpen (<>aTableNums{<>aTableNames};"All Records(table(<>aTableNums{<>aTableNames})->)")
	$vtScript:="All Records(["+$tableName+"])"
	$vtAddTitle:=""
	ProcessTableOpen($tableName; $vtScript; $vtAddTitle)
End if 
