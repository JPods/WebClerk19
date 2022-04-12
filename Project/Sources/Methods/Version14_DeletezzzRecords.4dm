//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-05-19T00:00:00, 16:05:01
// ----------------------------------------------------
// Method: Version14_DeletezzzRecords
// Description
// Modified: 05/19/16
// 
// 
//
// Parameters
// ----------------------------------------------------

// Must Run to prepare for Version 14.
// ### bj ### 20181126_0623

C_LONGINT:C283($incRecord; $cntRecords; $incTables; $cntTables; $rportRecord)
C_TEXT:C284($tableName)
C_TEXT:C284($logOfChanges)

C_LONGINT:C283($fieldNum; $incRec; $cntRec; $theType; $fia)
C_POINTER:C301($ptField; $ptTable)


$cntTables:=Get last table number:C254
For ($incTables; 1; $cntTables)
	$tableName:=Table name:C256($incTables)
	$ptTable:=Table:C252($incTables)
	//  If ((vText1="Counter@") | (vText1="zz@") | (vText1="(@") | (vText1="Default"))
	If (($tableName="zz@") | ($tableName="(@"))
		
		If ($tableName="@popups@")  // ### bj ### 20180912_0824
			// rescue popups from 2004 data
			$cntRecords:=Records in selection:C76($ptTable->)
			FIRST RECORD:C50($ptTable->)
			ORDER BY:C49([zzzPopUps_Choices:146]; [zzzPopUps_Choices:146]idd_by_converter:3)
			For ($incRecord; 1; $cntRecords)
				CREATE RECORD:C68([PopupChoice:134])
				[PopupChoice:134]choice:3:=[zzzPopUps_Choices:146]choice:1
				SAVE RECORD:C53([PopupChoice:134])
				NEXT RECORD:C51($ptTable->)
			End for 
		End if 
		// ### bj ### 20190924_2328
		// delete these records by intent, not during conversion
		// ALL RECORDS(Table($incTables)->)
		// DELETE SELECTION(Table($incTables)->)
	Else 
		// Check to see if the table is active
		// Find in array then use only those found
		
		$fieldNum:=STR_GetUniqueFieldNum(Table name:C256($incTables))
		$ptField:=Field:C253($incTables; $fieldNum)
		READ WRITE:C146($ptTable->)
		$theType:=Type:C295($ptField->)
		
		// find records without values and put in some unique odd value
		Case of 
			: ($theType=Is alpha field:K8:1)
				QUERY:C277($ptTable->; $ptField->="")
			: ($theType=Is longint:K8:6)
				QUERY:C277($ptTable->; $ptField->=0)
		End case 
		
		$cntRec:=Records in selection:C76($ptTable->)
		If ($cntRec>0)
			ConsoleMessage(Table name:C256($ptTable)+": Field: "+Field name:C257($ptField)+": null value count = "+String:C10($cntRec))
			For ($incRec; 1; $cntRec)
				Case of 
					: ($theType=Is alpha field:K8:1)
						$ptField->:="empty"+String:C10(Record number:C243($ptTable->))
					: ($theType=Is longint:K8:6)
						$ptField->:=-$incRec
				End case 
				SAVE RECORD:C53($ptTable->)
				NEXT RECORD:C51($ptTable->)
			End for 
		End if 
		REDUCE SELECTION:C351($ptTable->; 0)
	End if 
End for 

SelectionToZero
