//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/19/08, 20:07:42
// ----------------------------------------------------
// Method: Http_ModLead
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $3; $recordID)
C_POINTER:C301($2)

C_LONGINT:C283($recordID)
C_TEXT:C284($doPage; $suffix)
vResponse:="No access to Mod Leads"
$suffix:=""
$doPage:=WC_DoPage("Error.html"; "")
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
$jitPageOne:=WCapi_GetParameter("$jitPageOne"; "")
$doAction:=True:C214
Case of 
	: (vWccTableNum=(Table:C252(->[Rep:8])))
		GOTO RECORD:C242([Rep:8]; [EventLog:75]customerRecNum:8)
		$theAcct:=[Rep:8]repID:1
		$doRep:=True:C214
	: (vWccTableNum=(Table:C252(->[Rep:8])))
		GOTO RECORD:C242([Employee:19]; [EventLog:75]customerRecNum:8)
		$theAcct:=[Employee:19]nameID:1
		$doRep:=False:C215
	Else 
		$doAction:=False:C215
End case 
If (($doAction) & ($recordID>0))
	QUERY:C277([Lead:48]; [Lead:48]idNum:32=$recordID; *)
	Case of 
		: ([RemoteUser:57]securityLevel:4>4999)
		: ($doRep)
			QUERY:C277([Lead:48];  & [Lead:48]repID:12=$theAcct)
		Else 
			QUERY:C277([Lead:48];  & [Lead:48]salesNameID:13=$theAcct)
	End case 
	QUERY:C277([Lead:48])
	If (Records in selection:C76([Lead:48])=1)
		QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=48; *)
		QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=String:C10([Lead:48]idNum:32); *)
		QUERY:C277([CallReport:34];  & [CallReport:34]complete:7=False:C215)
		PUSH RECORD:C176([RemoteUser:57])
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]customerID:10=String:C10([Lead:48]idNum:32); *)
		QUERY:C277([RemoteUser:57];  & [RemoteUser:57]tableNum:9=48)
		If (Records in selection:C76([RemoteUser:57])=0)
			RemoteUser_Create(->[Lead:48]; "L"+String:C10([Lead:48]idNum:32)+Txt_RandomString(5; "a"; "z"); [Lead:48]zip:10; 1)
		End if 
		If (<>doeventID)
			vInAsCustomer:="<A HREF="+"\""+"/search_user?userName="+[RemoteUser:57]userName:2+"&Password="+[RemoteUser:57]userPassword:3+"&jitUser="+String:C10(vleventID)+"\""+">Sign-in As Customer</A>"
		Else 
			vInAsCustomer:="<A HREF="+Txt_Quoted("/search_user?userName="+[RemoteUser:57]userName:2+"&Password="+[RemoteUser:57]userPassword:3)+">Sign-in As Customer</A>"
		End if 
		POP RECORD:C177([RemoteUser:57])
		$doPage:=WC_DoPage("LeadMod"+$suffix+".html"; $jitPageOne)
	Else 
		vResponse:="Lead Record does not exist or not assigned to you."+"\r"
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)