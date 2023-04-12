//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 02/05/19, 07:34:26
// ----------------------------------------------------
// Method: Tests_LogRecordEdit
// Description
// 
//
// Parameters
// ----------------------------------------------------

// SET UP
C_DATE:C307($vdActualOutput; $vdExpectedOutput)
C_BOOLEAN:C305($0)
$0:=True:C214

// TEST 1

$vdExpectedOutput:=!2010-06-01!
$vdActualOutput:=DateFromString("2010-06-01")

If ($vdActualOutput#$vdExpectedOutput)
	$0:=False:C215
	ConsoleLog("Tests_Date_Unstringify: Error when running method: Date_Unstringify (\"2010-06-01\")")
End if 

// TEST 2

$vdExpectedOutput:=!2010-06-01!
$vdActualOutput:=DateFromString("06/01/2010")

If ($vdActualOutput#$vdExpectedOutput)
	$0:=False:C215
	ConsoleLog("Tests_Date_Unstringify: Error when running method: Date_Unstringify (\"2010-06-01\")")
End if 

// TEST 3

$vdExpectedOutput:=!2010-06-01!
$vdActualOutput:=DateFromString("2010-06-01T00:00:00")

If ($vdActualOutput#$vdExpectedOutput)
	$0:=False:C215
	ConsoleLog("Tests_Date_Unstringify: Error when running method: Date_Unstringify (\"2010-06-01\";!01/01/2000!)")
End if 


// TEST 4

$vdExpectedOutput:=!00-00-00!
$vdActualOutput:=DateFromString("Non Date Text")

If ($vdActualOutput#$vdExpectedOutput)
	$0:=False:C215
	ConsoleLog("Tests_Date_Unstringify: Error when running method: Date_Unstringify (\"200-06-01\")")
End if 

// TEST 5

$vdExpectedOutput:=!2000-01-01!
$vdActualOutput:=DateFromString("Non Date Text"; !2000-01-01!)

If ($vdActualOutput#$vdExpectedOutput)
	$0:=False:C215
	ConsoleLog("Tests_Date_Unstringify: Error when running method: Date_Unstringify (\"200-06-01\";!01/01/2000!)")
End if 