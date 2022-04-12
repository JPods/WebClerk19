//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 04/11/20, 13:50:36
// ----------------------------------------------------
// Method: SanitizeInput
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ***************************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ******************************************************************* //
// ***************************************************************************************************** //

C_TEXT:C284($0; $vtSanitizedInput)
$vtSanitizedInput:=""

C_TEXT:C284($1; $vtInput)
$vtInput:=$1

C_POINTER:C301($vpField)
$vpField:=$2



// ***************************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ************************************************************** //
// ***************************************************************************************************** //

C_LONGINT:C283($viFieldType)
C_TEXT:C284($vtFieldName)



// ***************************************************************************************************** //
// ** DETERMINE THE VALUE WRAPPER AND VALUE DEFAULTS, DEPENDING ON THE FIELD TYPE. EXAMPLE, A ********** //
// ** DATE FIELD WILL BY QUERIED USING "!00/00/00!", BUT THE VALUE FROM THE HTTP REQUEST WOULD ********* //
// ** BY "00/00/00", SO WE MUST WRAPPER IT WITH "!". A STRING WILL BE WRAPPED WITH DOUBLE QUOTES, ****** //
// ** WHILE A NUMBER WON'T BE WRAPPED AT ALL. ALSO, WE WILL SWITCH BLANK VALUES. A BLANK VALUE FOR ***** //
// ** A NUMBER WILL BECOME "0". ************************************************************************ //
// ***************************************************************************************************** //

$viFieldType:=Type:C295($vpField->)
$vtFieldName:=Field name:C257($vpField)

Case of 
	: (($viFieldType=Is alpha field:K8:1) | ($viFieldType=Is text:K8:3) | ($viFieldType=Is string var:K8:2))
		$vtSanitizedInput:="\""+$vtInput+"\""
	: ($viFieldType=Is date:K8:7)
		If ($vtInput="")
			$vtSanitizedInput:="00/00/00"
		End if 
		$vtSanitizedInput:="!"+String_TrimBoth($vtInput; "!")+"!"
	: ($viFieldType=Is time:K8:8)
		If ($vtInput="")
			$vtSanitizedInput:="00:00:00"
		End if 
		$vtSanitizedInput:="?"+String_TrimBoth($vtInput; "?")+"?"
	: (($viFieldType=_o_Is float:K8:26) | ($viFieldType=Is real:K8:4) | ($viFieldType=Is integer:K8:5) | ($viFieldType=Is longint:K8:6))
		If (Position:C15("DT"; $vtFieldName)=1)
			$vtSanitizedInput:=String:C10(DT_ImportFromString($vtInput))
		End if 
		$vtSanitizedInput:=$vtInput
		If ($vtSanitizedInput="")
			$vtSanitizedInput:="0"
		End if 
	: ($viFieldType=Is boolean:K8:9)
		If (($vtInput="1") | ($vtInput="true") | ($vtInput="yes"))
			$vtSanitizedInput:="true"
		Else 
			$vtSanitizedInput:="false"
		End if 
End case 

// ***************************************************************************************************** //
// ** RETURN SANITIZED AND STRINGIFIED INPUT *********************************************************** //
// ***************************************************************************************************** //

$0:=$vtSanitizedInput