//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/17/10, 14:28:07
// ----------------------------------------------------
// Method: Prs_ShowReport
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (Application type:C494#4D Server:K5:6)
	C_LONGINT:C283($viProcess)
	$viProcess:=Current process:C322
	SET MENU BAR:C67(1; $viProcess; *)
	Process_InitLocal
	C_POINTER:C301($ptReportOnTable)
	C_POINTER:C301($1)
	C_LONGINT:C283(seniorProcess; $2)
	C_LONGINT:C283($recordNumUserReport; $3)
	curTableNum:=Table:C252($1)
	$ptReportOnTable:=$1
	seniorProcess:=$2
	$recordNumUserReport:=$3
	myOK:=0
	
	//USE SET("<>curReportSet")
	//CLEAR SET("<>curReportSet")
	// Is this redundant already in ilo prodedure ???
	// ### jwm ### 20140827_1536 
	// Named selections preserve in memory the order of the selection and the current record of the selection.
	
	// Not needed Here executed in UserReport_iloProcedure
	// USE NAMED SELECTION("<>curReportSet")
	// CLEAR NAMED SELECTION("<>curReportSet"
	
	<>prcControl:=0
	//  If (File(ptCurFile)=curTableNum)//must force this 
	iLoPagePopUpMenuBar(->[UserReport:46])
	//  End if 
	$fia:=Size of array:C274(<>aPrsName)
	<>aPrsName{$fia}:=Substring:C12(<>aPrsName{$fia}+"-"+Table name:C256(<>ptCurTable); 1; 20)
	//Process_Running 
	//WindowOpenTaskOffSets 
	
	// ### jwm ### 20190709_1600 open input layout to edit report
	$Ref:=Open form window:C675([UserReport:46]; "Input"; 8; *)  // ### jwm ### 20181210_1401 use open Form Window to save geometry
	
	
	//Open window(4;40;635;475;8)
	//$ptReportOnTable:=ptCurTable
	If ($recordNumUserReport=-3)
		ADD RECORD:C56([UserReport:46])
	Else 
		//  rptLineCnt:=P_SetReps 
		GOTO RECORD:C242([UserReport:46]; $recordNumUserReport)
		MODIFY SELECTION:C204([UserReport:46])
	End if 
	POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
End if 