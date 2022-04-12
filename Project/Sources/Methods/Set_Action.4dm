//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/25/18, 23:27:07
// ----------------------------------------------------
// Method: Sets_FromTallyMaster
// Description
// 
//
// Parameters: Action; SetName; TableNum, id
// ----------------------------------------------------

// update this to save the UUID to lookup the tallyMaster 

C_TEXT:C284($vtAction; $1; $vtSetName; $2; $vtSetID; $4)
C_LONGINT:C283($incRay; $cntRay; $tableNum; $3)
ARRAY LONGINT:C221(<>aSetRecordNums; 0)

$vtAction:=""
$vtSetName:=""
$viTableNum:=-1
$vtSetID:=""

For ($vi1; 1; Count parameters:C259)
	Case of 
		: ($vi1=1)
			$vtAction:=$1
		: ($vi1=2)
			$vtSetName:=$2
		: ($vi1=3)
			$viTableNum:=$3
		: ($vi1=4)
			$vtSetID:=$4
	End case 
End for 

If (Count parameters:C259=4)
	
	$vpTable:=Table:C252($viTableNum)
	$vtNamedSelection:=Table name:C256($vpTable)+"CurrentSelection"
	
	COPY NAMED SELECTION:C331($vpTable->; $vtNamedSelection)
	
	If ($vtSetID#"")
		QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]id:38=$vtSetID)
	Else 
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$vtSetName; *)
		QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]purpose:3="Sets"; *)
		QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]tableNum:1=$viTableNum)
	End if 
	
	$viSetCount:=Records in selection:C76([TallyMaster:60])
	//$viRecordCount:=Records in selection($vpTable->) use this later
	
	ARRAY LONGINT:C221($aiRecords; 0)
	
	Case of 
		: ($vtAction="save")
			// save current selection
			
			SELECTION TO ARRAY:C260($vpTable->; $aiRecords)
			
			Case of 
				: ($viSetCount=0)
					
					CREATE RECORD:C68([TallyMaster:60])
					[TallyMaster:60]tableNum:1:=$viTableNum
					[TallyMaster:60]name:8:=$vtSetName
					[TallyMaster:60]purpose:3:="Sets"
					[TallyMaster:60]publish:25:=1
					
					OB SET ARRAY:C1227([TallyMaster:60]obGeneral:41; "Set"; $aiRecords)
					OB SET:C1220([TallyMaster:60]obGeneral:41; "Records"; Size of array:C274($aiRecords))
					
					SAVE RECORD:C53([TallyMaster:60])
					
					APPEND TO ARRAY:C911(aTmpLong1; [TallyMaster:60]tableNum:1)
					APPEND TO ARRAY:C911(aText3; Table name:C256([TallyMaster:60]tableNum:1))
					APPEND TO ARRAY:C911(aText4; [TallyMaster:60]id:38)
					APPEND TO ARRAY:C911(aText5; [TallyMaster:60]name:8)
					APPEND TO ARRAY:C911(aTmpLong2; Record number:C243([TallyMaster:60]))
					REDUCE SELECTION:C351([TallyMaster:60]; 0)
					
					//  CHOPPED  AlpUpdateArea(eFileList; -2)
					
				: ($viSetCount=1)  // saving to an existing set
					
					// check if set name or table has changed ask to over write saved set
					
					If (([TallyMaster:60]tableNum:1#$viTableNum) | ([TallyMaster:60]name:8#$vtSetName))
						$vtRecords:=OB Get:C1224([TallyMaster:60]obGeneral:41; "Records"; Is text:K8:3)
						
						$vtConfirm:="Overwrite Set "+" \""+$vtSetName+"\"\r\rReplace "+$vtRecords+" "+Table name:C256([TallyMaster:60]tableNum:1)+" Records \r\rWith "+String:C10(Size of array:C274($aiRecords))+" "+Table name:C256($viTableNum)+" Records"
						CONFIRM:C162($vtConfirm; " OVERWRITE "; " Cancel ")
						If (OK=1)
							[TallyMaster:60]tableNum:1:=$viTableNum
							[TallyMaster:60]name:8:=$vtSetName
							[TallyMaster:60]purpose:3:="Sets"
							[TallyMaster:60]publish:25:=1
							OB SET ARRAY:C1227([TallyMaster:60]obGeneral:41; "Set"; $aiRecords)
							OB SET:C1220([TallyMaster:60]obGeneral:41; "Records"; Size of array:C274($aiRecords))
							SAVE RECORD:C53([TallyMaster:60])
							
						End if 
					Else   // no conflict
						[TallyMaster:60]tableNum:1:=$viTableNum
						[TallyMaster:60]name:8:=$vtSetName
						[TallyMaster:60]purpose:3:="Sets"
						[TallyMaster:60]publish:25:=1
						OB SET ARRAY:C1227([TallyMaster:60]obGeneral:41; "Set"; $aiRecords)
						OB SET:C1220([TallyMaster:60]obGeneral:41; "Records"; Size of array:C274($aiRecords))
						SAVE RECORD:C53([TallyMaster:60])
					End if 
					
				: ($viSetCount>1)
					
					ConsoleMessage("Error: Duplicate Records")
					ProcessTableOpen(Table:C252(->[TallyMaster:60]); ""; "Duplicate Sets")
					
					//FIRST RECORD([TallyMaster])
					//OB SET ARRAY([TallyMaster]ObGeneral;"Set";$aiRecords)
					
			End case 
			
		: ($vtAction="show")
			
			Case of 
				: ($viSetCount=0)
					ALERT:C41(" Set "+$vtSetName+" Not Found")
					
				: ($viSetCount=1)
					
					OB GET ARRAY:C1229([TallyMaster:60]obGeneral:41; "Set"; $aiRecords)
					CREATE SELECTION FROM ARRAY:C640($vpTable->; $aiRecords; $vtSetName)
					USE NAMED SELECTION:C332($vtSetName)
					CLEAR NAMED SELECTION:C333($vtSetName)
					
					// update set information
					[TallyMaster:60]tableNum:1:=$viTableNum
					[TallyMaster:60]name:8:=$vtSetName
					[TallyMaster:60]purpose:3:="Sets"
					[TallyMaster:60]publish:25:=1
					OB SET:C1220([TallyMaster:60]obGeneral:41; "Records"; Records in selection:C76($vpTable->))
					SAVE RECORD:C53([TallyMaster:60])
					
				: ($viSetCount>1)
					
					// extreme edge case There should never be multiple tallymasters with the same id
					
					FIRST RECORD:C50([TallyMaster:60])
					OB GET ARRAY:C1229([TallyMaster:60]obGeneral:41; "Set"; $aiRecords)
					CREATE SELECTION FROM ARRAY:C640($vpTable->; $aiRecords; $vtSetName)
					USE NAMED SELECTION:C332($vtSetName)
					CLEAR NAMED SELECTION:C333($vtSetName)
					
					// update set information
					[TallyMaster:60]tableNum:1:=$viTableNum
					[TallyMaster:60]name:8:=$vtSetName
					[TallyMaster:60]purpose:3:="Sets"
					[TallyMaster:60]publish:25:=1
					OB SET:C1220([TallyMaster:60]obGeneral:41; "Records"; Records in selection:C76($vpTable->))
					SAVE RECORD:C53([TallyMaster:60])
					
				: ($vtAction="file")
					
					// find <>ptCurTable and <>curSelSet
					LOAD SET:C185($vpTable->; $vtSetName; Storage:C1525.folder.jitPrefPath+$vtSetID)
					If ((OK=1) & (Records in set:C195($vtSetName)>0))
						
						USE SET:C118($vtSetName)
						//CLEAR SET($vtSetName)
						
						// create set as a record
						Set_Action("save"; $vtSetName; $viTableNum; $vtSetID)
						//delete set as external file
						$error:=HFS_Delete(Storage:C1525.folder.jitPrefPath+$vtSetID)
						// reload list of sets
						ALpLoadSets
						
					End if 
					
			End case 
			
			If (Records in selection:C76($vpTable->)>0)
				ProcessTableOpen(Table:C252($vpTable); ""; $vtSetName)
			End if 
			
			REDUCE SELECTION:C351([TallyMaster:60]; 0)
			USE NAMED SELECTION:C332($vtNamedSelection)
			CLEAR NAMED SELECTION:C333($vtNamedSelection)
			
	End case 
	ConsoleMessage("Error: Method Sets_FromTallyMaster requires 4 parameters")
End if 



//  If (False)  // Bill's procedure
//  
//    // ----------------------------------------------------
//    // User name (OS): Bill James
//    // Date and time: 10/25/18, 23:27:07
//    // ----------------------------------------------------
//    // Method: Sets_FromTallyMaster
//    // Description
//    // 
//    //
//    // Parameters
//    // ----------------------------------------------------
//  
//    // update this to save the UUID to lookup the tallyMaster 
//  
//  C_TEXT($vtSetName;vtSetName)
//  C_TEXT($1;$useFor)
//  C_LONGINT($2;$tableNum;$3;$tallymasterRecNum)
//  C_LONGINT($incRay;$cntRay)
//  ARRAY LONGINT(<>aSetRecordNums;0)
//  $vtAction:=$1
//  $tallymasterRecNum:=-1
//  $tableNum:=-1
//  $vtSetName:=vtSetName
//  If (Count parameters>=2)
//  $tableNum:=$2
//  If (Count parameters>=3)
//  $tallymasterRecNum:=$3
//  End if 
//  End if 
//  Case of 
//  : ($useFor="create")
//  If ($vtSetName="")
//  $vtSetName:=Request("Enter Set Name")
//  End if 
//  
//  If (vtSetName#"")
//  
//  SELECTION TO ARRAY(ptCurTable->;<>aSetRecordNums)
//  CREATE RECORD([TallyMaster])
//  [TallyMaster]TableNum:=Table(ptCurTable)
//  [TallyMaster]Name:=$vtSetName
//  [TallyMaster]Purpose:="Sets"
//    //vText2:=Request("How is this used?")
//  [TallyMaster]Profile1:=vText2
//  [TallyMaster]Publish:=1
//  $cntRay:=Size of array(<>aSetRecordNums)-1
//  
//  ARRAY LONGINT($aiRecordNum;0)
//  
//  SELECTION TO ARRAY(ptCurTable->;$aiRecordNum)
//  
//  OB SET ARRAY([TallyMaster]ObGeneral;"Set";$aiRecordNum)
//  
//  For ($incRay;1;$cntRay)
//  [TallyMaster]Template:=[TallyMaster]Template+String(<>aSetRecordNums{$incRay})+","
//  End for 
//  [TallyMaster]Template:=[TallyMaster]Template+String(<>aSetRecordNums{$cntRay})  // last one without ","
//  SAVE RECORD([TallyMaster])
//  
//  If (False)
//  $tallymasterRecNum:=Record number([TallyMaster])
//  End if 
//  End if 
//  
//  : ($useFor="testing")
//  If (False)  // listed for reference and testing changes
//  $tableNum:=$2
//  $tallymasterRecNum:=$3
//  End if 
//  $script:="Sets_FromTallyMaster(\"showSet\";"+String($tableNum)+";"+String($tallymasterRecNum)+")"
//  ProcessTableOpen ($tableNum;$script)
//  
//  
//  : ($useFor="showSet")  // shift to a new process to preserve the existing set
//  
//  $script:="Sets_FromTallyMaster(\"openSet\";"+String($tableNum)+";"+String($tallymasterRecNum)+")"
//  C_LONGINT($childProcess)
//  $childProcess:=New process("ProcessTableQuery";<>tcPrsMemory;String(Count user processes)+"- "+Table name($tableNum);Current process;$script;"";$tableNum)  //;Table($tableNum))
//  
//  : ($useFor="openSet")  // open in new process
//  
//  If ($tallymasterRecNum<0)
//  ALERT("No TallyMaster Record Number selected")
//  Else 
//  ARRAY TEXT($aRecordText;0)
//  GOTO RECORD([TallyMaster];$tallymasterRecNum)
//  
//  ARRAY LONGINT($aiRecordNum;0)
//  OB GET ARRAY([TallyMaster]ObGeneral;"Set";$aiRecordNum)
//  CREATE SET FROM ARRAY(Table([TallyMaster]TableNum)->;$aiRecordNum;[TallyMaster]Name)  // userset
//  USE SET([TallyMaster]Name)
//  CLEAR SET([TallyMaster]Name)
//  
//  TextToArray ([TallyMaster]Template;->$aRecordText;",")
//  $cntRay:=Size of array($aRecordText)
//  ARRAY LONGINT($aSet;$cntRay)
//  For ($incRay;1;$cntRay)
//  $aSet{$incRay}:=Num($aRecordText{$incRay})
//  End for 
//  
//  CREATE SET FROM ARRAY(Table($tableNum)->;$aSet;[TallyMaster]Name)
//  USE SET([TallyMaster]Name)
//  CLEAR SET([TallyMaster]Name)
//    //   ProcessTableOpen ($tableNum;"";[TallyMaster]Name)
//  End if 
//  End case 
//  REDUCE SELECTION([TallyMaster];0)
//  End if 


