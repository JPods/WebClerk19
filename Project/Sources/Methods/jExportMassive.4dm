//%attributes = {"publishedWeb":true}
//jExportMassive
//June 7, 2002
C_LONGINT:C283($i; $k; $indexTable)

KeyModifierCurrent
CONFIRM:C162("This will take a long time.")
If (OK=1)
	
	Case of 
		: (OptKey=1)
			File_Select("Select the file and records you wish to send.")
			If (OK=1)
				ON ERR CALL:C155("jOECNoAction")
				$k:=Records in table:C83(ptCurTable->)
				C_TEXT:C284($tableName)
				$tableName:=Table name:C256(ptCurTable)
				//ThermoInitExit ("Exporting Reverse "+$tableName;$k;True)
				
				If ($k>0)
					//ThermoInitExit ("Exporting "+Table name(ptCurTable);$k;False)
					$viProgressID:=Progress New
					$strName:=Table name:C256(ptCurTable->)
					C_TIME:C306($myDoc)
					$myDoc:=Create document:C266($strName)
					If (OK=1)
						CLOSE DOCUMENT:C267($myDoc)
						SET CHANNEL:C77(10; document)
						LAST RECORD:C200(ptCurTable->)
						For ($i; 1; $k)
							//Thermo_Update ($i)
							ProgressUpdate($viProgressID; $i; $k; "Exporting "+$strName)
							If (<>ThermoAbort)
								$i:=$k
							End if 
							SEND RECORD:C78(ptCurTable->)
							PREVIOUS RECORD:C110(ptCurTable->)
						End for 
						SET CHANNEL:C77(11)
					End if 
				End if 
				//Thermo_Close 
				Progress QUIT($viProgressID)
				ON ERR CALL:C155("")
			End if 
		: (ShftKey=1)
			File_Select("Select the file and records you wish to send.")
			If (OK=1)
				ON ERR CALL:C155("jOECNoAction")
				$k:=Records in table:C83(ptCurTable->)
				If ($k>0)
					//ThermoInitExit ("Exporting "+$strName;$k;True)
					$viProgressID:=Progress New
					
					$strName:=Table name:C256(ptCurTable->)
					SET CHANNEL:C77(10; $strName)
					For ($i; 1; $k)
						//Thermo_Update ($i)
						ProgressUpdate($viProgressID; $i; $k; "Exporting "+$strName)
						
						If (ThermoAbort)
							$i:=$k
						End if 
						SEND RECORD:C78(ptCurTable->)
						NEXT RECORD:C51(ptCurTable->)
					End for 
					SET CHANNEL:C77(11)
				End if 
				//Thermo_Close 
				Progress QUIT($viProgressID)
				ON ERR CALL:C155("")
			End if 
		: (CmdKey=1)
			TRACE:C157
			vText1:=Get_FolderName("Select folder for exporting all.")
			If (vText1#"")
				
				//CONFIRM("Add Quots")
				vRecDelim:="\r"
				//If (OK=1)
				//vFldSepBeg:=Char(34)
				//vFldSepEnd:=Char(34)
				//vFldDelim:=","
				//Else 
				vFldSepBeg:=""
				vFldSepEnd:=""
				vFldDelim:="\t"
				// End if 
				vi2:=Get last table number:C254
				For (vi1; 1; vi2)
					KeyModifierCurrent
					If (CapKey=1)
						TRACE:C157
					End if 
					curTableNum:=vi1
					ALL RECORDS:C47(Table:C252(vi1)->)
					If (Records in selection:C76(Table:C252(vi1)->)>0)
						StructureFields(curTableNum)
						jArchExportRay
						
						//MatchAdd (False;Size of array(aMatchType))
						jArchExportAll(vText1+String:C10(vi1; "000")+"_Ex_"+Table name:C256(vi1)+".mex")
					End if 
				End for 
			End if 
			vFldDelim:="\t"
		Else 
			ON ERR CALL:C155("jOECNoAction")
			C_LONGINT:C283($cntTables; $indexTable; $startTable)
			$cntTables:=Get last table number:C254
			$startTable:=1
			For ($indexTable; $startTable; $cntTables)
				
				ALL RECORDS:C47(Table:C252($indexTable)->)
				$k:=Records in table:C83(Table:C252($indexTable)->)
				If (OptKey=1)
					CONFIRM:C162("Export for file "+Table name:C256($indexTable)+" Records "+String:C10($k))
				Else 
					OK:=1
				End if 
				If (OK=1)
					If ($k>0)
						//ThermoInitExit ("Exporting "+String($indexTable)+" ";$k;True)
						$viProgressID:=Progress New
						
						$strName:=Storage:C1525.folder.jitF+"zzzME_"+Table name:C256($indexTable)+".mdd"
						SET CHANNEL:C77(10; $strName)
						For ($i; 1; $k)
							//Thermo_Update ($i)
							ProgressUpdate($viProgressID; $i; $k; "Exporting "+String:C10($indexTable))
							If (ThermoAbort)
								$i:=$k
								$indexTable:=Get last table number:C254
							End if 
							SEND RECORD:C78(Table:C252($indexTable)->)
							NEXT RECORD:C51(Table:C252($indexTable)->)
						End for 
						SET CHANNEL:C77(11)
						App_SetSuffix(".mdd")
					End if 
				End if 
			End for 
			//Thermo_Close 
			Progress QUIT($viProgressID)
			ON ERR CALL:C155("")
			
			If (False:C215)
				C_LONGINT:C283(vi2; vi1)
				vi2:=Get last table number:C254
				
				For (vi1; 1; vi2)
					ALL RECORDS:C47(Table:C252(vi1)->)
					vi4:=Records in table:C83(Table:C252(vi1)->)
					If (vi4>0)
						FIRST RECORD:C50(Table:C252(vi1)->)
						vText1:=Storage:C1525.folder.jitF+"zzzME_"+Table name:C256(vi1)+".mdd"
						MESSAGE:C88(vText1)
						SET CHANNEL:C77(10; vText1)
						For (vi3; 1; vi4)
							SEND RECORD:C78(Table:C252(vi1)->)
							NEXT RECORD:C51(Table:C252(vi1)->)
						End for 
						SET CHANNEL:C77(11)
					End if 
					
				End for 
				
				
				
				
				
				
				
				
				vi2:=Get last table number:C254
				vi1:=2
				For (vi1; 2; vi2)
					ALL RECORDS:C47(Table:C252(vi1)->)
					vi4:=Records in table:C83(Table:C252(vi1)->)
					If (vi4>0)
						vText1:=Storage:C1525.folder.jitF+"zzzME_"+Table name:C256(vi1)+".mdd"
						SET CHANNEL:C77(10; vText1)
						For (vi3; 1; vi4)
							SEND RECORD:C78(Table:C252(vi1)->)
							NEXT RECORD:C51(Table:C252(vi1)->)
						End for 
						SET CHANNEL:C77(11)
						App_SetSuffix(".mdd")
					End if 
				End for 
			End if 
	End case 
End if 


If (False:C215)
	C_LONGINT:C283($cntTables; $indexTable; $startTable)
	$cntTables:=Get last table number:C254
	$startTable:=1
	For ($indexTable; $startTable; $cntTables)
		
		ALL RECORDS:C47(Table:C252($indexTable)->)
		$k:=Records in table:C83(Table:C252($indexTable)->)
		If (OptKey=1)
			CONFIRM:C162("Export for file "+Table name:C256($indexTable)+" Records "+String:C10($k))
		Else 
			OK:=1
		End if 
		If (OK=1)
			If ($k>0)
				//ThermoInitExit ("Exporting "+String($indexTable)+" ";$k;True)
				$viProgressID:=Progress New
				
				$strName:=Storage:C1525.folder.jitF+"zzzME_"+Table name:C256($indexTable)+".mdd"
				SET CHANNEL:C77(10; $strName)
				For ($i; 1; $k)
					//Thermo_Update ($i)
					ProgressUpdate($viProgressID; $i; $k; "Exporting "+String:C10($indexTable))
					
					If (ThermoAbort)
						$i:=$k
						$indexTable:=Get last table number:C254
					End if 
					SEND RECORD:C78(Table:C252($indexTable)->)
					NEXT RECORD:C51(Table:C252($indexTable)->)
				End for 
				SET CHANNEL:C77(11)
				App_SetSuffix(".mdd")
			End if 
		End if 
	End for 
	//Thermo_Close 
	Progress QUIT($viProgressID)
	ON ERR CALL:C155("")
End if 

If (False:C215)
	
	vi2:=Get last table number:C254
	vi9:=1
	For (vi1; vi9; vi2)
		
		ALL RECORDS:C47(Table:C252(vi1)->)
		vi4:=Records in table:C83(Table:C252(vi1)->)
		If (OptKey=1)
			CONFIRM:C162("Export for file "+Table name:C256(vi1)+" Records "+String:C10(vi4))
		Else 
			OK:=1
		End if 
		If (OK=1)
			If (vi4>0)
				//ThermoInitExit ("Exporting "+String(vi1)+" ";vi4;True)
				$viProgressID:=Progress New
				vText9:=Storage:C1525.folder.jitF+"zzzME_"+Table name:C256(vi1)+".mdd"
				SET CHANNEL:C77(10; vText9)
				For (vi3; 1; vi4)
					Thermo_Update(vi3)
					ProgressUpdate($viProgressID; vi3; vi4; "Exporting "+String:C10(vi1))
					If (ThermoAbort)
						vi3:=vi4
						vi1:=Get last table number:C254
					End if 
					SEND RECORD:C78(Table:C252(vi1)->)
					NEXT RECORD:C51(Table:C252(vi1)->)
				End for 
				SET CHANNEL:C77(11)
				App_SetSuffix(".mdd")
			End if 
		End if 
	End for 
	//Thermo_Close 
	Progress QUIT($viProgressID)
	ON ERR CALL:C155("")
	
	
	
	error:=0
	vi2:=Get last table number:C254
	vi9:=1
	error:=0
	For (vi1; vi9; vi2)
		ALL RECORDS:C47(Table:C252(vi1)->)
		vi4:=Records in table:C83(Table:C252(vi1)->)
		If (vi4>0)
			ALERT:C41(Table name:C256(vi1)+": "+String:C10(vi4))
			vText9:=Storage:C1525.folder.jitF+"zzzME_"+Table name:C256(vi1)+".mdd"
			SET CHANNEL:C77(10; vText9)
			If (error=0)
				For (vi3; 1; vi4)
					SEND RECORD:C78(Table:C252(vi1)->)
					NEXT RECORD:C51(Table:C252(vi1)->)
				End for 
				SET CHANNEL:C77(11)
			Else 
				ALERT:C41(Table name:C256(vi1)+": "+String:C10(error))
			End if 
			error:=0
		End if 
	End for 
	
	
	
	ON ERR CALL:C155("")
	
End if 