//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2014-10-21T00:00:00, 14:05:04
// ----------------------------------------------------
// Method: ProcessTableQuery
// Description
// Modified: 10/21/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// $childProcess:=ProcessTableQuery (Current process;$vtScript;$vtEventName;$viTableNum;True;True)


C_LONGINT:C283($1; seniorProcess; $curTable)
C_TEXT:C284($2; $theScript)
C_TEXT:C284($3)  //  vWindowTitle
C_LONGINT:C283($tableNum; $4)
C_LONGINT:C283($viProcess)
C_BOOLEAN:C305($displayTrue; $5; $multiThread; $6; $vbExecute)  // added a parameter to skip display, allow mutliple processess
//set in previous process. Need to shift it to being passed.  Fixthis.
$viProcess:=Current process:C322
SET MENU BAR:C67(1; $viProcess; *)
Process_InitLocal

$curTable:=-1
seniorProcess:=0
$seniorProcess:=0
$displayTrue:=True:C214  // default display records = true
$multiThread:=False:C215  // default allow multiple copies of same process = False




If (Count parameters:C259>0)
	seniorProcess:=$1
	$seniorProcess:=$1
	If (Count parameters:C259>1)
		$theScript:=$2
		If (Count parameters:C259>2)
			vWindowTitle:=$3
			If (Count parameters:C259>3)
				//If (($4>0) & ($4<=Get last table number))  //Is table number valid
				If (Is table number valid:C999($4))  // ### jwm ### 20190626_0944
					$curTable:=$4
					$ptTable:=Table:C252($curTable)  //### jwm ### 20131023_1121
				End if 
				If (Count parameters:C259>4)
					$displayTrue:=$5
					If (Count parameters:C259>5)
						$multiThread:=$6  // ### jwm ### 20170508_1524 check [CronJob]MultipleThread
					End if 
				End if 
			End if 
		End if 
	End if 
End if 


If ($curTable<1)
	$curTable:=Table:C252(<>ptCurTable)
	$ptTable:=Table:C252($curTable)
End if 
ptCurTable:=$ptTable
var $tableName : Text
$tableName:=Table name:C256($ptTable)
myOK:=0
If (<>vWindowTitle#"")
	vWindowTitle:=<>vWindowTitle
	<>vWindowTitle:=""
End if 

// Check if mutiple processess are allowed
$vbExecute:=False:C215
If ($multiThread)  // allow multiples of the same process
	$vbExecute:=True:C214
Else 
	$found:=Prs_CheckRunnin([CronJob:82]eventName:15)  // check for running process
	If ($found=0)  // if process is not currently running
		$vbExecute:=True:C214
	End if 
End if 

If ($vbExecute)
	ExecuteText(0; $theScript)
End if 

// Modified by: Bill James (2014-10-21T00:00:00 Subrecord eliminated)
// Added a 5th parameter to skip the display
// ### bj ### 20181229_0001
<>prcControl:=0  //release the calling process
// ### jwm ### 20190625_1548 allow display of zero records
If (allowAlerts_boo)  //& ($displayTrue) & ((Records in selection($ptTable->)>0) | ($multiThread=True)))  // ### jwm ### 20170508_1515 records > 0
	
	MESSAGES OFF:C175
	///QQQ
	var process_o : Object
	process_o:=New object:C1471("ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"tableName"; ""; \
		"tableForm"; ""; \
		"form"; ""; \
		"entsOther"; New object:C1471("tableName"; New object:C1471); \
		"process"; Current process:C322; \
		"inputs"; New object:C1471("tableName"; $tableName; \
		"script"; "$theScript"; \
		"title"; vWindowTitle; \
		"processParent"; seniorProcess; \
		"display"; $displayTrue; \
		"multiThread"; $multiThread))
	
	var $form_t : Text
	$form_t:="Output"
	var $obWindows : Object
	$obWindows:=WindowCountToShow
	$win_l:=Open form window:C675($ptTable->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	process_o.window:=$win_l
	
	
Else 
	If ((<>VIDEBUGMODE>=411) & (Records in selection:C76($ptTable->)>0))  // ### jwm ### 20190625_1548
		ConsoleMessage("Zero records in selection "+Table name:C256($ptTable))
	End if 
End if 

If ($seniorProcess>0)
	POST OUTSIDE CALL:C329($seniorProcess)
End if 
POST OUTSIDE CALL:C329(<>theProcessList)
tableNumProcess:=0
tableNumParent:=0
MESSAGES ON:C181
