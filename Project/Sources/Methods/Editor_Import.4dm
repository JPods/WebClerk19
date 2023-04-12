//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-05-27T05:00:00Z)
// Method: Editor_Import
// Description 
// Parameters
// ----------------------------------------------------


If (UserInPassWordGroup("Import"))
	
	
	var $obWindows : Object
	$obWindows:=WindowCountToShow
	$form_t:="EditorImport"
	$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	var $o : Object
	If (process_o=Null:C1517)
		$o:=New object:C1471("windowMain"; $win_l; "dataClassName"; "Customer")
	Else 
		$o:=process_o
	End if 
	$o.windowMain:=$win_l
	DIALOG:C40($form_t; $o)
	CLOSE WINDOW:C154
	
End if 





//USE SET("Imported")
//CLEAR SET("Imported")
//DB_ShowCurrentSelection(Table(doShowImport))
//doShowImport:=0

//  ReadOnlyFiles

