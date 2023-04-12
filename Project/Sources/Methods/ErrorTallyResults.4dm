//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-23T00:00:00, 23:50:26
// ----------------------------------------------------
// Method: ErrorTallyResults
// Description
// Modified: 01/23/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $script; $callingProcedure)
C_LONGINT:C283($3; $dtAware)
$dtAware:=0
If (Count parameters:C259>1)
	$callingProcedure:=$2
	If (Count parameters:C259>2)
		$dtAware:=$3
	End if 
	QUERY:C277([TallyResult:73]; [TallyResult:73]name:1=$1; *)
	If ($dtAware>0)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=DateTime_DTTo(Current date:C33; ?00:00:00?); *)
	End if 
	QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="Admin")
	Case of 
		: (Records in selection:C76([TallyResult:73])>1)
			FIRST RECORD:C50([TallyResult:73])
		: (Records in selection:C76([TallyResult:73])=0)
			CREATE RECORD:C68([TallyResult:73])
			
			[TallyResult:73]dtReport:12:=DateTime_DTTo(Current date:C33; ?00:00:00?)
			[TallyResult:73]purpose:2:="Admin"
			[TallyResult:73]name:1:=$1
	End case 
	If ([TallyResult:73]textBlk2:6#"")
		$script:=[TallyResult:73]textBlk2:6
	Else 
		
		// Modified by: William James (2014-10-01T00:00:00)
		// $script:="[TallyResult]TextBlk1:="+Txt_Quoted (String(Current date)+"; "+String(Current time)+"; "+$callingProcedure)+"\r"+[TallyResult]TextBlk1
	End if 
	ExecuteText(0; $script)
	SAVE RECORD:C53([TallyResult:73])
	REDUCE SELECTION:C351([TallyResult:73]; 0)
End if 