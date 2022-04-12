//%attributes = {}

// Modified by: Bill James (2022-03-26T05:00:00Z)
// Method: ExecuteScript
// Description added echo_o
// Parameters
// ----------------------------------------------------


// ********************ExecuteScript************************************************************************ //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $vtEchoedText)
$vtEchoedText:=""

C_TEXT:C284($1; $vtScript)
$vtScript:=$1

C_OBJECT:C1216(echo_o)  // setup a returning object
echo_o:=New object:C1471("error"; ""; "data"; New object:C1471)  // ; "script";$vtScript)

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($vtDiscardedOutput)
C_TEXT:C284(echo_t)
var echo_o : Object
echo_o:=New object:C1471("ents"; New object:C1471; "err"; ""; "details"; "")


// ******************************************************************************************** //
// ** LOAD ANY HOOKED SCRIPTED THAT ARE HOOKED TO CURRENT EVENT ******************************* //
// ******************************************************************************************** //

// RESET THE ECHO BUFFER

echo_t:=""

// EXECUTE THE SCRIPT

$vtScript:="<!--#4DCODE\r"+$vtScript+"\r-->"
PROCESS 4D TAGS:C816($vtScript; $vtDiscardedOutput)



$vtEchoedText:=echo_t
echo_t:=""

//  echo_o.ents is an entity result


// ******************************************************************************************** //
// ** RETURN THE VALUE ************************************************************************ //
// ******************************************************************************************** //

$0:=$vtEchoedText