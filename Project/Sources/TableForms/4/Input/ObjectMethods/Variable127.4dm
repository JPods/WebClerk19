//jSetFromArray ([Order];aOrdRecs;aRayLines)

// ### jwm ### 20180712_1521 get current BOM selection
ARRAY LONGINT:C221(aBomSelect; 0)
//  CHOPPED  $error:=AL_GetSelect(eBOMList; aBomSelect)

C_LONGINT:C283($i; $k)
<>ptCurTable:=(->[Item:4])
$k:=Size of array:C274(aBomSelect)
PUSH RECORD:C176([Item:4])
If ($k>0)
	CREATE EMPTY SET:C140([Item:4]; "Current")
	For ($i; 1; $k)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=aRptPartNum{aBomSelect{$i}})
		ADD TO SET:C119([Item:4]; "Current")
	End for 
	UNLOAD RECORD:C212([Item:4])
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	DB_ShowCurrentSelection(->[Item:4]; ""; 1; "")  //tablePt, script, flowBranch, Title
End if 
POP RECORD:C177([Item:4])
