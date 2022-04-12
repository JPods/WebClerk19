//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 07/23/19, 12:05:52
// ----------------------------------------------------
// Method: Date_Unstringify
// Description
// 
//
// Parameters
// ----------------------------------------------------

// *************************************************** //
// *** GET PARAMETERS ******************************** //
// *************************************************** //

// PARAMETER 0 WILL BE THE UN-STRINGIFIED DATE
C_DATE:C307($0; $vdDate)

// PARAMETER 1 IS THE STRINGIFIED DATE THAT WE ARE
// GOING TO UNSTRINGIFY

C_TEXT:C284($1; $vtStringifiedDate)
$vtStringifiedDate:=$1

// PARAMETER 2 IS OPTIONAL. IT IS THE DEFAULT DATE
// VALUE WHICH WILL BE RETURNED IF THE STRING CANNOT
// BE CONVERTED INTO A PROPER DATE

C_DATE:C307($vdDefaultIfError)
If (Count parameters:C259>=2)
	C_DATE:C307($2)
	$vdDefaultIfError:=$2
Else 
	$vdDefaultIfError:=!00-00-00!
End if 

ConsoleMessage("Please replace usage of Date_UnStringify with Date_ImportFromString.")
$vdDate:=Date_ImportFromString($vtStringifiedDate; $vdDefaultIfError)



// *************************************************** //
// *** RETURN THE DATE ******************************* //
// *************************************************** //

$0:=$vdDate