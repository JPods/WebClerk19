var $event_o : Object
var $eventCode_i : Integer
var ptCurTable; ptCurID : Pointer
var $tableNum_l; $fieldNum_l : Integer

$eventCode_i:=Form event code:C388
$event_o:=FORM Event:C1606
Case of 
		
	: ($eventCode_i=-122)
		
	: ($eventCode_i=On Selection Change:K2:29)
		
	: ($eventCode_i=On Clicked:K2:4)
		
		
		
		
		SET WINDOW TITLE:C213(process_o.tableName+" displayed/selected: "+String:C10(Form:C1466.ents.length)+"/"+String:C10(Form:C1466.displayedSelected.length))
		
		
		
		
		FormEventOnDisplayDetail
	: ($eventCode_i=On Load:K2:1)
		
		allowAlerts_boo:=False:C215
		tableName:=process_o.tableName
		$tableNum_l:=ds:C1482[tableName].getInfo().tableNumber
		$fieldNum_l:=ds:C1482[tableName].id.fieldNumber
		ptCurTable:=Table:C252($tableNum_l)
		ptCurID:=Field:C253($tableNum_l; $fieldNum_l)
		
		//If (Storage.user.formPreference[tableName]#Null)
		// build for user and role
		//Else 
		var $listboxSetup_o; $columnSetup_o : Object
		var $obRec : Object
		$obRec:=ds:C1482.FieldCharacteristic.query("tableName = :1 AND purpose = :2 AND role = :3 "; tableName; "formDefault"; "default").first()
		
		If ($obRec=Null:C1517)
			ALERT:C41("Error: There is no FieldCharacteristic record tableName: "+tableName+", purpose: formDefault, role default")
			ConsoleMessage("Error: There is no FieldCharacteristic record tableName: "+tableName+", purpose: formDefault, role default")
			CANCEL:C270
		Else 
			$listboxSetup_o:=$obRec.data.default["listboxSetup"]
			If ($listboxSetup_o=Null:C1517)
				CANCEL:C270
			Else 
				LBX_BoxFromStored($listboxSetup_o)
				
				If (process_o.script=Null:C1517)
					Form:C1466.ents:=ds:C1482[tableName].all()
					//: (process_o.script="")
					// Form.ents:=ds[tableName].all()
				Else 
					var echo_o : Object
					echo_o:=New object:C1471
					var $vtResponse : Text
					$vtResponse:=ExecuteScript(process_o.script)
					Form:C1466.ents:=echo_o
					echo_o:=New object:C1471
				End if 
				
				SET WINDOW TITLE:C213(tableName+" displayed/selected: "+String:C10(Form:C1466.ents.length)+"/"+String:C10(Form:C1466.dataectedEntitySubset.length))
				
				// MustFixQQQZZZ: Bill James (2021-08-29T05:00:00Z)
				// Remove this after changing SF to ORDA
				READ ONLY:C145(ptCurTable->)
				
				
				// HOWTO: populate a subform
				OBJECT SET SUBFORM:C1138(*; "SF_Input"; ptCurTable->; "InputDS")
				//OBJECT SET SUBFORM(*; "SF_Input"; "SubOrderLine")
			End if 
		End if 
	: ($eventCode_i=On Activate:K2:9)
		FormEventOnActivate
	: ($eventCode_i=On Close Detail:K2:24)
		FormEventCloseDetail
	: ($eventCode_i=On Unload:K2:2)
		FormEventOnUnloadOLO
	: ($eventCode_i=On Double Clicked:K2:5)
		
		
	: ($eventCode_i=On Header:K2:17)
		FormEventOnHeader
	: ($eventCode_i=On Selection Change:K2:29)
		
		
		FormEventOnSelectionChange
	: ($eventCode_i=On Open Detail:K2:23)
		
		FormEventOnOpenDetail
	: ($eventCode_i=On Close Box:K2:21)
		FormEventOnCloseBox
		
	: ($eventCode_i=On Outside Call:K2:11)  // (Outside call)
		Prs_OutsideCall
		
	Else 
		
End case 
