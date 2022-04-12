//%attributes = {"publishedWeb":true}
//Procedure: Prs_OutsideCall
C_BOOLEAN:C305(<>vbInActive; <>vbDoQuit)
C_LONGINT:C283(<>vlRecNum; $inc; $cnt)
Case of 
	: (<>prcControl=401)
		ARRAY LONGINT:C221(<>aSummaryRecords; 0)
		$cnt:=Records in selection:C76(ptCurTable->)
		If ($cnt>10)
			$cnt:=10
		End if 
		FIRST RECORD:C50(ptCurTable->)
		For ($inc; 1; $cnt)
			APPEND TO ARRAY:C911(<>aSummaryRecords; Record number:C243(ptCurTable->))
			NEXT RECORD:C51(ptCurTable->)
		End for 
		UNLOAD RECORD:C212(ptCurTable->)
		<>prcControl:=0
	: (<>prcControl=301)
		<>prcControl:=0
		DELAY PROCESS:C323(Current process:C322; 30)
		jReloadRecord
	: (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
		Quit_Processes
	: (<>vlRecNum>0)  //Pop a new record into existing process
		jSaveRecord
		GOTO RECORD:C242(<>ptCurTable->; <>vlRecNum)
		booPreNext:=True:C214
		POST KEY:C465(9; 0)
		<>vlRecNum:=0
	: (<>vbInActive)
		jCancelButton
		<>vbInActive:=False:C215
End case 