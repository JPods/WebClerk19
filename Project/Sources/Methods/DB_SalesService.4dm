//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-21T06:00:00Z)
// Method: DB_SalesService
// Description 
// Parameters
// ----------------------------------------------------


If (Application type:C494=4D Server:K5:6)
	// never run on server
Else 
	If (Count parameters:C259=1)
		Process_InitLocal  // ### jwm ### 20180921_1534 initialize variables in new process
		POST OUTSIDE CALL:C329(<>theProcessList)
		C_OBJECT:C1216($1; process_o)  // tableName and purpose
		process_o:=$1
		var $form_t : Text
		tableName:=""
		$form_t:=process_o.form
		$obWindows:=WindowCountToShow
		
		$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		process_o.window:=$win_l
		DIALOG:C40($form_t)
		
		POST OUTSIDE CALL:C329(<>theProcessList)
		
	Else 
		C_LONGINT:C283($found)
		$found:=Prs_CheckRunnin("SalesService")
		If ($found>0)
			If (Frontmost process:C327#<>aPrsNum{$found})
				BRING TO FRONT:C326(<>aPrsNum{$found})
			End if 
		Else 
			C_OBJECT:C1216($process_o)
			$process_o:=New object:C1471("ents"; New object:C1471; \
				"cur"; New object:C1471; \
				"sel"; New object:C1471; \
				"pos"; -1; \
				"id"; ""; \
				"date"; New object:C1471("begin"; Current date:C33-1; "end"; Current date:C33+1); \
				"tableName"; ""; \
				"tableNum"; 0; \
				"tableForm"; ""; \
				"form"; "SalesService"; \
				"entsOther"; New object:C1471("tableName"; New object:C1471); \
				"processName"; "SalesService")
			
			process_o:=New object:C1471("ents"; New object:C1471; \
				"cur"; New object:C1471; \
				"sel"; New object:C1471; \
				"pos"; -1; \
				"tableName"; ""; \
				"tableForm"; ""; \
				"form"; ""; \
				"entsOther"; New object:C1471("tableName"; New object:C1471); \
				"process"; Current process:C322)
			
			$proc_l:=New process:C317("DB_SalesService"; <>tcPrsMemory; "SalesService"; $process_o)  // *) checks for duplicate named process
		End if 
	End if 
End if 