//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/20/02
	//Who: Peter Fleming, Arkware
	//Description: replaced Zip_LoadCitySt with Zip_LoadCitySt_New
	VERSION_960
End if 
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_LONGINT:C283($1)
REDUCE SELECTION:C351([Customer:2]; 0)
REDUCE SELECTION:C351([Lead:48]; 0)
//
//lang:=(WCapi_GetParameter("l";""))

C_TEXT:C284($jitPageOne)
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
CREATE RECORD:C68([Lead:48])
[Lead:48]shipVia:39:=Storage:C1525.default.shipVia
[Lead:48]adSource:27:="WebClerk"
WC_Parse(48; $2)
C_LONGINT:C283($p)
If (([Lead:48]email:33#"") | ([Lead:48]company:5#"") | ([Lead:48]nameFirst:1#"") | ([Lead:48]nameLast:2#"") | ([Lead:48]phone:4#""))
	[Lead:48]dateEntered:21:=Current date:C33
	[Lead:48]email:33:=[Lead:48]email:33
	[Lead:48]terms:40:=<>vWebTerms
	[Lead:48]shipVia:39:=Storage:C1525.default.shipVia
	[Lead:48]typeSale:30:=Storage:C1525.default.typeSale
	//WC_Parse (48;$2)//  
	[Lead:48]individual:31:=([Lead:48]company:5="")
	If (Not:C34([Lead:48]individual:31))
		[Lead:48]company:5:=[Lead:48]nameLast:2+(", "*Num:C11(([Lead:48]nameLast:2#"") & ([Lead:48]nameFirst:1#"")))+[Lead:48]nameFirst:1
	End if 
	Tt_FindByZip(->[Lead:48]zip:10; ->[Lead:48]salesNameID:13; ->[Lead:48]repID:12)
	Zip_LoadCitySt_New(->[Lead:48]zip:10; ->[Lead:48]city:8; ->[Lead:48]state:9; False:C215)
	Find Ship Zone(->[Lead:48]zip:10; ->[Lead:48]zone:42; ->[Lead:48]shipVia:39; ->[Lead:48]country:11; ->[Lead:48]siteID:54)
	If ([Lead:48]idNum:32=0)
		
	End if 
	
	If (Length:C16([Lead:48]state:9)=2)
		[Lead:48]state:9:=Uppercase:C13([Lead:48]state:9)
	End if 
	ParsePhone([Lead:48]phone:4; ->[Lead:48]phone:4; <>tcLocalArea)
	ParsePhone([Lead:48]fax:29; ->[Lead:48]fax:29; <>tcLocalArea)
	[Lead:48]remoteUser:44:=True:C214
	SAVE RECORD:C53([Lead:48])
	
	
	If ([Lead:48]email:33#"")
		vtEmailReceiver:=[Lead:48]email:33
		vtEmailSubject:="Request at "+Storage:C1525.default.company
		vtEmailBody:=vtEmailSubject+"\r"+"\r"+"Your request was received."
		vtEmailBody:=vtEmailBody+"\r"+"\r"+"Thanks you.  Visit us again:  http://"+Storage:C1525.default.domain
		READ ONLY:C145([TallyResult:73])
		QUERY:C277([TallyResult:73]; [TallyResult:73]name:1="WebClerk_NewLead"; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="WebClerk_Auto")
		If (Records in selection:C76([TallyResult:73])=1)
			vtEmailBody:=vtEmailBody+"\r"+"\r"+TagsToText([TallyResult:73]textBlk2:6)
			UNLOAD RECORD:C212([TallyResult:73])
		End if 
		vtEmailPath:=""
		SMTP_SendMsg
	End if 
	
	
	[EventLog:75]tableNum:9:=48
	[EventLog:75]customerRecNum:8:=Record number:C243([Lead:48])
	If ([EventLog:75]idNum:5#0)
		SAVE RECORD:C53([EventLog:75])
	End if 
	//If (<>viDoHttpLog>10)
	//http_SendLog ($1;"/Add lead -> ADDED")
	//End if 
	//
	
	
	$doPage:=WC_DoPage("LeadsOne.html"; $jitPageOne)
	
Else 
	vResponse:=""
	If ([Lead:48]nameFirst:1="")
		vResponse:="Missing first name"+"\r"
	End if 
	If ([Lead:48]nameLast:2="")
		vResponse:=vResponse+"Missing last name"+"\r"
	End if 
	If (([Lead:48]phone:4#"") | ([Lead:48]email:33#""))
		vResponse:=vResponse+"Missing phone or email address"+"\r"
	End if 
	$errtext:=""
	//If (<>viDoHttpLog>10)
	//http_SendLog ($1;"/Add lead -> REJECTED")
	//End if 
	$doPage:=WC_DoPage("Error.html"; "")
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
UNLOAD RECORD:C212([Lead:48])