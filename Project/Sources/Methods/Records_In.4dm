//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/21/10, 08:53:06
// ----------------------------------------------------
// Method: Records_In
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141021_1332 added table name to Alert message

If (UserInPassWordGroup("Import"))
	C_LONGINT:C283($i; $o; $k; $chap; $section)
	C_POINTER:C301($1; $ptTable; $2)
	C_TEXT:C284($myDocName; $collisionResolution)
	C_BOOLEAN:C305($doTechUpDt; vbForceNew)
	C_TEXT:C284($purpose)
	C_TEXT:C284($thePrimary)
	
	//CLOSE DOCUMENT(myDoc)
	//TRACE
	$myDocName:=""
	$collisionResolution:="standard"
	$ptTable:=(->[TechNote:58])
	If (Count parameters:C259>0)
		$ptTable:=$1
		$newUnique:=False:C215
		If (Count parameters:C259>1)
			$myDocName:=$2->
			If (Count parameters:C259>2)
				vbForceNew:=$3
				If (Count parameters:C259>3)
					$collisionResolution:=$4
				End if 
			End if 
		End if 
	End if 
	$doTechUpDt:=False:C215
	$techFile:=False:C215
	Case of 
		: ($ptTable=(->[TechNote:58]))
			CONFIRM:C162("Over write matching Tech Note?")
			$doTechUpDt:=(OK=1)
			$techFile:=True:C214
		: ($ptTable=(->[TallyMaster:60]))
			If (allowAlerts_boo)
				CONFIRM:C162("Force a new UniqueID?")
				vbForceNew:=(OK=1)
			End if 
		: ($ptTable=(->[UserReport:46]))
			If (allowAlerts_boo)
				CONFIRM:C162("Force a new UniqueID?")
				vbForceNew:=(OK=1)
			End if 
	End case 
	//
	C_LONGINT:C283(<>vignorprimary)
	C_TEXT:C284($docShortName)
	$theType:=0
	KeyModifierCurrent
	$doForceNew:=False:C215
	If (((cmdKey=1) & (optKey=1)) | (vbForceNew))
		$doForceNew:=True:C214
	End if 
	//
	If ($myDocName="")
		$myDocName:=Get_FileName("Select "+Table name:C256($ptTable)+" file to load."; "")
	End if 
	$docShortName:=HFS_ShortName($myDocName)
	If ($myDocName#"")
		C_LONGINT:C283($tableNum)
		$tableNum:=Num:C11(Substring:C12($docShortName; 1; 3))
		If ($tableNum#Table:C252($ptTable))
			ALERT:C41("File "+$docShortName+" does not begin with Table Number "+String:C10(Table:C252($ptTable)))  // ### jwm ### 20141021_1332
		Else 
			READ WRITE:C146($ptTable->)
			If ($myDocName#"")
				If (CapKey=0)
					//ThermoInitExit ("Loading records";200000;True)
					$k:=-1
					$viProgressID:=Progress New
					
				End if 
				$i:=0
				ProgressUpdate($viProgressID; $i; $k; "Importing Records: ")
				
				vSearchBy:=""
				$tableNum:=Table:C252($ptTable)
				C_TEXT:C284($tableName)
				C_POINTER:C301($ptUUIDField; $ptRay)
				C_LONGINT:C283($fieldNumUUIDKey)
				$tableName:=Table name:C256($ptTable)
				
				StructureFields($tableNum)
				jaFilesFindSrch
				
				C_TEXT:C284($vScript; $buildScript; $afterScript)
				//If ($ptTable#(->[TallyMaster]))
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="CollisionResolution"; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$collisionResolution; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=$tableNum)
				$vScript:=[TallyMaster:60]script:9
				$buildScript:=[TallyMaster:60]build:6
				$afterScript:=[TallyMaster:60]after:7
				REDUCE SELECTION:C351([TallyMaster:60]; 0)
				//end if
				
				If (False:C215)
					If (vSearchBy#"")
						$w:=Find in array:C230(theFields; vSearchBy)
						C_LONGINT:C283($w; $fieldNum; $tableNum; $theType)
						$fieldNum:=theFldNum{$w}
						$theType:=Type:C295($ptField->)
					End if 
				End if 
				//
				C_LONGINT:C283($fieldNumPrimary; $fieldNumUUIDKey)
				$fieldNumPrimary:=STR_GetUniqueFieldNum(Table name:C256($tableNum))
				
				C_TEXT:C284($myUUID)
				// StructureToArrays
				$fieldNumUUIDKey:=STR_GetFieldNumber($tableName; "id")
				$ptUUIDField:=Field:C253($tableNum; $fieldNumUUIDKey)
				
				Case of 
					: (<>vignorprimary=1)
						$theType:=-1  //
					: ($fieldNumPrimary>0)
						$ptField:=Field:C253($tableNum; $fieldNumPrimary)
						$theType:=Type:C295($ptField->)
					Else 
						$theType:=-1
				End case 
				
				// ### jwm ### 20180725_1312 test to see if Record Count is stored in file
				
				SET CHANNEL:C77(10; $myDocName)
				If (OK=1)
					C_LONGINT:C283($RecordCount)
					RECEIVE VARIABLE:C81($RecordCount)
					
					If ((ok=1) & ($RecordCount>0))
						$k:=$RecordCount
					Else 
						// set record count to unknown close and reopen file
						$k:=-1
						SET CHANNEL:C77(11)
						SET CHANNEL:C77(10; $myDocName)
					End if 
					
					If (OK=1)
						
						Repeat 
							$i:=$i+1
							REDUCE SELECTION:C351($ptTable->; 0)  //needed to avoid having a record in the selection, line 149
							// Error was experienced by Christian 160125
							//  CREATE RECORD($ptTable->)  //not necessary
							
							RECEIVE RECORD:C79($ptTable->)
							pvRecordNum:=-1
							If (OK=1)
								Case of 
									: ($tableName="QACustomer")
										$myUUID:=[QAQuestion:71]id:9
										PUSH RECORD:C176([QA:70])
										QUERY:C277([QA:70]; [QA:70]id:17=$myUUID)
										If (Records in selection:C76([QA:70])>0)
											DELETE SELECTION:C66([QA:70])
										End if 
										POP RECORD:C177([QA:70])
										
									: ($techFile)
										If ($doTechUpDt)
											$chap:=[TechNote:58]chapter:14
											$section:=[TechNote:58]section:15
											$purpose:=[TechNote:58]purpose:16
											PUSH RECORD:C176([TechNote:58])
											QUERY:C277([TechNote:58]; [TechNote:58]chapter:14=$chap; *)
											QUERY:C277([TechNote:58];  & [TechNote:58]section:15=$section; *)
											QUERY:C277([TechNote:58];  & [TechNote:58]purpose:16=$purpose)
											If (Records in selection:C76([TechNote:58])>0)
												DELETE SELECTION:C66([TechNote:58])
											End if 
											POP RECORD:C177([TechNote:58])
										End if 
										
										//  [TechNote]id:=""  //two options leave blank or force new
										[TechNote:58]id:28:=Generate UUID:C1066
									Else 
										If ($theType>-1)
											$doPush:=False:C215
											
											Case of 
												: (($theType=0) | ($theType=2) | ($theType=24))
													If (($ptField->="") | ($doForceNew))
														$ptField->:=CounterNew($ptTable)
														// ZZZQQQ  REMOVETHIS
														
														// Modified by: Bill James (2017-05-01T00:00:00)
														
														
													Else 
														PUSH RECORD:C176($ptTable->)
														$doPush:=True:C214
														$thePrimary:=$ptField->
														QUERY:C277(Table:C252($tableNum)->; $ptField->=$thePrimary)
													End if 
												: ($theType=4)
													If (($ptField->=!00-00-00!) | ($doForceNew))
														$ptField->:=Current date:C33
													Else 
														PUSH RECORD:C176($ptTable->)
														$doPush:=True:C214
														C_DATE:C307($queryDate)
														$queryDate:=$ptField->
														QUERY:C277(Table:C252($tableNum)->; $ptField->=$queryDate)
													End if 
												: (($theType=1) | ($theType=8) | ($theType=9))
													
													If (($ptField->=0) | (($doForceNew) & ($ptField->>0)))  //if negative always overwrite existing record
														$ptField->:=CounterNew($ptTable)
													Else 
														PUSH RECORD:C176($ptTable->)
														$doPush:=True:C214
														C_REAL:C285($queryNum)
														$queryNum:=$ptField->
														QUERY:C277(Table:C252($tableNum)->; $ptField->=$queryNum)
													End if 
											End case 
											If (Records in selection:C76($ptTable->)>0)
												C_BOOLEAN:C305(<>doRecordCompare)
												C_LONGINT:C283($existingRecordsProcess; $newRecordsProcess)
												pvRecordNum:=Record number:C243($ptTable->)
												Case of 
													: ($vScript#"")
														C_LONGINT:C283(viPushed)
														C_LONGINT:C283(pvRecordNum)
														ExecuteText(0; $vScript)
														
													: (<>doRecordCompare)
														<>clearConflict:=False:C215
														DB_ShowCurrentSelection($ptTable)
														$existingRecordsProcess:=vLastProcessLaunched
														//selection should already be reduced to zero
														//will not work for complex records (Orders, Invoices, Proposals and POs)
														START TRANSACTION:C239
														POP RECORD:C177($ptTable->)
														//READ ONLY($ptTable->)
														MODIFY RECORD:C57($ptTable->)  //this blocks further action until current record is saved or cancelled.  
														CANCEL TRANSACTION:C241
														READ WRITE:C146($ptTable->)
														//this blocks action until the existing record is released 
														C_TEXT:C284($processName)
														C_LONGINT:C283($processState; $processTime; $processOrigin)
														C_LONGINT:C283($processUniqueID)
														C_BOOLEAN:C305($processVisible)
														PROCESS PROPERTIES:C336($existingRecordsProcess; $processName; $processState; $processTime; $processVisible; $processUniqueID; $processOrigin)
														<>clearConflict:=($processState<0)
														//
														Repeat 
															DELAY PROCESS:C323(Current process:C322; 180)
														Until (<>clearConflict)
													Else 
														LOAD RECORD:C52($ptTable->)
														If (Not:C34(Locked:C147($ptTable->)))
															DELETE SELECTION:C66($ptTable->)
														Else 
															
														End if 
														If ($doPush)
															POP RECORD:C177($ptTable->)
														End if 
												End case 
											Else 
												If ($doPush)
													POP RECORD:C177($ptTable->)
												End if 
											End if 
										End if 
								End case 
								
								
								//   $ptUUIDField:=Get pointer("["+$tableName+"]id")   Did not work
								// $ptUUIDField->:=""  // two options leave blank or force new
								
								
								If ($afterScript#"")
									ExecuteText(0; $afterScript)
								Else 
									ON ERR CALL:C155("jOECNoAction")
									SAVE RECORD:C53($ptTable->)
									ON ERR CALL:C155("")
								End if 
								REDUCE SELECTION:C351($ptTable->; 0)  //needed to avoid having a record in the selection, line 147
							End if 
							
							//If (vNewThermoTotal<$i)
							//vNewThermoTotal:=vNewThermoTotal+10000
							//<>vConnectionStatus:="Loading expanded: "+String(vNewThermoTotal)
							//End if 
							
							//Thermo_Update ($i)
							ProgressUpdate($viProgressID; $i; $k; "Importing Records")
							
							If (<>ThermoAbort)
								$i:=$k
							End if 
						Until (OK=0)
						SET CHANNEL:C77(11)
						Progress QUIT($viProgressID)
					End if 
					If (CapKey=0)
						//Thermo_Close 
					End if 
				End if 
			End if 
		End if 
	End if 
	
	// Modified by: Bill James (2015-02-16T00:00:00 close the Themo Window)
	If (<>ProcThermoProcess>0)
		SET PROCESS VARIABLE:C370(<>ProcThermoProcess; vNewThermometer; -2)
		//setting vNewThermometer to -2 in the Thermo window cancel the window and closes the process
		POST OUTSIDE CALL:C329(<>ProcThermoProcess)
	End if 
End if 