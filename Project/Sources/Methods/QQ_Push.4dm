//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/23/07, 17:16:46
// ----------------------------------------------------
// Method: QQ_Push
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $2)
KeyModifierCurrent
QuoteQuick
$found:=Prs_CheckRunnin("QuickQuote")
If ($found>0)
	If (CmdKey=0)
		COPY ARRAY:C226($1->; <>aItemNumQQ)
	Else 
		C_LONGINT:C283($incRay; $cntRay)
		$cntRay:=Size of array:C274($2->)
		ARRAY TEXT:C222(<>aItemNumQQ; 0)
		For ($incRay; 1; $cntRay)
			INSERT IN ARRAY:C227(<>aItemNumQQ; 1)
			<>aItemNumQQ{1}:=$1->{$2->{$incRay}}
		End for 
	End if 
	<>viItemsProfilecessAction:=5  //build QQList from BOM 
	POST OUTSIDE CALL:C329(<>aPrsNum{$found})
	BRING TO FRONT:C326(<>aPrsNum{$found})
End if 
//
CmdKey:=0