//%attributes = {"publishedWeb":true}
//  
//  
//    // ----------------------------------------------------
//    // User name (OS): Bill James
//    // Date and time: 2016-02-29T00:00:00, 23:17:38
//    // ----------------------------------------------------
//    // Method: UniqueBySequence
//    // Description
//    // Modified: 02/29/16
//    // Structure: CEv13_131005
//    // 
//    //
//    // Parameters
//    // ----------------------------------------------------
//  
//    // Reset the UniqueIDs
//  
//  ConsoleMessage ("ConsoleLaunch")  // ### jwm ### 20160414_1615
//  
//    // aaaqqqzzz
//    // Called by UniqueForce
//    //  CounterArrays sets up the UniqueField Pointers
//  C_LONGINT($1;$tableNum;$fieldNum)
//  C_LONGINT($incRecords;$cntRecords)
//  C_POINTER($ptTable;$ptField)
//  C_TEXT($tableName)
//  C_TIME($timeStart;$timeElapsed)
//  C_LONGINT($vResult;$incBuffer;$maxBuffer)
//  
//  $maxBuffer:=10000
//  
//  
//  $timeStart:=Current time
//  If (Count parameters=0)
//  $ptTable:=(->[dInventory])
//  $tableNum:=Table(->[dInventory])
//  Else 
//  $ptTable:=Table($1)
//  $tableNum:=$1
//  End if 
//  $tableName:=Table name($ptTable)
//  ALL RECORDS($ptTable->)
//  $cntRecords:=Records in selection($ptTable->)
//  ConsoleMessage ($tableName+": records "+String($cntRecords))
//  Case of 
//  : ($ptTable=(->[Customer]))
//  Counters_MaxValue (->[Customer])
//  : ($ptTable=(->[Order]))
//  Counters_MaxValue (->[Order])
//  : ($ptTable=(->[Item]))
//  Counters_MaxValue (->[Item])
//  : ($ptTable=(->[Rep]))
//  Counters_MaxValue (->[Rep])
//  : ($ptTable=(->[Invoice]))
//  Counters_MaxValue (->[Invoice])
//  : ($ptTable=(->[Payment]))
//  Counters_MaxValue (->[Payment])
//  : ($ptTable=(->[Ledger]))
//  Counters_MaxValue (->[Ledger])
//  : ($ptTable=(->[Vendor]))
//  Counters_MaxValue (->[Vendor])
//  : ($ptTable=(->[PO]))
//  Counters_MaxValue (->[PO])
//  : ($ptTable=(->[Proposal]))
//  Counters_MaxValue (->[Proposal])
//  : ($ptTable=(->[WorkOrder]))
//  Counters_MaxValue (->[WorkOrder])
//  : ($ptTable=(->[Project]))
//  Counters_MaxValue (->[Project])
//    // : ($ptTable=(->[EventLog]))
//  : ($ptTable=(->[Carrier]))
//  Counters_MaxValue (->[Carrier])  // ### jwm ### 20160414_1521 protect related records weights and zones
//  : ($ptTable=(->[SpecialDiscount]))
//  Counters_MaxValue (->[SpecialDiscount])  // ### jwm ### 20160414_1521 protect related records ItemDiscounts
//  : ($ptTable=(->[Contact]))
//  Counters_MaxValue (->[Contact])  // ### jwm ### 20160414_1521 protect related records RemoteUsers
//  : ($ptTable=(->[Contact]))
//  Counters_MaxValue (->[Contact])  // ### jwm ### 20160414_1521 protect related records RemoteUsers
//  
//  
//  
//  
//  Else 
//  $ptTable:=Table($tableNum)
//  $fieldNum:=STR_GetUniqueFieldNum($tableNum)
//  $ptField:=Field($tableNum;$fieldNum)
//  
//  ALL RECORDS($ptTable->)
//  $cntRecords:=Records in selection($ptTable->)
//  
//    //If ($cntRecords<100000)  // two ways to set uniques by 
//  If (False)  // two ways to set uniques by pply to selection 
//  
//  ConsoleMessage ($tableName+": Sequencing by Arrays")
//  ARRAY LONGINT($alNegID;$cntRecords)
//  ARRAY LONGINT($alUniqueID;$cntRecords)
//  For ($incRecords;1;$cntRecords)
//  $alUniqueID{$incRecords}:=$incRecords
//  $alNegID{$incRecords}:=-$incRecords
//  End for 
//  ARRAY TO SELECTION($alNegID;$ptField->)
//  FLUSH BUFFERS
//  ARRAY TO SELECTION($alUniqueID;$ptField->)
//  FLUSH BUFFERS
//  Else 
//  ConsoleMessage ($tableName+": Sequencing by Records")
//  
//  Open window(100;200;500;300;8;"Progress")
//  ERASE WINDOW
//  GOTO XY(6;3)
//  
//  FIRST RECORD($ptTable->)
//  For ($incRecords;1;$cntRecords)
//  
//  $percent:=Round(($incRecords/$cntRecords*100);0)
//  SET WINDOW TITLE($tableName)
//  ERASE WINDOW
//  GOTO XY(6;3)
//  ConsoleMessage (" Record "+String($incRecords)+" of "+String($cntRecords)+"  "+String($percent)+" %")
//  
//  $ptField->:=-$incRecords-10000000
//  SAVE RECORD($ptTable->)
//  NEXT RECORD($ptTable->)
//  $vResult:=Mod($incRecords;$maxBuffer)
//  If ($vResult=0)
//  ConsoleMessage ($tableName+": Count "+String($incRecords)+" of "+String($cntRecords))
//  FLUSH BUFFERS
//  End if 
//  End for 
//  FLUSH BUFFERS
//  FIRST RECORD($ptTable->)
//  For ($incRecords;1;$cntRecords)
//  $ptField->:=$incRecords
//  SAVE RECORD($ptTable->)
//  SET TEXT TO PASTEBOARD("$tableName = "+$tableName+"  $incRecords = "+String($incRecords)+"  Record Number = "+String(Record number($ptTable->)))
//  NEXT RECORD($ptTable->)
//  $vResult:=Mod($incRecords;$maxBuffer)
//  If ($vResult=0)
//  ConsoleMessage ($tableName+": Count "+String($incRecords)+" of "+String($cntRecords))
//  FLUSH BUFFERS
//  End if 
//  End for 
//  
//  ERASE WINDOW
//  GOTO XY(6;3)
//  ConsoleMessage ("Ending Script Basic Loop")
//  CLOSE WINDOW
//  
//  FLUSH BUFFERS
//  End if 
//  
//    //  See Counters_MaxValue also
//  
//  QUERY([Counter];[Counter]TableNum=$tableNum)
//  If (Locked([Counter]))
//  ConsoleMessage ($tableName+": LOCKED: Setting Counter to Max")
//  Else 
//  ConsoleMessage ($tableName+": Setting Counter to Max")
//  [Counter]Counter:=$cntRecords+5
//  SAVE RECORD([Counter])
//  
//  QUERY([CounterPending];[CounterPending]TableNum=$tableNum)
//  DELETE SELECTION([CounterPending])
//  CounterPendingBuild($tableNum)
//  End if 
//  
//  End case 
//  $timeElapsed:=Current time-$timeStart
//  ConsoleMessage ($tableName+" Elapsed time =  "+String($timeElapsed))
//  REDUCE SELECTION($ptTable->;0)
//  
//  
//  
//  If (False)
//  
//    // ----------------------------------------------------
//    // User name (OS): Bill James
//    // Date and time: 2016-02-29T00:00:00, 23:17:38
//    // ----------------------------------------------------
//    // Method: UniqueBySequence
//    // Description
//    // Modified: 02/29/16
//    // Structure: CEv13_131005
//    // 
//    //
//    // Parameters
//    // ----------------------------------------------------
//  
//    // Reset the UniqueIDs
//  
//    // Called by UniqueForce
//    //  CounterArrays sets up the UniqueField Pointers
//  
//  ConsoleMessage ("ConsoleLaunch")  // ### jwm ### 20160414_1615
//  
//  C_LONGINT($1;$tableNum;$fieldNum)
//  C_LONGINT($incRecords;$cntRecords)
//  C_POINTER($ptTable;$ptField)
//  C_TEXT($tableName)
//  C_TIME($timeStart;$timeElapsed)
//  $timeStart:=Current time
//  If (Count parameters=0)
//  $ptTable:=(->[dInventory])
//  $tableNum:=Table(->[dInventory])
//  Else 
//  $ptTable:=Table($1)
//  $tableNum:=$1
//  End if 
//  $tableName:=Table name($ptTable)
//  ALL RECORDS($ptTable->)
//  $cntRecords:=Records in selection($ptTable->)
//  ConsoleMessage ($tableName+": records "+String($cntRecords))
//  Case of 
//  : ($ptTable=(->[Customer]))
//  Counters_MaxValue (->[Customer])
//  : ($ptTable=(->[Order]))
//  Counters_MaxValue (->[Order])
//  : ($ptTable=(->[Item]))
//  Counters_MaxValue (->[Item])
//  : ($ptTable=(->[Rep]))
//  Counters_MaxValue (->[Rep])
//  : ($ptTable=(->[Invoice]))
//  Counters_MaxValue (->[Invoice])
//  : ($ptTable=(->[Payment]))
//  Counters_MaxValue (->[Payment])
//  : ($ptTable=(->[Ledger]))
//  Counters_MaxValue (->[Ledger])
//  : ($ptTable=(->[Vendor]))
//  Counters_MaxValue (->[Vendor])
//  : ($ptTable=(->[PO]))
//  Counters_MaxValue (->[PO])
//  : ($ptTable=(->[Proposal]))
//  Counters_MaxValue (->[Proposal])
//  : ($ptTable=(->[WorkOrder]))
//  Counters_MaxValue (->[WorkOrder])
//  : ($ptTable=(->[Project]))
//  Counters_MaxValue (->[Project])
//    // : ($ptTable=(->[EventLog]))
//  : ($ptTable=(->[Carrier]))
//  Counters_MaxValue (->[Carrier])  // ### jwm ### 20160414_1521 protect related records weights and zones
//  : ($ptTable=(->[SpecialDiscount]))
//  Counters_MaxValue (->[SpecialDiscount])  // ### jwm ### 20160414_1521 protect related records ItemDiscounts
//  
//  Else 
//  $ptTable:=Table($tableNum)
//  $fieldNum:=STR_GetUniqueFieldNum($tableNum)
//  $ptField:=Field($tableNum;$fieldNum)
//  
//  ConsoleMessage ($tableName+": Clearing Index")
//    // ### jwm ### 20160415_1459 clear index
//  SET INDEX($ptField->;False;100)
//  
//  ConsoleMessage ($tableName+": Building Index")
//    // ### jwm ### 20160415_1459 rebuild index
//  SET INDEX($ptField->;True;100)
//  
//  ALL RECORDS($ptTable->)
//  $cntRecords:=Records in selection($ptTable->)
//  
//    //If ($cntRecords<100000)  // two ways to set uniques by 
//  If (False)  // two ways to set uniques by pply to selection 
//  ConsoleMessage ($tableName+": Sequencing by Arrays")
//  ARRAY LONGINT($alNegID;$cntRecords)
//  ARRAY LONGINT($alUniqueID;$cntRecords)
//  For ($incRecords;1;$cntRecords)
//  $alUniqueID{$incRecords}:=$incRecords
//  $alNegID{$incRecords}:=-$incRecords-100000
//  End for 
//  ARRAY TO SELECTION($alNegID;$ptField->)
//  ARRAY TO SELECTION($alUniqueID;$ptField->)
//  Else 
//  ConsoleMessage ($tableName+": Sequencing by Records")
//  
//  FIRST RECORD($ptTable->)
//  For ($incRecords;1;$cntRecords)
//  
//  $percent:=Round(($incRecords/$cntRecords*100);0)
//  
//  ConsoleMessage (" Record "+String($incRecords)+" of "+String($cntRecords)+"  "+String($percent)+" %")
//  
//  $ptField->:=-$incRecords-100000
//  SAVE RECORD($ptTable->)
//  NEXT RECORD($ptTable->)
//  End for 
//  
//  ConsoleMessage ("Ending Script Basic Loop")
//  
//  FIRST RECORD($ptTable->)
//  For ($incRecords;1;$cntRecords)
//  $ptField->:=$incRecords
//  SAVE RECORD($ptTable->)
//    // SET TEXT TO PASTEBOARD("$incRecords = "+String($incRecords)+"  Record Number = "+String(Record number($ptTable->)))
//  NEXT RECORD($ptTable->)
//  End for 
//  End if 
//  
//    //  See Counters_MaxValue also
//  
//  QUERY([Counter];[Counter]TableNum=$tableNum)
//  If (Locked([Counter]))
//  ConsoleMessage ($tableName+": LOCKED: Setting Counter to Max")
//  Else 
//  ConsoleMessage ($tableName+": Setting Counter to Max")
//  [Counter]Counter:=$cntRecords+5
//  SAVE RECORD([Counter])
//  
//  QUERY([CounterPending];[CounterPending]TableNum=$tableNum)
//  DELETE SELECTION([CounterPending])
//  CounterPendingBuild($tableNum)
//  End if 
//  
//  
//  End case 
//  $timeElapsed:=Current time-$timeStart
//  ConsoleMessage ($tableName+" Elapsed time =  "+String($timeElapsed))
//  REDUCE SELECTION($ptTable->;0)
//  
//  
//  End if 
