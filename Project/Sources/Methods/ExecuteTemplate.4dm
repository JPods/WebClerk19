//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 11/04/19, 09:33:46
// ----------------------------------------------------
// Method: ExecuteTemplate
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $vtResultsFromExecutedTemplate)

C_TEXT:C284($1; $vt4DTemplate)
$vt4DTemplate:=$1



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //



// ******************************************************************************************** //
// ** WRAP THE TEMPLAET STRING WITH AN ECHO FUNCTION, THEN EXECUTE IT ************************* //
// ******************************************************************************************** //


$vt4DTemplate:="<!--#4DHTML "+$vt4DTemplate+"-->"
PROCESS 4D TAGS:C816($vt4DTemplate; $vtResultsFromExecutedTemplate)

// RETURN THE RESULTS

$0:=$vtResultsFromExecutedTemplate