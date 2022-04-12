//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/03/06, 21:35:42
// ----------------------------------------------------
// Method: ColorSetForeBack
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($2; $3)
_O_OBJECT SET COLOR:C271($1->; -($2+(256*$3)))  //(Foreground+(256*Background))