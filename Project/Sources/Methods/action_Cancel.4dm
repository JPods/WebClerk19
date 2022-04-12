//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($status)

If (Form:C1466.recordCanBeSaved)
	$status:=Form:C1466.editEntity.unlock()
	Form:C1466.recordCanBeSaved:=False:C215
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
End if 

If (Form:C1466.settings.Modes.multiRecords)
	Util25_RecordInNewWindow("CLOSE")
Else 
	FORM GOTO PAGE:C247(1)
	Util25_UpdateSelection("_LB_1")
End if 