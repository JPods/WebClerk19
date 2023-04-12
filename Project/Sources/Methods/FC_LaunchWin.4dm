//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-20T06:00:00Z)
// Method: FC_LaunchWin
// Description 
// Parameters
// ----------------------------------------------------

If (Count parameters:C259=1)
	
	Process_InitLocal
	var process_o; $1 : Object
	process_o:=$1
	tableName:="Control"
	ptCurTable:=(->[Control:1])
	$form_t:="Forecasting"
	C_OBJECT:C1216($obWindows)
	$obWindows:=WindowCountToShow
	$win_l:=Open form window:C675(ptCurTable->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	process_o.window:=$win_l
	DIALOG:C40(ptCurTable->; $form_t; process_o)
	
	
	Ray_ZeroElement(->aFCItem; ->aFCBomCnt; ->aFCActionDt; ->aFCBomLevel; ->aFCParent; ->aFCTypeTran; ->aFCDocID; ->aFCDesc; ->aFCRunQty; ->aFCRecNum; ->aFCWho; ->aFCBaseQty; ->aFCTallyYTD; ->aFCTallyLess1Year; ->aFCTallyLess2Year)
	// CalendarActRay(->aDate1; 0)
	
Else 
	$found:=Prs_CheckRunnin("Forecasting")
	If ($found>0)
		BRING TO FRONT:C326($found)
		
	Else 
		$tableName:="Control"
		$vtAddTitle:=""
		var $process_o : Object
		$process_o:=New object:C1471("ents"; New object:C1471; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; -1; \
			"tableName"; $tableName; \
			"form"; "Forecasting"; \
			"tableForm"; ""; \
			"entsOther"; New object:C1471("tableName"; New object:C1471); \
			"process"; Current process:C322)
		<>processAlt:=New process:C317("FC_LaunchWin"; 0; "Forecast"; $process_o)
	End if 
End if 