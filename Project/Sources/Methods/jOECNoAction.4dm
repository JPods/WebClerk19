//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/18/09, 07:47:52
// ----------------------------------------------------
// Method: jOECNoAction
// Description
// 
//
// Parameters
// ----------------------------------------------------
// no action

// ### jwm ### 20171017_1646
// Retrieve Errors from Stack
ARRAY LONGINT:C221($aiCodes; 0)  // Error Code
ARRAY TEXT:C222($atComponents; 0)  // 4D Internal Component
ARRAY TEXT:C222($atErrors; 0)  // Error Text
C_TEXT:C284($vtErrLine)
C_OBJECT:C1216($obErr; $obLine)

C_COLLECTION:C1488($cErrs)
$cErrs:=New collection:C1472
GET LAST ERROR STACK:C1015($aiCodes; $atComponents; $atErrors)
ConsoleMessage("\rjOECNoAction:\rError Code:\t"+String:C10(Error)+" - Method: "+Error Method+" - Line: "+String:C10(Error Line)+"\r")
$obErr:=New object:C1471("method"; Error Method; "Line"; Error Line)

For ($viIndex; 1; Size of array:C274($aiCodes))
	$obLine:=New object:C1471("code"; $aiCodes{$viIndex}; "error"; $atErrors{$viIndex}; "component"; $atComponents{$viIndex})
	$cErrs.push($obLine)
	ConsoleMessage("Error Code: "+String:C10($aiCodes{$viIndex})+" - "+$atErrors{$viIndex}+" - "+$atComponents{$viIndex})
End for 

$obErr.lines:=$cErrs
voState.errors.push($cErrs)
BEEP:C151
BEEP:C151
BEEP:C151

//TRACE  // stop and debug errors in interpreted mode

//+"\rError Source: "+Error Formula  Error Formula available in v16


// Error: Longint type system variable. This variable contains the error
// code. 4D error codes and system error codes are listed in sections of
// the Error Codes theme.

// Error method: Text type system variable. This variable contains the full
// name of the method that triggered the error.

// Error line: Longint type system variable. This variable contains the
// line number at the origin of the error in the method that triggered the
// error.

// v16
// Error formula: Text type system variable. This variable contains the
// formula of the 4D code (raw text) which is at the origin of the error.
// The text of the formula is expressed in the current language of the 4D
// code. If the source code responsible for the error cannot be found,
// Error formula contains an empty string. This case can occur in compiled
// databases when: the source code was deleted from the compiled structure
// using the application builder. the source code is available but the
// database was compiled without the Range Checking option.