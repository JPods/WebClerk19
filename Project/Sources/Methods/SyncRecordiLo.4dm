//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 14:57:46
// ----------------------------------------------------
// Method: SyncRecordiLo
// Description
// Modified: 03/28/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// ### bj ### 20200330_2237 fixed ActionReceived on first page
// added command to process and page 2

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Load:K2:1)
	If (UserInPassWordGroup("Sync"))
		// in group
	Else 
		ALERT:C41("Not in Sync Password Group.")
		CANCEL:C270
		$formEvent:=On Unload:K2:2
	End if 
End if 
Case of 
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
	: ($formEvent=On Load:K2:1)
		booAccept:=True:C214
		$formEvent:=iLoProcedure(->[SyncRecord:109])
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([SyncRecord:109]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
			
			//
			C_LONGINT:C283($formEvent)
			
			//
			$doMore:=False:C215
			Case of 
				: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
					
					
				: (iLoRecordNew)  //set in iLoProcedure only once, new record
					
					$doMore:=True:C214
				: (iLoRecordChange)  //set in iLoProcedure only once, existing record
					
					$doMore:=True:C214
			End case 
		End if 
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SynRecords"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=Storage:C1525.user.securityLevel; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=[SyncRecord:109]tableNum:4)
		SELECTION TO ARRAY:C260([TallyMaster:60]name:8; aiSIvcProcess)
		SORT ARRAY:C229(aiSIvcProcess)
		//INSERT ELEMENT($ptArray->;1;1)
		//$ptArray->{1}:="Help-"+Table name($1)
		INSERT IN ARRAY:C227(aiSIvcProcess; 1; 1)
		aiSIvcProcess{1}:="Replace Original"
		INSERT IN ARRAY:C227(aiSIvcProcess; 1; 1)
		aiSIvcProcess{1}:="Keep Original"
		INSERT IN ARRAY:C227(aiSIvcProcess; 1; 1)
		If (([SyncRecord:109]tableNum:4>0) & ([SyncRecord:109]tableNum:4<=Get last table number:C254))
			aiSIvcProcess{1}:="Resolve Options-"+Table name:C256([SyncRecord:109]tableNum:4)
		Else 
			aiSIvcProcess{1}:="No TableNum to Resolve Options"
		End if 
		aiSIvcProcess:=1
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
End case 
If (<>aLastRecNum{Table:C252(ptCurTable)}#curRecNum)
	$doMore:=True:C214
	curRecNum:=Record number:C243(ptCurTable->)
	//remember the current record number to avoid reloading details
	<>aLastRecNum{Table:C252(ptCurTable)}:=curRecNum
End if 
If ($doMore)  //action for the form regardless of new or existing record
	
	If ([SyncRecord:109]dtComplete:8=0)
		OBJECT SET ENABLED:C1123(b3; True:C214)  //Resolve button
	Else 
		OBJECT SET ENABLED:C1123(b3; False:C215)  //Resolve button
	End if 
	
	
	DateTime_DTFrom([SyncRecord:109]dtAction:2; ->iLoDate1; ->iLoTime1)
	DateTime_DTFrom([SyncRecord:109]dtComplete:8; ->iLoDate2; ->iLoTime2)
	DateTime_DTFrom([SyncRecord:109]dtCreated:15; ->iLoDate3; ->iLoTime3)
	Before_New(ptCurTable)  //last thing to do
End if 
//every cycle

booAccept:=True:C214
