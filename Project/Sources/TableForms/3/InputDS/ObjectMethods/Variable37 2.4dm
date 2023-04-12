KeyModifierCurrent
If ((CmdKey=1) & (OptKey=1))
	Open window:C153(60; 60; 1090; 690)  //551
	DIALOG:C40([Control:1]; "WebServices")
	CLOSE WINDOW:C154
Else 
	
	If (UserInPassWordGroup("MakePayment"))
		
		If (False:C215)
			myCycle:=8
			jAcceptButton(False:C215; False:C215)
			
			
			
			myCycle:=8
			jAcceptButton(False:C215; False:C215)
			
			var $tableParent; $idParent : Text
			$tableParent:=Table name:C256(ptCurTable)
			
			// MustFixQQQZZZ: Bill James (2021-12-12T06:00:00Z)
			// parents
			
			GOTO SELECTED RECORD:C245([Payment:28]; aPayShow)
			$idParent:=STR_Get_idPointer($tableParent)->
			
			var $idProcess : Integer
			var $new_o : Object
			
			$tableName:="Payment"
			$new_o:=New object:C1471("ents"; New object:C1471; \
				"cur"; New object:C1471; \
				"sel"; New object:C1471; \
				"pos"; -1; \
				"entsOther"; New object:C1471("tableName"; New object:C1471); \
				"tableName"; $tableName; \
				"task"; "Add"; \
				"tableParent"; $tableParent; \
				"idParent"; process_o.cur.id; \
				"taskEnd"; "recallParent")
			
			UNLOAD RECORD:C212([Order:3])
			UNLOAD RECORD:C212([Customer:2])
			UNLOAD RECORD:C212([OrderLine:49])
			REDUCE SELECTION:C351([Invoice:26]; 0)
			REDUCE SELECTION:C351([OrderLine:49]; 0)
			
			CANCEL:C270
			
			$idProcess:=New process:C317("ProcessObject"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
			
		End if 
		
		PaymentCreate(->[Order:3])
	End if 
End if 