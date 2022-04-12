//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 07/23/19, 12:05:52
// ----------------------------------------------------
// Method: Daet_ImportFromString
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

// *************************************************** //
// *** UN-STRINGIFY THE DATE ************************* //
// *************************************************** //

// 4D CAN'T HANDLE ISO DATE IF THEY DON'T HAVE TIME STRINGS

If ((Substring:C12($vtStringifiedDate; 5; 1)="-") & (Substring:C12($vtStringifiedDate; 11; 1)#"T"))
	$vtStringifiedDate:=$vtStringifiedDate+"T00:00:00"
End if 

// CONVERT TYPE FROM STRING TO DATE

$vdDate:=Date:C102($vtStringifiedDate)

// IF THE DATE IS AN ERROR, SET IT TO THE DEFAULT

If ($vdDate=!00-00-00!)
	$vdDate:=$vdDefaultIfError
End if 

// *************************************************** //
// *** RETURN THE DATE ******************************* //
// *************************************************** //

$0:=$vdDate