// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-21T00:00:00, 11:31:57
// ----------------------------------------------------
// Method: [Control].QuickQuoteLong.Variable2
// Description
// Modified: 10/21/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
KeyModifierCurrent
C_LONGINT:C283($error; $k; $i)
//  //  CHOPPED  $error:=AL_GetSelect (eQuickQuote;aItemLines)

ARRAY LONGINT:C221(aItemLines; 0)
//  CHOPPED  $error:=AL_GetSelect(eQuickQuote; aItemLines)
If ((optkey=1) | (CMDKEY=1))
	RelateByArray(->aLsItemNum; ->[Item:4]itemNum:1)
Else 
	$k:=Size of array:C274(aItemLines)
	If ($k>0)
		ARRAY TEXT:C222(iLoaText4; $k)
		For ($i; 1; $k)
			iLoaText4{$i}:=aLsItemNum{aItemLines{$i}}
		End for 
	End if 
	RelateByArray(->iLoaText4; ->[Item:4]itemNum:1)
	ARRAY TEXT:C222(iLoaText4; 0)
End if 