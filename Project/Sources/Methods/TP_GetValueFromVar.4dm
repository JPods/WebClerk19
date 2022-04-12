//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/13/17, 11:34:17
// ----------------------------------------------------
// Method: TPB_GetValueFromVar
//
// Description:
// 
// This method is sent the name of a process variable
// returns the content of that variable, if it exists.
//
// Parameters
// ----------------------------------------------------

// ******************************************* //
// ****** TYPE AND INITIALIZE PARAMETERS ***** //
// ******************************************* //

// RETURN VARIABLE
C_TEXT:C284($0; $vtOutput)
$0:=""
$vtOutput:=""

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_TEXT:C284($1; $vtVarString)
$vtVarString:=$1

// PARAMETER 2 IS THE SPECIFIED FORMAT TO RETURN
// THE VALUE IN. THIS CONTROLS THINGS LIKE CHANGING
// LINE BREAKS TO "<br>" FOR HTML OUTPUT.
C_TEXT:C284($2; $vtOutputFormat)
$vtOutputFormat:=$2

// ********************************************* //
// ****** PARSE OUT VAR NAME FROM STRING ******* //
// ********************************************* //

C_TEXT:C284($vtVarName)

$vtVarName:=$vtVarString

// ********************************************* //
// ** CONFIRM VARIABLE EXISTS AND GET POINTER ** //
// ********************************************* //

C_POINTER:C301($vpVar)
C_TEXT:C284($vtVerifiedVarName)
C_LONGINT:C283($viVerifiedTableNum; $viVerifiedFieldNum)

$vtVerifiedVarName:=""
$viVerifiedTableNum:=-1
$viVerifiedFieldNum:=-1

$vpVar:=Get pointer:C304($vtVarName)
RESOLVE POINTER:C394($vpVar; $vtVerifiedVarName; $viVerifiedTableNum; $viVerifiedFieldNum)

// ********************************************* //
// *** IF VARIABLE EXISTS, FORMAT AND RETURN *** //
// ********************************************* //

If ($vtVerifiedVarName="")
	$vtOutput:="Error: "+$vtVarName+" Not Found"
Else 
	$vtOutput:=TP_FormatOutput($vpVar; $vtOutputFormat)
End if 

$0:=$vtOutput