//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 2013-11-22T00:00:00, 15:21:37
// ----------------------------------------------------
// Method: SREActionSetHeight
// Description
// Modified: 11/22/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// Script SRP Object Height 20131120
//  Set all objects to single line spacing
//  SR_GetObjects (ReportRef:L; Ref:L; id:T; Value:AL) -> error:L

C_REAL:C285(vrHeight)

vrHeight:=Num:C11(Request:C163("Enter Height for Selected Objects"))
ARRAY LONGINT:C221(alObjects; 0)
vlError:=SR_GetObjects(eSRWin; 1; SRP_ReportSelectedObjects; alObjects)
//Alert("vlError = "+String(vlError))
vi2:=Size of array:C274(alObjects)
ALERT:C41("Size of Array(alObjects) = "+String:C10(Size of array:C274(alObjects)))
For (vi1; 1; vi2)
	SR_SetRealProperty(esrWin; alObjects{vi1}; SRP_Object_PosHeight; vrHeight)
End for 