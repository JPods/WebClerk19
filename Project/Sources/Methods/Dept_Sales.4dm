//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2021-12-10T06:00:00Z)
// Method: Dept_Sales
// Description 
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($found)
If (Not:C34(Application type:C494=4D Server:K5:6))
	If (Count parameters:C259=1)
		Process_InitLocal
		var $obWindows : Object
		$obWindows:=WindowCountToShow
		//  $win_l:=Open form window([Control]; "DeptSales"; Plain form window; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		//   DIALOG([Control]; "DeptSales")
		var $new_o : Object
		$new_o:=New object:C1471("ents"; New object:C1471; "LB_Primes"; New object:C1471; "LB_Tables"; New object:C1471)
		$form_t:="Splash"
		$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		DIALOG:C40($form_t; $new_o)
		CLOSE WINDOW:C154($win_l)
	Else 
		$found:=Prs_CheckRunnin("Dept Sales")
		If ($found>0)
			If (Frontmost process:C327#<>aPrsNum{$found})
				BRING TO FRONT:C326(<>aPrsNum{$found})
			End if 
		Else 
			var $o : Object
			$o:=New object:C1471("task"; "setup")
			<>processAlt:=New process:C317("Dept_Sales"; 0; "Dept Sales"; $o)
		End if 
	End if 
End if 
