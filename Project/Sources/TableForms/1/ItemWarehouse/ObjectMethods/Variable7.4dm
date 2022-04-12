C_BOOLEAN:C305($doChange)
$doChange:=UserInPassWordGroup("Inventory")
If ($doChange)
	CONFIRM:C162("Delete, there is no UnDo?")
	If (OK=1)
		CREATE SET:C116([ItemWarehouse:117]; "Current")
		$cntRec:=Size of array:C274(aRecvRecs)
		ARRAY LONGINT:C221($aUniqueIDs; 0)
		For ($incRec; 1; $cntRec)
			//  CHOPPED  AL_GetCellValue(eItemWarehouse; aRecvRecs{$incRec}; 8; $tData)
			APPEND TO ARRAY:C911($aUniqueIDs; Num:C11($tData))
		End for 
		// 
		For ($incRec; 1; $cntRec)
			QUERY:C277([ItemWarehouse:117]; [ItemWarehouse:117]idNum:1=$aUniqueIDs{$incRec})
			If (Records in selection:C76([ItemWarehouse:117])=1)
				DELETE RECORD:C58([ItemWarehouse:117])
			End if 
		End for 
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		//  CHOPPED  AL_UpdateFields(eItemWarehouse; 2)
	End if 
Else 
	jAlertMessage(-9991)
End if 
