//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 01/07/20, 09:04:21
// ----------------------------------------------------
// Method: DB_TriggerEvent
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($1; $vtEventName)
$vtEventName:=$1



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($vtScript; $vtDiscardedOutput)



// ******************************************************************************************** //
// ** LOAD ANY HOOKED SCRIPTED THAT ARE HOOKED TO CURRENT EVENT ******************************* //
// ******************************************************************************************** //

ExecuteTallyMaster($vtEventName; "HookedScript")