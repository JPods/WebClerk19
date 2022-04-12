//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/14/17, 9:34:17
// ----------------------------------------------------
// Method: TPB_GetValueFromArray
//
// Description:
// 
// This method is sent the name of a process array variable
// and a iterator and returns the content of that variable,
// if it exists.
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
// ****** PARSE OUT VAR NAMES FROM STRING ****** //
// ********************************************* //

C_TEXT:C284($vtArrName; vtItName)

$viPosBracketOpen:=Position:C15("{"; $vtVarString)
$viPosBracketClose:=Position:C15("}"; $vtVarString)
$viLengthBetweenBrackets:=$viPosBracketClose-$viPosBracketOpen-1

$vtArrName:=Substring:C12($vtVarString; 1; $viPosBracketOpen-1)
$vtItName:=Substring:C12($vtVarString; $viPosBracketOpen+1; $viLengthBetweenBrackets)

// ********************************************* //
// **** CONFIRM ARRAY EXISTS AND GET POINTER *** //
// ********************************************* //

C_POINTER:C301($vpArr; vpIt; $vpArrEl)
C_TEXT:C284($vtVerifiedArrName; vtVerifiedItName; $vtVerifiedArrEl)
C_LONGINT:C283($viVerifiedTableNum; $viVerifiedFieldNum)

$vtVerifiedArrName:=""
$vtVerifiedItName:=""
$vtVerifiedArrEl:=""

$viVerifiedTableNum:=-1
$viVerifiedFieldNum:=-1

$vpArr:=Get pointer:C304($vtArrName)
RESOLVE POINTER:C394($vpArr; $vtVerifiedArrName; $viVerifiedTableNum; $viVerifiedFieldNum)

$vpIt:=Get pointer:C304($vtItName)
RESOLVE POINTER:C394($vpIt; $vtVerifiedItName; $viVerifiedTableNum; $viVerifiedFieldNum)

$vpArrEl:=Get pointer:C304($vtArrName+"{"+String:C10($vpIt->)+"}")
RESOLVE POINTER:C394($vpArrEl; $vtVerifiedArrEl; $viVerifiedTableNum; $viVerifiedFieldNum)

// ********************************************* //
// *** IF VARIABLE EXISTS, FORMAT AND RETURN *** //
// ********************************************* //

If (($vtVerifiedArrName="") | ($vtVerifiedItName="") | ($vtVerifiedArrEl=""))
	$vtOutput:="Error: "+$vtVarString+" Not Found"
Else 
	$vtOutput:=TP_FormatOutput($vpArrEl; $vtOutputFormat)
End if 

$0:=$vtOutput