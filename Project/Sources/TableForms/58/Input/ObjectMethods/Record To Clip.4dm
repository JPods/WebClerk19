
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-06-27T00:00:00, 00:00:57
// ----------------------------------------------------
// Method: [Customer].Input1.Button4
// Description
// Modified: 06/27/18
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($thePath)

If (Size of array:C274(aDocPathSelect)>0)
	If (aDocPathSelect{1}<=Size of array:C274(aDocPathPath))
		If (OK=1)
			$thePath:=pathToBrowser(aDocPathPath{aDocPathSelect{1}})  // full path
			SET TEXT TO PASTEBOARD:C523($thePath)
		End if 
		// LAUNCH EXTERNAL PROCESS($atSelected{1})
	End if 
Else 
	ALERT:C41("Execute in DocPaths Input Layout")
End if 

