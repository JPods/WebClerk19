//%attributes = {}

// Modified by: Bill James (2021-12-08T06:00:00Z)
// Method: dCashManage
// Description 
// Parameters
// ----------------------------------------------------
If (Count parameters:C259=0)
	var $new_o : Object
	var $tableName : Text
	If (ptCurTable#Null:C1517)
		$tableName:=Table name:C256(ptCurTable)
	End if 
	$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; "DCash"; "tableParent"; $tableName; \
		"processParent"; Current process:C322; \
		"windowParent"; Current form window:C827)
	$dCash:=New process:C317("dCashManage"; <>tcPrsMemory; "dCash"; $new_o)
Else 
	Process_InitLocal
	
	var process_o : Object
	var $tableName : Text
	process_o:=$1
	jSetMenuNums(1; 5; 6)
	var $obWindows : Object
	$obWindows:=WindowCountToShow  // example
	$win_l:=Open form window:C675([Control:1]; "dCashReview"; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	DIALOG:C40([Control:1]; "dCashReview")
	CLOSE WINDOW:C154
	
	Prs_ListActive
End if 