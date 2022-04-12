//%attributes = {"publishedWeb":true}
//Method: Http_SaveContac
C_LONGINT:C283($1; $3)
C_POINTER:C301($2)
C_BOOLEAN:C305($doSearch)
C_TEXT:C284($recordID)
If (Count parameters:C259=2)
	$doSearch:=False:C215
Else 
	$doSearch:=($3=1)
End if 
REDUCE SELECTION:C351([Contact:13]; 0)
If ($doSearch)
	$recordID:=WCapi_GetParameter("RecordID"; "")
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=$recordID; *)
	Case of 
		: (vWccSecurity>4999)
		: (vWccTableNum=8)
			QUERY:C277([Contact:13];  & [Contact:13]repID:45=[Rep:8]repID:1; *)
		: (vWccTableNum=19)
			QUERY:C277([Contact:13];  & [Contact:13]salesNameID:39=[Employee:19]nameID:1; *)
	End case 
	QUERY:C277([Contact:13])
End if 
//
TRACE:C157
If (Record number:C243([Contact:13])>-1)
	LOAD RECORD:C52([Contact:13])
	If (Locked:C147([Contact:13]))
		CREATE RECORD:C68([TempRec:55])
		[TempRec:55]dataField:7:=$2->
		[TempRec:55]tableNum:1:=Table:C252(->[Contact:13])
		[TempRec:55]action:5:="Http_DelayParse"
		[TempRec:55]recordNumOrig:2:=Record number:C243([Contact:13])
		[TempRec:55]purpose:6:=1
		[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
		SAVE RECORD:C53([TempRec:55])
		vResponse:=vResponse+"Contact Locked, delayed posting."+"\r"
	Else 
		vText10:=$2->
		WC_Parse(Table:C252(->[Contact:13]); ->vText10)
		vResponse:="Contact record saved."
	End if 
	EventLogsMessage("Posted Contact "+String:C10([Contact:13]idNum:28))
	If ([EventLog:75]idNum:5#0)
		SAVE RECORD:C53([EventLog:75])
	End if 
Else 
	vResponse:=vResponse+"No Contact Record."+"\r"
End if 