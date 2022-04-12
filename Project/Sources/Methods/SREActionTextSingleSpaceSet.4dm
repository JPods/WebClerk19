//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 2013-11-25T00:00:00, 11:59:20
// ----------------------------------------------------
// Method: SREActionTextSingleSpaceSet
// Description
// Modified: 11/25/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// Script SRP single line spacing
//  Set all objects to single line spacing
//  SR_GetObjects (ReportRef:L; Ref:L; id:T; Value:AL) -> error:L

ARRAY LONGINT:C221(alObjects; 0)
vlError:=SR_GetObjects(eSRWin; 1; SRP_ReportAllObjects; alObjects)
//Alert("vlError = "+String(vlError))
vi2:=Size of array:C274(alObjects)
ALERT:C41("Size of Array(alObjects) = "+String:C10(Size of array:C274(alObjects)))
For (vi1; 1; vi2)
	SR_SetRealProperty(esrWin; alObjects{vi1}; SRP_Style_LineSpacing; 1)
End for 