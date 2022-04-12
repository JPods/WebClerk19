//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 2013-11-22T00:00:00, 15:21:02
// ----------------------------------------------------
// Method: SREActionSelectLinesBoxes
// Description
// Modified: 11/22/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



// Script SRP Selected Lines & Boxes 20131120
//  Set all objects to single line spacing
//  SR_GetObjects (ReportRef:L; Ref:L; id:T; Value:AL) -> error:L

ARRAY LONGINT:C221(alObjects; 0)
vlError:=SR_GetObjects(eSRWin; 1; SRP_ReportSelectedObjects; alObjects)
//Alert("vlError = "+String(vlError))
vi2:=Size of array:C274(alObjects)
//Alert("Size of Array(alObjects) = "+String(Size of Array(alObjects)))
For (vi1; 1; vi2)
	vtKind:=SR_GetTextProperty(esrWin; alObjects{vi1}; SRP_Object_Kind)
	//Alert(vtKind)
	//SR_SetRealProperty(esrWin;alObjects{vi1};SRP_Style_LineSpacing;1)
	If (vtKind="var") | (vtKind="text") | (vtKind="field")
		SR_SetLongProperty(esrWin; alObjects{vi1}; SRP_Object_Selected; 0)
	Else 
		SR_SetLongProperty(esrWin; alObjects{vi1}; SRP_Object_Selected; 1)
	End if 
End for 
