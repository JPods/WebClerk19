//jSetFromArray ([Order];aOrdRecs;aRayLines)

// ### jwm ### 20180712_1521 get current BOM selection
ARRAY LONGINT:C221(aBomSelect; 0)
//  CHOPPED  $error:=AL_GetSelect(eBOMList; aBomSelect)

C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aBomSelect)
If ($k>0)
	CREATE EMPTY SET:C140([BOM:21]; "Current")
	For ($i; 1; $k)
		GOTO RECORD:C242([BOM:21]; aBomRecs{aBomSelect{$i}})
		ADD TO SET:C119([BOM:21]; "Current")
	End for 
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	DB_ShowCurrentSelection(->[BOM:21]; ""; 1; "")
End if 