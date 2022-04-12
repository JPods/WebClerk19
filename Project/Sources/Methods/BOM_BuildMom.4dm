//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/26/11, 01:53:49
// ----------------------------------------------------
// Method: BOM_BuildMom
// Description
// 
//
// Parameters
// ----------------------------------------------------
// Modified by: williamjames (110126) added the parameter to zero arrays
If (Count parameters:C259=1)
	ARRAY TEXT:C222(aBomMomItem; 0)
	ARRAY LONGINT:C221(aBomMomRec; 0)
Else 
	QUERY:C277([BOM:21]; [BOM:21]ChildItem:2=[Item:4]itemNum:1)
	SELECTION TO ARRAY:C260([BOM:21]ItemNum:1; aBomMomItem; [BOM:21]; aBomMomRec)
	If (Records in selection:C76([BOM:21])>0)
		[Item:4]bomHasParent:59:=True:C214
	Else 
		[Item:4]bomHasParent:59:=False:C215
	End if 
End if 