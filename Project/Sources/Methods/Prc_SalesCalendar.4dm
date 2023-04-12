//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/27/21, 20:48:16
// ----------------------------------------------------
// Method: Prc_SalesCalendar
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Procedure: DB_SalesService
//C_LONGINT($found)
//$found:=Prs_CheckRunnin("MySales")
//If ($found>0)
//BRING TO FRONT($found)
//
//End if 
//Else 

C_LONGINT:C283($viBottom; $videltaHeight; $videltaWidth; $viFormHeight; $viFormWidth; $viLeft)
C_LONGINT:C283($viPadding; $viRight; $viTop; $viWindowHeight; $viWindowWidth)
C_TIME:C306($vhWindow)
C_BOOLEAN:C305(vbShow)
Process_InitLocal
ServiceArrayInit(0)
vbShow:=False:C215
//open winow
$winRef:=Open form window:C675("Sales_Internal"; Plain form window:K39:10; On the right:K39:3; At the bottom:K39:6; *)
C_LONGINT:C283($viWindowWidth; $viWindowHeight; $viLeft; $viTop; $viRight; $viBottom; $viPadding)
FORM GET PROPERTIES:C674("Sales_Internal"; $viFormWidth; $viFormHeight)
// shrink window to 0 x 0 
RESIZE FORM WINDOW:C890(-$viFormWidth; -$viFormHeight)

DIALOG:C40("Sales_Internal")
//end if