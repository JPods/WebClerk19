//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-07-25T00:00:00, 13:07:52
// ----------------------------------------------------
// Method: PopupLoadArrays
// Description
// Modified: 07/25/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

//  PopupLoadArrays(->a1Text;a2Text)

C_POINTER:C301($1; $2)
C_BOOLEAN:C305($loadAlt)

QUERY:C277([PopupChoice:134]; [PopupChoice:134]arrayName:1=[PopUp:23]arrayName:3)
v1:=""
$k:=Records in selection:C76([PopupChoice:134])
ARRAY TEXT:C222($1->; $k)  //  a1Text;$k)
$loadAlt:=False:C215
If (Count parameters:C259>1)
	ARRAY TEXT:C222($2->; $k)  // ARRAY TEXT(aText2;$k)  //###jwm###
	$loadAlt:=True:C214
End if 
FIRST RECORD:C50([PopupChoice:134])
For ($i; 1; $k)
	$1->{$i}:=[PopupChoice:134]choice:3
	If ($loadAlt)
		$2->{$i}:=[PopupChoice:134]alternate:4  //###jwm###
	End if 
	NEXT RECORD:C51([PopupChoice:134])
End for 
UNLOAD RECORD:C212([PopupChoice:134])