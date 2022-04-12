//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/08/11, 01:42:44
// ----------------------------------------------------
// Method: Fix_Dates
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($i; $k; $cntTables; $ctnFields; $incTables; $incFields; $recInc; $recCnt)
CONFIRM:C162("Fix dates <1990 or >2010")
If (OK=1)
	//ThermoInitExit ("Processing all records, all tables.";0;True)
	$viProgressTables:=Progress New
	$viProgressRecords:=Progress New
	
	For ($incTables; 1; $cntTables)
		$tableName:=Table name:C256($incTables)
		$ptTable:=Table:C252($incTables)
		READ WRITE:C146($ptTable->)
		$cntFields:=Get last field number:C255($incTables)
		ALL RECORDS:C47($ptTable->)
		FIRST RECORD:C50($ptTable->)
		$recCnt:=Records in selection:C76($ptTable->)
		//ThermoInitExit ($tableName;$recCnt;False)
		ProgressUpdate($viProgressTables; $incTables; $incTables; "Processing all records, all tables.")
		
		C_POINTER:C301($ptTable)
		For ($recInc; 1; $recCnt)
			//Thermo_Update ($recInc)
			ProgressUpdate($viProgressRecords; $recInc; $recCnt; "Processing Records for Table: "+Table name:C256($ptTable))
			
			If (<>ThermoAbort)
				$recInc:=$recCnt
				$incTables:=$cntTables
			Else 
				For ($incFields; 1; $cntFields)
					If (Type:C295(Field:C253($incTables; $incFields)->)=4)
						If (((Field:C253($incTables; $incFields)->)<!1990-01-01!) | ((Field:C253($incTables; $incFields)->)>!2020-01-01!))
							Field:C253($incTables; $incFields)->:=!00-00-00!
						End if 
					End if 
				End for 
				SAVE RECORD:C53($ptTable->)
				NEXT RECORD:C51($ptTable->)
			End if 
		End for 
	End for 
	
	//Thermo_Close 
	Progress QUIT($viProgressRecords)
	Progress QUIT($viProgressTables)
	
End if 

