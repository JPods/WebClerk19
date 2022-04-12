//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/03/08, 06:41:18
// ----------------------------------------------------
// Method: FC_OH
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (Count parameters:C259>0)
	Process_InitLocal
	var $1; process_o; $obWindows : Object
	process_o:=$1
	ARRAY TEXT:C222(aFCWho; 0)
	var $obWindows : Object
	$obWindows:=WindowCountToShow
	$win_l:=Open form window:C675([Control:1]; "Forecast_OH"; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	DIALOG:C40([Control:1]; "Forecast_OH")
	WindowOpenTaskOffSets(0; 20; 60)
	Process_InitLocal
	ptCurTable:=(->[Control:1])
	
	//Ray_ZeroElement (->aFCItem;->aFCBomCnt;->aFCActionDt;->aFCBomLevel;->aFCParent;->aFCTypeTran;->aFCDocID;->aFCDesc;->aFCRunQty;->aFCRecNum;->aFCWho;->aFCBaseQty;->aFCTallyYTD;->aFCTallyLess1Year;->aFCTallyLess2Year)
	//CalendarActRay (->aDate1;0)
	For ($i; 1; 11)
		$ptVar:=Get pointer:C304("vR"+String:C10($i))
		$ptVar->:=0
	End for 
	vL1:=0
	vL2:=0
	
Else 
	var $tableName : Text
	var $new_o : Object
	If (ptCurTable#Null:C1517)
		$tableName:=Table name:C256(ptCurTable)
	End if 
	$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; "Item"; \
		"windowParent"; Current form window:C827; \
		"tableParent"; $tableName)
	//Procedure: FC_LaunchWin
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("FC_OH"; <>tcPrsMemory; "ForecastOH"; $new_o)
End if 