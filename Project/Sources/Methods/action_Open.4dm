//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($status)

$status:=Form:C1466.clickedEntity.reload()
If ($status.success)
	Form:C1466.editEntity:=Form:C1466.clickedEntity
	//Util25_EntityLoad (Form.editEntity;Form.objectFieldsList)
	Form:C1466.recordCanBeSaved:=True:C214
	If (Form:C1466.settings.Modes.multiRecords)
		Util25_RecordInNewWindow("OPEN")
	Else 
		FORM GOTO PAGE:C247(2)
	End if 
	
Else 
	Case of 
		: ($status.status=dk status entity does not exist anymore:K85:23)
			ALERT:C41(Get localized string:C991("Recordnotexist"))  //$status.statusText)
			
		Else 
			ALERT:C41(Get localized string:C991("unexpected problem"))
			
	End case 
End if 

