//%attributes = {"publishedWeb":true}
//Method: Http_SaveLead
//
C_LONGINT:C283($1; $3; $recordID)
C_POINTER:C301($2)
C_BOOLEAN:C305($doSearch)
If (Count parameters:C259=2)
	$doSearch:=False:C215
Else 
	$doSearch:=($3=1)
End if 
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
If (($doSearch) & ($recordID#-3))
	REDUCE SELECTION:C351([Lead:48]; 0)
	QUERY:C277([Lead:48]; [Lead:48]idNum:32=$recordID; *)
	Case of 
		: ([RemoteUser:57]securityLevel:4>4999)
		: ([RemoteUser:57]tableNum:9=8)
			QUERY:C277([Lead:48];  & [Lead:48]repID:12=[Rep:8]repID:1; *)
		Else 
			QUERY:C277([Lead:48];  & [Lead:48]salesNameID:13=[Employee:19]nameID:1; *)
	End case 
	QUERY:C277([Lead:48])
End if 
//
TRACE:C157
$doLead:=True:C214
Case of 
	: ($recordID=-3)
		$doLead:=True:C214
		CREATE RECORD:C68([Lead:48])
	: (Record number:C243([Lead:48])=-1)
		$doLead:=False:C215
	: (Record number:C243([Lead:48])>-1)
		LOAD RECORD:C52([Lead:48])
		If (Locked:C147([Lead:48]))
			CREATE RECORD:C68([TempRec:55])
			[TempRec:55]dataField:7:=$2->
			[TempRec:55]tableNum:1:=Table:C252(->[Lead:48])
			[TempRec:55]action:5:="Http_DelayParse"
			[TempRec:55]recordNumOrig:2:=Record number:C243([Lead:48])
			[TempRec:55]purpose:6:=1
			[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
			SAVE RECORD:C53([TempRec:55])
			vResponse:=vResponse+"Lead Locked, delayed posting."+"\r"
			EventLogsMessage("Posted Lead "+String:C10([Lead:48]idNum:32))
			If ([EventLog:75]idNum:5#0)
				SAVE RECORD:C53([EventLog:75])
			End if 
			$doLead:=False:C215
		Else 
			$doLead:=True:C214
		End if 
End case 
//
If ($doLead)
	vText10:=$2->
	WC_Parse(Table:C252(->[Lead:48]); ->vText10)
	EventLogsMessage("Posted Lead "+String:C10([Lead:48]idNum:32))
	If ([EventLog:75]idNum:5#0)
		SAVE RECORD:C53([EventLog:75])
	End if 
End if 