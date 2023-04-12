//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Execute_TallyMaster
	//Date: 03/11/03
	//Who: Bill
	//Description: 
	//  Paralell to 
	// based on name and purpose
	// This differs slightly from WccExecuteTask called based on name and table number
End if 

C_TEXT:C284($0)
C_TEXT:C284($1; $theRecName; $2; $thePurpose)  //;$2)
C_TEXT:C284($vtSearch; vtTallyMasterReturn)
C_PICTURE:C286($vpSearch)
C_LONGINT:C283($doThis; $securityLevel; $3; viEndUserSecurityLevel)
// C_POINTER($4;$ptTemplate)
C_POINTER:C301($4)
C_BOOLEAN:C305(allowAlerts_boo)  //###_jwm_### 20111019 added to prevent error message in interpreted mode
//
$doThis:=Count parameters:C259

vResponse:=""
// ### bj ### 20200101_2040
vMimeType:=""

//$doThis:=0// FOR TEST ONLY
$securityLevel:=1  //
Case of 
	: (Storage:C1525.user.securityLevel>$securityLevel)
		$securityLevel:=Storage:C1525.user.securityLevel
	: (allowAlerts_boo)
		$securityLevel:=Storage:C1525.user.securityLevel
	: (viEndUserSecurityLevel=0)
		$securityLevel:=1
	Else 
		$securityLevel:=viEndUserSecurityLevel
End case 
If ($doThis<1)
	$theRecName:=""
Else 
	If ($doThis<2)
		$theRecName:=$1
		$thePurpose:="Execute_Tally"
	Else 
		If ($doThis<3)
			$theRecName:=$1
			$thePurpose:=$2
		Else 
			If ($doThis<4)
				$theRecName:=$1
				$thePurpose:=$2
				$securityLevel:=$3
			Else 
				$theRecName:=$1
				$thePurpose:=$2
				$securityLevel:=$3
			End if 
		End if 
	End if 
End if 
If ($doThis>0)
	C_LONGINT:C283($vDuration; vTMLevel)
	//commented out because many reports can take longer than 5 seconds.
	//some timing of this procedure may be worth measuring at some point in time
	//$vDuration:=Milliseconds+5000
	If ($1#"TallyMaster")
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]publish:25>0; *)  // Modified by: williamjames (110516)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=$securityLevel; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$theRecName; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3=$thePurpose)
		// ### bj ### 20200102_1825
		// structure for ajax calls
		Case of 
			: (Records in selection:C76([TallyMaster:60])=0)
				vResponse:="Error: No matching TallyMasters, Name: "+$theRecName+", Purpose: "+$thePurpose+", SecurityLevel: "+String:C10($securityLevel)
				vMimeType:="text/html"
			: (Records in selection:C76([TallyMaster:60])>1)
				vResponse:="Error: Multiple matching TallyMasters, Name: "+$theRecName+", Purpose: "+$thePurpose+", SecurityLevel: "+String:C10($securityLevel)
				vMimeType:="text/html"
			: (Records in selection:C76([TallyMaster:60])=1)
				If (<>viDebugMode>0)
					ConsoleLog("Execute_TallyMaster: "+[TallyMaster:60]name:8+": "+[TallyMaster:60]purpose:3)
				End if 
				If ($doThis=4)
					$4->:=[TallyMaster:60]build:6
				End if 
				C_TEXT:C284($workingText)
				doAlert:=False:C215
				
				C_TEXT:C284($workingText)
				// ### bj ### 20200102_1829
				// REF:   WC_ajaxServer
				//  WC_SendDoc ($socket;$vtPath)
				//  vMimeType:="AlreadySent"
				// call inside of Execute if this is to be an ajax
				
				ExecuteText(0; [TallyMaster:60]script:9; "ExecuteTM Name: "+$theRecName+"; Purpose: "+$thePurpose)
				$0:=vtTallyMasterReturn
				vtTallyMasterReturn:=""
				
				// ### bj ### 20200102_1719 I think this should be deleted or turned into a set
				If ((Records in selection:C76([EventLog:75])=1) & ([TallyMaster:60]tableNum:1>0) & ([TallyMaster:60]tableNum:1<=Get last table number:C254))
					HTTP_QuerySave(Table:C252([TallyMaster:60]tableNum:1))
				End if   // Modified by: williamjames (101226)
				
				UNLOAD RECORD:C212([TallyMaster:60])
				REDUCE SELECTION:C351([TallyMaster:60]; 0)  // ### jwm ### 20160928_1055 clear selection
				
				If ((doAlert) & (vResponse#"") & (allowAlerts_boo))
					ALERT:C41(vResponse)
				End if 
				
		End case 
		
		If (False:C215)  //(Milliseconds>$vDuration)
			Case of 
				: (Record number:C243([EventLog:75])>-1)
					EventLogsMessage("TM: "+$theRecName+", "+$thePurpose+" long query.")
				: (allowAlerts_boo)
					ALERT:C41("TM: "+$theRecName+", "+$thePurpose+" long query.")
			End case 
		End if 
	End if 
End if 
