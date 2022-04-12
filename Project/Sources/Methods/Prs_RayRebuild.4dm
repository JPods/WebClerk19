//%attributes = {"publishedWeb":true}
//Procedure: Prs_RayRebuild

// why are we rebuilding POP Ups when saving a TallyMaster ?
KeyModifierCurrent
If ((ShftKey=1) & (OptKey=1) & (CmdKey=1))  // ### jwm ### 20160318_1510 was running every time when saving with command+S
	//Storage.folder.jitF:=Application file//get the app
	//<>vlOnCD:=Get_FileLocked (Storage.folder.jitF)//check if locked
	QUERY:C277([PopUp:23]; [PopUp:23]arrayName:3="aActions")
	If (Records in selection:C76([PopUp:23])>0)
		PUSH RECORD:C176([PopUp:23])
		QUERY:C277([PopUp:23]; [PopUp:23]arrayName:3="<>aActions")
		If (Records in selection:C76([PopUp:23])>0)
			POP RECORD:C177([PopUp:23])
			DELETE RECORD:C58([PopUp:23])
		Else 
			POP RECORD:C177([PopUp:23])
			[PopUp:23]arrayName:3:="<>aActions"
			SAVE RECORD:C53([PopUp:23])
		End if 
	End if 
	jNewCoSetups
End if 



jsetChArrays

MESSAGES OFF:C175
If (False:C215)
	ARRAY TEXT:C222(<>aSchedOpt; 0)
	READ ONLY:C145([UserReport:46])
	QUERY:C277([UserReport:46]; [UserReport:46]creator:6="ScOp")
	SELECTION TO ARRAY:C260([UserReport:46]name:2; <>aSchedOpt)
	INSERT IN ARRAY:C227(<>aSchedOpt; 1; 1)
	<>aSchedOpt{1}:="Schedule Opt"
	REDUCE SELECTION:C351([UserReport:46]; 0)
	READ WRITE:C146([UserReport:46])
Else 
	
	ARRAY TEXT:C222(<>aSchedOpt; 0)
	READ ONLY:C145([TallyMaster:60])
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="ScheduleOptions")
	SELECTION TO ARRAY:C260([TallyMaster:60]name:8; <>aSchedOpt)
	INSERT IN ARRAY:C227(<>aSchedOpt; 1; 1)
	<>aSchedOpt{1}:="ScheduleOptions"
	REDUCE SELECTION:C351([TallyMaster:60]; 0)
	READ WRITE:C146([TallyMaster:60])
End if 
//
If (False:C215)
	ARRAY TEXT:C222(<>aServOpt; 0)
	READ ONLY:C145([UserReport:46])
	QUERY:C277([UserReport:46]; [UserReport:46]creator:6="MySv")
	SELECTION TO ARRAY:C260([UserReport:46]name:2; <>aServOpt)
	INSERT IN ARRAY:C227(<>aServOpt; 1; 1)
	<>aServOpt{1}:="Service Opts"
	REDUCE SELECTION:C351([UserReport:46]; 0)
	READ WRITE:C146([UserReport:46])
Else 
	ARRAY TEXT:C222(<>aServOpt; 0)
	READ ONLY:C145([TallyMaster:60])
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="ServiceOptions")
	SELECTION TO ARRAY:C260([TallyMaster:60]name:8; <>aServOpt)
	INSERT IN ARRAY:C227(<>aServOpt; 1; 1)
	<>aServOpt{1}:="ServiceOptions"
	REDUCE SELECTION:C351([TallyMaster:60]; 0)
	READ WRITE:C146([TallyMaster:60])
End if 
//
ARRAY TEXT:C222(<>aWoTypes; 0)
READ ONLY:C145([WOTemplate:69])
ALL RECORDS:C47([WOTemplate:69])
DISTINCT VALUES:C339([WOTemplate:69]typeWO:9; <>aWoTypes)
REDUCE SELECTION:C351([WOTemplate:69]; 0)
READ WRITE:C146([WOTemplate:69])
INSERT IN ARRAY:C227(<>aWoTypes; 1; 1)
<>aWoTypes{1}:="Wo Type"
//
ARRAY TEXT:C222(<>aQATypes; 0)
READ ONLY:C145([QAQuestion:71])
ALL RECORDS:C47([QAQuestion:71])
DISTINCT VALUES:C339([QAQuestion:71]questionType:2; <>aQATypes)
REDUCE SELECTION:C351([QAQuestion:71]; 0)
READ WRITE:C146([QAQuestion:71])
INSERT IN ARRAY:C227(<>aQATypes; 1; 1)
<>aQATypes{1}:="Question Types"
//
ARRAY TEXT:C222(<>aLtrsCust; 0)
READ ONLY:C145([Letter:20])
QUERY:C277([Letter:20]; [Letter:20]tableNum:8=2; *)
QUERY:C277([Letter:20];  & [Letter:20]active:7=True:C214)
SELECTION TO ARRAY:C260([Letter:20]name:1; <>aLtrsCust)
REDUCE SELECTION:C351([Letter:20]; 0)
READ WRITE:C146([Letter:20])
INSERT IN ARRAY:C227(<>aLtrsCust; 1; 1)
<>aLtrsCust{1}:="Letters"
//
ARRAY TEXT:C222(<>aLtrsLead; 0)
READ ONLY:C145([Letter:20])
QUERY:C277([Letter:20]; [Letter:20]tableNum:8=48; *)
QUERY:C277([Letter:20];  & [Letter:20]active:7=True:C214)
SELECTION TO ARRAY:C260([Letter:20]name:1; <>aLtrsLead)
REDUCE SELECTION:C351([Letter:20]; 0)
READ WRITE:C146([Letter:20])
INSERT IN ARRAY:C227(<>aLtrsLead; 1; 1)
<>aLtrsCust{1}:="Letters"
MESSAGES ON:C181
//

ARRAY TEXT:C222(<>aCrewConfigs; 0)
READ ONLY:C145([TallyMaster:60])
QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SchedulerCrews")
SELECTION TO ARRAY:C260([TallyMaster:60]name:8; <>aCrewConfigs)
INSERT IN ARRAY:C227(<>aCrewConfigs; 1; 1)
<>aCrewConfigs{1}:="Crew Options"
REDUCE SELECTION:C351([TallyMaster:60]; 0)
READ WRITE:C146([TallyMaster:60])
//
//

setTypeSalePopu  //after defaults
setCurrencyRay  //after defaults




