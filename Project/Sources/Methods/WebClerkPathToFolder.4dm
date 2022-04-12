//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-26T00:00:00, 21:23:34
// ----------------------------------------------------
// Method: WebClerkPathToFolder
// Description
// Modified: 08/26/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($tempFold; $testName; $testPath; $longName; $1; $0)
$longName:=$1
If ($longName#"")
	$longName:=PathtoUniversal($longName)
	If ($longName="@jitWeb@")  // then do not allow .// above the location of the "jitWeb"
		$0:=$longName
	Else 
		ALERT:C41("jitWeb folder must contain 'jitWeb'.")
		$0:=""
	End if 
End if 