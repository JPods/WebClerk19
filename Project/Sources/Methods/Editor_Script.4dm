//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-05-26T05:00:00Z)
// Method: Editor_Script
// Description 
// Parameters
// ----------------------------------------------------
var $1; $o : Object
$doChange:=(UserInPassWordGroup("UnlockRecord"))
If (Not:C34($doChange))
	ALERT:C41("Access denied.")
Else 
	If (Count parameters:C259=0)
		var $o : Object
		If (process_o=Null:C1517)
			$o:=New object:C1471("dataClassName"; "Customer")
		Else 
			$o:=process_o
		End if 
		$processNum:=New process:C317("Editor_Script"; <>tcPrsMemory; "ScriptEditor"; $o)
	Else 
		
		Process_InitLocal
		C_LONGINT:C283($i)
		C_POINTER:C301($ptVar)
		// ### bj ### 20181204_1542 uncompiled declaration error
		ARRAY TEXT:C222(aiLoText16; 0)
		ARRAY TEXT:C222(aiLoText15; 0)
		C_OBJECT:C1216($obWindows)
		$obWindows:=WindowCountToShow
		$form_t:="EditorScript"
		$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		
		DIALOG:C40("EditorScript"; $1)
		
		POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
	End if 
End if 



