//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/18/09, 07:47:52
// ----------------------------------------------------
// Method: OEC_Web
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(<>OECWebReport)
C_LONGINT:C283($error)
C_TEXT:C284(vWebTagTable; $message_t)
If (voState=Null:C1517)  // incase this is used outside WebClerk
	voState:=New object:C1471
End if 
If (voState.errors=Null:C1517)
	voState.errors:=New collection:C1472
End if 
If (<>OECWebReport=0)
	
	var $route_t : Text
	If (voState.urlOriginal#Null:C1517)
		$route_t:=JSON Stringify:C1217(voState.request.parameters)
		$route_t:=voState.urlOriginal+": "+$route_t
	End if 
	$message_t:="Error Code: "+String:C10(Error)+"-- Method: "+Error Method+"-- Line: "+String:C10(Error Line)+"-- route: "+$route_t
	voState.errors.push($message_t)
	ConsoleLog($message_t)
End if 
If (<>OECWebReport=1)
	//ConsoleLog("\rOEC_Web: "+String(error)+" "+voState.request.URL.pathName+" "+vWebTagTable+" "+vWebTagField+" "+vWebTagFormat)
	
	
	// ### jwm ### 20171017_1646
	// Retrieve Errors from Stack
	ARRAY LONGINT:C221(aiCodes; 0)  // Error Code
	ARRAY TEXT:C222(atComponents; 0)  // 4D Internal Component
	ARRAY TEXT:C222(atErrors; 0)  // Error Text
	
	GET LAST ERROR STACK:C1015(aiCodes; atComponents; atErrors)
	
	For ($viIndex; 1; Size of array:C274(aiCodes))
		$message_t:="Error Code: "+String:C10(aiCodes{$viIndex})+"-- "+atErrors{$viIndex}+"-- "+atComponents{$viIndex}
		voState.errors.push($message_t)
		ConsoleLog($message_t)
	End for 
	$message_t:="Error Code: "+String:C10(Error)+"-- Method: "+Error Method+"-- Line: "+String:C10(Error Line)
	voState.errors.push($message_t)
	ConsoleLog($message_t)
	
	BEEP:C151
	BEEP:C151
	BEEP:C151
	
	TRACE:C157  // stop and debug errors in interpreted mode
	
	
	
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
	
End if 