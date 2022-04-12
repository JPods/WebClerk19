//%attributes = {}

// Modified by: Bill James (2022-01-22T06:00:00Z)
// Method: ExecuteScript_Object
// Description 
// Parameters
// ----------------------------------------------------

// ********************ExecuteScript************************************************************************ //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($1; $vtScript; echo_t)
$vtScript:=$1

C_OBJECT:C1216(echo_o)  // setup a returning object
echo_o:=New object:C1471("error"; ""; "data"; New object:C1471)  // ; "script";$vtScript)

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($vtDiscardedOutput)
C_TEXT:C284(echo_t)


// ******************************************************************************************** //
// ** LOAD ANY HOOKED SCRIPTED THAT ARE HOOKED TO CURRENT EVENT ******************************* //
// ******************************************************************************************** //

// RESET THE ECHO BUFFER

var $0; echo_o : Object

// EXECUTE THE SCRIPT
var echo_o : Object
echo_o:=New object:C1471("ents"; New object:C1471; "err"; ""; "details"; "")

$vtScript:="<!--#4DCODE\r"+$vtScript+"\r-->"
PROCESS 4D TAGS:C816($vtScript; $vtDiscardedOutput)
// EXTRACT THE ECHO BUFFER

$vtEchoedText:=echo_t
echo_t:=""
$0:=echo_o
echo_o:=New object:C1471
// ******************************************************************************************** //
// ** RETURN THE VALUE ************************************************************************ //
// ******************************************************************************************** //

