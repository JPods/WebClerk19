//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/13/12, 10:44:40
// ----------------------------------------------------
// Method: PayApply
// Description
// 
//
// Parameters
// ----------------------------------------------------



If (Count parameters:C259=1)
	Process_InitLocal
	var process_o; $1 : Object
	process_o:=$1
	tableName:="Control"
	ptCurTable:=(->[Control:1])
	$form_t:="ApplyPayment"
	C_OBJECT:C1216($obWindows)
	$obWindows:=WindowCountToShow
	
	$win_l:=Open form window:C675(ptCurTable->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	process_o.window:=$win_l
	DIALOG:C40(ptCurTable->; $form_t; process_o)
	
	Wcc_ReduceSelection
Else 
	$found:=Prs_CheckRunnin("ApplyPayments")
	If ($found>0)
		BRING TO FRONT:C326($found)
		
	Else 
		var $table_o : Object
		$tableName:="Control"
		$vtAddTitle:=""
		var $process_o : Object
		
		$process_o:=New object:C1471("ents"; New object:C1471; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; -1; \
			"tableName"; $tableName; \
			"tableForm"; "ApplyPayment"; \
			"form"; ""; \
			"entsOther"; New object:C1471("tableName"; New object:C1471); \
			"process"; Current process:C322)
		$childProcess:=New process:C317("PayApply"; 0; "ApplyPayment"; $process_o)
	End if 
End if 





