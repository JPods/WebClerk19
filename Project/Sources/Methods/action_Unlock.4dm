//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($status; $clone)
C_BOOLEAN:C305($fl_NeedTransaction)
C_COLLECTION:C1488($calculatedFields; $touchedFields; $difFields)
C_TEXT:C284($field)

$fl_NeedTransaction:=$1

If (Form:C1466.recordCanBeSaved)  //We will try to lock the Entity (Pessimistic locking)
	If ($fl_NeedTransaction & Not:C34(In transaction:C397))
		START TRANSACTION:C239
	End if 
	$clone:=Form:C1466.editEntity.clone()  //We take a copy of the Entity just in case...
	$status:=Form:C1466.editEntity.lock(dk reload if stamp changed:K85:15)  //And then we try to lock it.
	//Lock works exactly like a .save(), so the tests of status are almost the same
	
	If ($status.success)  //Entity has been locked successfully
		If ($status.wasReloaded#Null:C1517)  //We test if the record has been reloaded, in order to advise the User that he gets a new version of the record
			If ($status.wasReloaded)
				$difFields:=Form:C1466.editEntity.diff($clone)  //We get the fields that have been modified...
				If ($difFields.length>0)
					ALERT:C41(Get localized string:C991("RecordNewVersion"))  //...and tell the User
				End if 
			End if 
		End if 
		//Util25_EntityLoad (Form.editEntity;Form.objectFieldsList)
		$fl_NoLock:=False:C215
	Else 
		Case of 
			: ($status.status=dk status entity does not exist anymore:K85:23)
				BEEP:C151
				ALERT:C41(Get localized string:C991("Recordnotexist"))
				Form:C1466.recordCanBeSaved:=False:C215
				If (Form:C1466.settings.Modes.multiRecords)
					Util25_RecordInNewWindow("CLOSE")
				Else 
					FORM GOTO PAGE:C247(1)
				End if 
				
			: ($status.status=dk status locked:K85:21)
				BEEP:C151
				ALERT:C41(Util25_Get_LocalizedMessage("Recordhasbeenlock"; $status.lockInfo.user_name; $status.lockInfo.user4d_id))
				Form:C1466.recordCanBeSaved:=False:C215
				
			: ($status.status=dk status serious error:K85:22)
				BEEP:C151
				ALERT:C41(Util25_Get_LocalizedMessage("RecordhasProblem"; $status.lockInfo.errors.text.join(Char:C90(Carriage return:K15:38))))
				Form:C1466.recordCanBeSaved:=False:C215
				
			Else 
				ALERT:C41(Util25_Get_LocalizedMessage("Something strangemodify"; $status.lockInfo.errors.text.join(Char:C90(Carriage return:K15:38))))
				Form:C1466.recordCanBeSaved:=False:C215
				
		End case 
		$fl_NoLock:=True:C214
	End if 
	If ($fl_NoLock & In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
	
Else   //We will unlock the record)
	If (Form:C1466.editEntity.touched())  //It has been modified
		If (Form:C1466.editEntity.isNew())
			//Can't normally happen, for the Lock button is disabled
		Else 
			$calculatedFields:=New collection:C1472("Total_Sales"; "Tax_Rate"; "Discount_Rate"; "Tax"; "Total")  //These fields are automatically recalculated, so they will be always 'touched'...
			$touchedFields:=Form:C1466.editEntity.touchedAttributes()  //...which means that we should remove them of the list
			$Fl_TouchedButOK:=True:C214
			For each ($field; $touchedFields)
				If ($calculatedFields.indexOf($field)<0)
					$Fl_TouchedButOK:=False:C215
				End if 
			End for each 
			If ($Fl_TouchedButOK)
				OK:=1
			Else 
				CONFIRM:C162(Util25_Get_LocalizedMessage("loseModifs"); Get localized string:C991("Save it"); Get localized string:C991("Do not save it"))
			End if 
			If (OK=1)
				$status:=Form:C1466.editEntity.save()
				//No need to test the success for the Entity was locked, but, just in case...
				Case of   //Save it
					: ($status.success)
						Form:C1466.editEntity.unlock()
						$fl_SavedOK:=True:C214
					Else 
						ALERT:C41(Util25_Get_LocalizedMessage("Something strangemodify"; $status.lockInfo.errors.text.join(Char:C90(Carriage return:K15:38))))
						Form:C1466.recordCanBeSaved:=False:C215
						$fl_SavedOK:=False:C215
				End case 
				
			Else   //Do not save it
				Form:C1466.editEntity.unlock()
				$fl_SavedOK:=False:C215
			End if 
		End if 
		
	Else   //It has not been modified
		Form:C1466.editEntity.unlock()
		$fl_SavedOK:=False:C215
	End if 
	
	If (In transaction:C397)
		If ($fl_SavedOK)
			VALIDATE TRANSACTION:C240
		Else 
			CANCEL TRANSACTION:C241
		End if 
	End if 
	
	//Util25_EntityLoad (Form.editEntity;Form.objectFieldsList)
End if 
