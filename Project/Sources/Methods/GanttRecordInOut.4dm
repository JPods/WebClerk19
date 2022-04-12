//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/05/19, 12:26:25
// ----------------------------------------------------
// Method: GanttRecordInOut
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tableName; $2; $direction)
$tableName:=$1
$direction:=$2
C_POINTER:C301($3; $ptObj)
$ptObj:=$3
C_LONGINT:C283($4; $projectNum)
$projectNum:=0
If (Count parameters:C259>3)
	$projectNum:=$4
End if 
If (Count parameters:C259>4)
	$viSequenceNum:=$5
End if 


Case of 
	: ($tableName="WorkOrder")
		If ($direction="send")
			OB SET:C1220($ptObj->; "id"; "WO-"+String:C10([WorkOrder:66]woNum:29))
			OB SET:C1220($ptObj->; "name"; [WorkOrder:66]name:76)
			OB SET:C1220($ptObj->; "progress"; [WorkOrder:66]flowProgress:87)
			OB SET:C1220($ptObj->; "progressByWorklog"; [WorkOrder:66]flowProgressByWorklog:97)
			OB SET:C1220($ptObj->; "relevance"; 0)  // add
			OB SET:C1220($ptObj->; "type"; [WorkOrder:66]flowType:94)
			OB SET:C1220($ptObj->; "typeID"; [WorkOrder:66]flowTypeid:93)
			OB SET:C1220($ptObj->; "description"; [WorkOrder:66]description:3)
			OB SET:C1220($ptObj->; "code"; [WorkOrder:66]flowCode:95)
			OB SET:C1220($ptObj->; "level"; [WorkOrder:66]flowLevel:96)
			OB SET:C1220($ptObj->; "status"; [WorkOrder:66]action:33)
			OB SET:C1220($ptObj->; "depends"; [WorkOrder:66]flowDepends:89)
			// ### bj ### 20190428_0843
			//  [WorkOrder]DateBegin  should be driving [WorkOrder]DTBeginPlanned
			[WorkOrder:66]dtBeginPlanned:107:=DateTime_Enter([WorkOrder:66]dateBegin:106; [WorkOrder:66]timeBegin:109)
			DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtBeginPlanned:107; ->dtEpochBeginPlan)
			[WorkOrder:66]dtEndPlanned:69:=DateTime_Enter([WorkOrder:66]dateEnd:108; [WorkOrder:66]timeEnd:110)
			DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtEndPlanned:69; ->dtEpochEndPlan)
			OB SET:C1220($ptObj->; "start"; Num:C11(dtEpochBeginPlan))
			OB SET:C1220($ptObj->; "duration"; [WorkOrder:66]durationPlanned:10)  // longint days
			OB SET:C1220($ptObj->; "end"; Num:C11(dtEpochEndPlan))
			
			//  Boolean checkboxes on [WorkOrder] Input page 5
			
			OB SET:C1220($ptObj->; "startIsMilestone"; [WorkOrder:66]flowStartIsMileStone:99)  // boolean
			OB SET:C1220($ptObj->; "endIsMilestone"; [WorkOrder:66]flowEndIsMileStone:100)  // boolean
			OB SET:C1220($ptObj->; "collapsed"; [WorkOrder:66]flowCollapsed:101)
			OB SET:C1220($ptObj->; "canWrite"; [WorkOrder:66]flowCanWrite:98)
			OB SET:C1220($ptObj->; "canAdd"; [WorkOrder:66]flowCanAdd:102)
			OB SET:C1220($ptObj->; "canDelete"; [WorkOrder:66]flowCanDelete:103)
			OB SET:C1220($ptObj->; "canAddIssue"; [WorkOrder:66]flowCanIssue:104)
			ARRAY OBJECT:C1221($aObAssigns; 0)
			
			// OB get array([WorkOrder]ObGantt;"assigs";$aObAssigns)
			
			// extract assigns from the [WorkOrder]ObAssigns
			OB SET ARRAY:C1227($ptObj->; "assigns"; $aObAssigns)
			OB SET:C1220($ptObj->; "hasChild"; [WorkOrder:66]flowHasChildren:88)
		Else 
			C_OBJECT:C1216($voTemp)
			$voTemp:=$ptObj->
			// must have the desired WorkOrder record as the current record or one will be created
			If (Records in selection:C76([WorkOrder:66])=0)
				CREATE RECORD:C68([WorkOrder:66])
				
				[WorkOrder:66]woNum:29:=CounterNew(->[WorkOrder:66])
				[WorkOrder:66]dtCreated:44:=DateTime_Enter
				[WorkOrder:66]actionBy:8:=Current user:C182
				[WorkOrder:66]actionByInitiated:9:=Current user:C182
				[WorkOrder:66]itemNum:12:="FromjQuery"
				[WorkOrder:66]profile1:37:="FromjQuery"
				[WorkOrder:66]projectNum:80:=[Project:24]idNum:1
				// ### bj ### 20191212_1400
				// find how to get this out of the json
				[WorkOrder:66]projectName:112:=[Project:24]attention:27
			End if 
			// ### bj ### 20190428_1817
			// remember the order saved to rebuild in the same order
			[WorkOrder:66]seq:26:=$viSequenceNum
			[WorkOrder:66]name:76:=OB Get:C1224($voTemp; "name")
			[WorkOrder:66]flowProgress:87:=OB Get:C1224($voTemp; "progress")
			[WorkOrder:66]flowProgressByWorklog:97:=OB Get:C1224($voTemp; "progressByWorklog")
			[WorkOrder:66]description:3:=OB Get:C1224($voTemp; "description")
			[WorkOrder:66]flowCode:95:=OB Get:C1224($voTemp; "code")
			[WorkOrder:66]flowLevel:96:=OB Get:C1224($voTemp; "level")
			[WorkOrder:66]action:33:=OB Get:C1224($voTemp; "status")
			[WorkOrder:66]priority:77:=OB Get:C1224($voTemp; "priority")
			
			If (Is new record:C668([WorkOrder:66]))
				[WorkOrder:66]keyTags:82:="jQuery gantt "+[WorkOrder:66]description:3+" "+[WorkOrder:66]action:33+" "+[WorkOrder:66]priority:77
			End if 
			
			[WorkOrder:66]flowDepends:89:=OB Get:C1224($voTemp; "depends")
			C_REAL:C285($epochStart; $epochEnd)
			$epochStart:=OB Get:C1224($voTemp; "start")
			$epochEnd:=OB Get:C1224($voTemp; "end")
			
			// ### bj ### 20190428_0901
			// changing to human readable for easier interfact to gantt charts
			
			// dtEpochPlanned:=String(OB Get($voTemp;"start"))
			dtEpochPlanned:=String:C10($epochStart)
			DateTimeDTEpoch("FromEpoch"; ->[WorkOrder:66]dtBeginPlanned:107; ->dtEpochPlanned)
			jDateTimeRecov([WorkOrder:66]dtBeginPlanned:107; ->[WorkOrder:66]dateBegin:106; ->[WorkOrder:66]timeBegin:109)
			
			// dtEpochEndPlan:=String(OB Get($voTemp;"end"))
			dtEpochEndPlan:=String:C10($epochEnd)
			DateTimeDTEpoch("FromEpoch"; ->[WorkOrder:66]dtEndPlanned:69; ->dtEpochEndPlan)
			jDateTimeRecov([WorkOrder:66]dtEndPlanned:69; ->[WorkOrder:66]dateEnd:108; ->[WorkOrder:66]timeEnd:110)
			
			
			[WorkOrder:66]durationPlanned:10:=OB Get:C1224($voTemp; "duration")
			[WorkOrder:66]flowStartIsMileStone:99:=OB Get:C1224($voTemp; "startIsMilestone")
			[WorkOrder:66]flowEndIsMileStone:100:=OB Get:C1224($voTemp; "endIsMilestone")
			// [WorkOrder]FlowCollapsed:=OB Get($voTemp;"collapsed")
			[WorkOrder:66]flowCanWrite:98:=OB Get:C1224($voTemp; "canWrite")
			[WorkOrder:66]flowCanAdd:102:=OB Get:C1224($voTemp; "canAdd")
			[WorkOrder:66]flowCanDelete:103:=OB Get:C1224($voTemp; "canDelete")
			[WorkOrder:66]flowCanIssue:104:=OB Get:C1224($voTemp; "canAddIssue")
			// zzzqqq jDateTimeStamp(->[WorkOrder:66]comment:17; "GanttParse")
			SAVE RECORD:C53([WorkOrder:66])
			
		End if 
	: ($tableName="Order")
		If (($direction="send") | ($direction="out"))
			
			OB SET:C1220($ptObj->; "id"; "SO-"+String:C10([Order:3]idNum:2))
			OB SET:C1220($ptObj->; "name"; "SO-"+String:C10([Order:3]idNum:2))
			OB SET:C1220($ptObj->; "description"; String:C10([Order:3]total:27)+" "+[Order:3]company:15)
			
			OB SET:C1220($ptObj->; "progress"; 0)
			OB SET:C1220($ptObj->; "type"; "SO")
			OB SET:C1220($ptObj->; "typeID"; 0)
			OB SET:C1220($ptObj->; "code"; "")
			OB SET:C1220($ptObj->; "level"; 11)
			OB SET:C1220($ptObj->; "status"; "STATUS_ACTIVE")
			OB SET:C1220($ptObj->; "depends"; "")
			C_LONGINT:C283($dtStart)
			$dtStart:=DateTime_Enter([Order:3]dateNeeded:5; ?11:11:11?)
			DateTimeDTEpoch("ToEpoch"; ->$dtStart; ->dtEpochBeginPlan)
			dtEpochEndPlan:=String:C10($dtStart+3600000)  // hour
			OB SET:C1220($ptObj->; "start"; $epochStart)
			OB SET:C1220($ptObj->; "end"; $epochEnd)
			
			OB SET:C1220($ptObj->; "duration"; 1)
			
			//  Boolean checkboxes on [WorkOrder] Input page 5
			OB SET:C1220($ptObj->; "progressByWorklog"; False:C215)
			OB SET:C1220($ptObj->; "collapsed"; False:C215)
			OB SET:C1220($ptObj->; "hasChild"; False:C215)
			
			OB SET:C1220($ptObj->; "startIsMilestone"; False:C215)
			OB SET:C1220($ptObj->; "endIsMilestone"; False:C215)
			
			OB SET:C1220($ptObj->; "canWrite"; False:C215)
			OB SET:C1220($ptObj->; "canAdd"; False:C215)
			OB SET:C1220($ptObj->; "canDelete"; False:C215)
			OB SET:C1220($ptObj->; "canAddIssue"; False:C215)
			// $3->:=OB Get
		Else 
			
		End if 
	: ($tableName="PO")
		If (($direction="send") | ($direction="out"))
			
			OB SET:C1220($ptObj->; "id"; "PO-"+[PO:39]id:85)
			OB SET:C1220($ptObj->; "name"; "SO-"+String:C10([PO:39]idNum:5))
			OB SET:C1220($ptObj->; "description"; String:C10([PO:39]total:24)+" "+[PO:39]vendorCompany:39)
			
			OB SET:C1220($ptObj->; "progress"; 0)
			OB SET:C1220($ptObj->; "type"; "SO")
			OB SET:C1220($ptObj->; "typeID"; 0)
			OB SET:C1220($ptObj->; "code"; "")
			OB SET:C1220($ptObj->; "level"; 12)
			OB SET:C1220($ptObj->; "status"; "STATUS_ACTIVE")
			OB SET:C1220($ptObj->; "depends"; "")
			C_LONGINT:C283($dtStart)
			$dtStart:=DateTime_Enter([PO:39]dateNeeded:3; ?11:11:11?)
			DateTimeDTEpoch("ToEpoch"; ->$dtStart; ->dtEpochBeginPlan)
			dtEpochEndPlan:=String:C10($dtStart+3600000)  // hour
			OB SET:C1220($ptObj->; "start"; $epochStart)
			OB SET:C1220($ptObj->; "end"; $epochEnd)
			
			OB SET:C1220($ptObj->; "duration"; 1)
			
			//  Boolean checkboxes on [WorkOrder] Input page 5
			OB SET:C1220($ptObj->; "progressByWorklog"; False:C215)
			OB SET:C1220($ptObj->; "collapsed"; False:C215)
			OB SET:C1220($ptObj->; "hasChild"; False:C215)
			
			OB SET:C1220($ptObj->; "startIsMilestone"; False:C215)
			OB SET:C1220($ptObj->; "endIsMilestone"; False:C215)
			
			OB SET:C1220($ptObj->; "canWrite"; False:C215)
			OB SET:C1220($ptObj->; "canAdd"; False:C215)
			OB SET:C1220($ptObj->; "canDelete"; False:C215)
			OB SET:C1220($ptObj->; "canAddIssue"; False:C215)
			// $3->:=OB Get
		Else 
			
		End if 
End case 