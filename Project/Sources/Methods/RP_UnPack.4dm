//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-26T00:00:00, 11:36:28
// ----------------------------------------------------
// Method: RP_UnPack
// Description
// Modified: 11/26/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptTable; $ptField)
C_LONGINT:C283($theType; $remoteRecordNum)
C_TEXT:C284($replaceStatus)
$remoteRecordNum:=-1
vResponse:=""
If (Locked:C147([SyncRecord:109]))  // SyncRecord must be unlocked.
	If (allowAlerts_boo)
		ALERT:C41("SyncRecord is locked and cannot replace original.")
	End if 
	vResponse:="Failed: SyncRecord Locked"
Else 
	$ptTable:=Table:C252([SyncRecord:109]tableNum:4)
	$ptField:=Field:C253([SyncRecord:109]tableNum:4; [SyncRecord:109]fieldNum:5)
	$theType:=Type:C295(Field:C253([SyncRecord:109]tableNum:4; [SyncRecord:109]fieldNum:5)->)
	$replaceTask:=0
	C_TEXT:C284($fieldValue; $modValue)
	$fieldValue:=[SyncRecord:109]fieldValue:6
	//  $fieldValue:=Substring($fieldValue;3)
	////  --  Check status of Orignial Record
	If ($theType=Is alpha field:K8:1)
		QUERY:C277($ptTable->; $ptField->=$fieldValue)
	Else   //: ($theType=Is LongInt)//9)
		QUERY:C277($ptTable->; $ptField->=Num:C11($fieldValue))
	End if 
	
	Case of 
		: (Records in selection:C76($ptTable->)=0)
			vResponse:=""
			$replaceStatus:="No Record"
		: (Locked:C147($ptTable->))
			vResponse:="Failed: Original Record Locked"
			If (allowAlerts_boo)
				ALERT:C41("Original Record is locked and cannot replace original.")
			End if 
			$replaceTask:=0
			$replaceStatus:=""
		Else 
			$replaceStatus:="Replaced Record"
			vResponse:=""
			DELETE RECORD:C58($ptTable->)
	End case 
	
	If ($replaceStatus#"")  ////  --  Check status of Orignial Record
		// CREATE RECORD($ptTable->)  //assure that there is not already a duplicate record before doing th
		// EVB_Blob_to_Record (->[SyncRecord]BlobCarrier;$ptTable)
		//   unpack as part of a CronJob
		
		If ($theType=Is alpha field:K8:1)
			$ptField->:=$fieldValue
		Else   //: ($theType=Is LongInt)//9)
			$ptField->:=Abs:C99(Num:C11($fieldValue))
		End if 
		SAVE RECORD:C53($ptTable->)
		
		vResponse:="Processed"
		[SyncRecord:109]dtAction:2:=DateTime_DTTo
		[SyncRecord:109]dtComplete:8:=[SyncRecord:109]dtAction:2
		[SyncRecord:109]statusSend:17:="Unpacked-"+$replaceStatus
		[SyncRecord:109]actionSend:32:="Unpacked-"+$replaceStatus
		SAVE RECORD:C53([SyncRecord:109])
	End if 
End if 