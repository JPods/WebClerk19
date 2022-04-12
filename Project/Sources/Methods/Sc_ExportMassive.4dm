//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-25T00:00:00, 17:06:26
// ----------------------------------------------------
// Method: Sc_ExportMassive
// Description
// Modified: 03/25/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



//If (False)
C_LONGINT:C283(cntTables; indexTable; startTable; result)
C_LONGINT:C283(cntRecords; indexRecords)
C_TEXT:C284(strName; pathname)
cntTables:=Get last table number:C254
startTable:=143
For (indexTable; startTable; cntTables)
	strName:=Storage:C1525.folder.jitF+"zzzME_"+Table name:C256(indexTable)+".mdd"
	result:=Test path name:C476(strName)
	If (result<0)
		ALL RECORDS:C47(Table:C252(indexTable)->)
		cntRecords:=Records in table:C83(Table:C252(indexTable)->)
		If (OptKey=1)
			CONFIRM:C162("Export for file "+Table name:C256(indexTable)+" Records "+String:C10(cntRecords))
		Else 
			OK:=1
		End if 
		If (OK=1)
			If (cntRecords>0)
				SET CHANNEL:C77(10; strName)
				For (indexRecords; 1; cntRecords)
					SEND RECORD:C78(Table:C252(indexTable)->)
					NEXT RECORD:C51(Table:C252(indexTable)->)
				End for 
				SET CHANNEL:C77(11)
				App_SetSuffix(".mdd")
			End if 
		End if 
	End if 
End for 
ON ERR CALL:C155("")
//End if 