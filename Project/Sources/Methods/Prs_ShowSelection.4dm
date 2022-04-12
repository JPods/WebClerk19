//%attributes = {"publishedWeb":true}
// ----------------------------------------------------

// User name (OS): williamjames
// Date and time: 09/06/10, 13:13:55
// ----------------------------------------------------
// Method: Prs_ShowSelection
// Description
// 

//assumes <>curSelSet exists or will be managed by branch or script
//
// Parameters
// ----------------------------------------------------
If (Application type:C494#4D Server:K5:6)
	C_LONGINT:C283(<>delayProcessUnload)
	If (<>delayProcessUnload=0)
		<>delayProcessUnload:=30
	End if 
	DELAY PROCESS:C323(Current process:C322; <>delayProcessUnload)  // 
	
	C_LONGINT:C283($viProcess)
	$viProcess:=Current process:C322
	SET MENU BAR:C67(1; $viProcess; *)
	Process_InitLocal
	
	//C_POINTER($5;ptCurTable)
	C_LONGINT:C283($1; seniorProcess; curTableNum; curTableNum)
	C_TEXT:C284($2; $theScript)
	C_LONGINT:C283($3; $setManagement)
	C_TEXT:C284($4; $processName)
	
	seniorProcess:=0
	$theScript:=""
	curTableNum:=Table:C252(<>ptCurTable)
	ptCurTable:=<>ptCurTable
	vWindowTitle:=""  //used in OLO_HereAndMenu to name window title
	$setManagement:=<>prcControl
	If (Count parameters:C259>0)
		seniorProcess:=$1
		If (Count parameters:C259>1)
			$theScript:=$2
			If (Count parameters:C259>2)
				$setManagement:=$3
				If (Count parameters:C259>3)
					vWindowTitle:=$4
					//If (Count parameters>4)
					//ptCurTable:=$5
					//curTableNum:=Table(ptCurTable)
					//End if 
				End if 
			End if 
		End if 
	End if 
	myOK:=0
	If (curTableNum<1)
		curTableNum:=Table:C252(<>ptCurTable)
	End if 
	curTableNum:=curTableNum
	
	
	
	Case of   //<>prcControl below 5 the
		: ($theScript#"")
			myOK:=1  // show a selection or set to zero in script if no records found
			If ($setManagement=12)
				Execute_TallyMaster($theScript)
				//myOK:=1 //must be set within the tallymaster script to zero if conditions 
			Else 
				//<>prcControl=11
				ExecuteText(0; $theScript)
			End if 
		: ($setManagement=3)
			ALL RECORDS:C47(ptCurTable->)
			myOK:=1
			
		: ($setManagement=4)
			USE SET:C118("<>curSelSet")
			CLEAR SET:C117("<>curSelSet")
			myOK:=1
		: ($setManagement=5)
			$setName:="<>set"+Table name:C256(curTableNum)
			USE SET:C118($setName)
			ptCurTable:=Table:C252(curTableNum)
			myOK:=1
		: ($setManagement=6)
			File_Select("Select the file for which you wish to show records.")
			ptCurTable:=Table:C252(curTableNum)
			//myOK:=1  is set based on action in File_Select
		: ($setManagement=7)
			GOTO RECORD:C242(ptCurTable->; <>prcRecordNum)
			<>prcRecordNum:=-1
			myOK:=1
			
		: ($setManagement=8)
			ALL RECORDS:C47(ptCurTable->)
			myOK:=1
		: ($setManagement=21)  //SyncRecord open  SEE oLo SyncRecord
			USE SET:C118("<>curSelSet")
			CLEAR SET:C117("<>curSelSet")
			If (([SyncRecord:109]tableNum:4>0) & ([SyncRecord:109]fieldNum:5>0))
				$tableName:=WccTableName([SyncRecord:109]tableNum:4)
				If ($tableName="")
					ALERT:C41("SyncRecord does not have a valid TableNum.")
				Else 
					$theQuery:=""
					$theQuery:=QueryBuild([SyncRecord:109]tableNum:4; [SyncRecord:109]fieldNum:5; "single"; "literal"; [SyncRecord:109]fieldValue:6)+"\r"+"Query(["+$tableName+"])"
					DB_ShowCurrentSelection(Table:C252([SyncRecord:109]tableNum:4); $theQuery; 4; "ResolveSyn"; 1)
					//ptTable; script; processPathDirect; nameAdder; manageSelection (no change in SyncRecord)
					
					If ([SyncRecord:109]dtComplete:8#0)
						myOK:=0
					Else 
						myOK:=1
						
					End if 
				End if 
			End if 
		: (($setManagement>=201) & ($setManagement<=299))
			USE SET:C118("<>curSelSet")
			CLEAR SET:C117("<>curSelSet")
			myOK:=1
			DEFAULT TABLE:C46([Customer:2])
			Case of 
				: ($setManagement=201)
					FORM SET OUTPUT:C54([Customer:2]; "MfgOut")
					FORM SET INPUT:C55([Customer:2]; "MfgInput")
					jNavPalletPop("General"; "Products"; "Sales")
					jSetMenuNums(15; 17; 16)
					ptCurTable:=(->[Customer:2])
					SET WINDOW TITLE:C213("Manufacturer -"+aPages{1})
				: ($setManagement=202)
					FORM SET OUTPUT:C54([Customer:2]; "oPastDue_9")
				: ($setManagement=203)
					FORM SET INPUT:C55([Customer:2]; "UpdateContacts")
			End case 
			
		Else 
			
			// debug Error "the set does not exist"   // ### jwm ### 20181119_2205
			If (Records in set:C195("<>curSelSet")>0)
				USE SET:C118("<>curSelSet")
				CLEAR SET:C117("<>curSelSet")
			Else 
				ConsoleMessage("Error: SET <>curSelSet is Empty, <>ptCurTable = "+Table name:C256(<>ptCurTable))
			End if 
			
			C_TEXT:C284($setName)
			$setName:="<>set"+Table name:C256(curTableNum)
			CLEAR SET:C117($setName)
			CREATE SET:C116(Table:C252(curTableNum)->; $setName)
			
			myOK:=1
			
	End case 
	<>prcControl:=0  //set variable to release delay on parent process
	If (myOK=1)
		Prs_DisplaySelected
	End if 
End if 