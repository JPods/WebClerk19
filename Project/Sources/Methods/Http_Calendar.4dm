//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $err; $orderNum; $trackNum; $ppNum; $k)
C_POINTER:C301($2)
//
C_BOOLEAN:C305($doError; $doRep)
C_TEXT:C284($begDateStr; $calendarMon)
C_TEXT:C284($endDateStr)
C_DATE:C307($begDate; $endDate)
C_BOOLEAN:C305($OpenOnly)
C_TEXT:C284($theAcct; $repID; $salesNameID)
//C_TEXT(
pvNameFirst:=""
pvNameLast:=""
pvZip:=""
pvPhone:=""
//
$doError:=True:C214
$suffix:=""

If (vWccTableNum>-1)
	READ ONLY:C145([RemoteUser:57])
	READ ONLY:C145([Customer:2])
	//GOTO RECORD([RemoteUser];[EventLog]WccPrimeUserRec)
	Case of 
		: (vWccTableNum=(Table:C252(->[Rep:8])))
			If ((vWccSecurity>=1000) & ([Rep:8]repIDGroup:45#""))
				$repID:=[Rep:8]repIDGroup:45+"@"
				$theAcct:=[Rep:8]repIDGroup:45+"@"
			Else 
				$repID:=[Rep:8]RepID:1
				$theAcct:=[Rep:8]RepID:1
			End if 
			$doRep:=True:C214
		: (vWccTableNum=(Table:C252(->[Employee:19])))
			//GOTO RECORD([Employee];vWccPrimeRec)
			$salesNameID:=[Employee:19]nameID:1
			$theAcct:=[Employee:19]nameID:1
			$doRep:=False:C215
	End case 
	C_TEXT:C284(webCalendar)
	$calendarMon:=WCapi_GetParameter("calendarMonth"; "")
	C_TEXT:C284(webCalendar)
	Case of 
		: ($calendarMon="None")
			webCalendar:=""
		: ($calendarMon="")
			webCalendar:=http_CalendarBu(Current date:C33)
		Else 
			webCalendar:=http_CalendarBu(Date:C102(Substring:C12($calendarMon; 1; 2)+"/1/"+Substring:C12($calendarMon; 3; 4)))
	End case 
	webCalendar:=Replace string:C233(webCalendar; "vleventID"; String:C10(vleventID))  //added to put refs into the output    
	C_BOOLEAN:C305($OpenOnly; $DoDate; $LeadTable; $CustTable; $ServTable; $ConTable; $CallTable)
	C_TEXT:C284($company; pvNameFirst; pvNameLast; $customerID)
	//TRACE
	pvPageReturn:=WCapi_GetParameter("jitPageReturn"; "")
	pvRecordReturn:=WCapi_GetParameter("RecordReturn"; "")
	pvTableReturn:=WCapi_GetParameter("TableReturn"; "")
	pvTaskReturn:=WCapi_GetParameter("TaskReturn"; "")
	//
	$jitPageList:=WCapi_GetParameter("jitPageList"; "")
	$begDateStr:=WCapi_GetParameter("dateBegin"; "")
	$endDateStr:=WCapi_GetParameter("dateEnd"; "")
	$OpenOnly:=(WCapi_GetParameter("OpenOnly"; "")="true")
	$doDate:=(WCapi_GetParameter("DoDate"; "")="true")
	$company:=WCapi_GetParameter("Company"; "")
	pvNameFirst:=WCapi_GetParameter("FirstName"; "")
	pvNameLast:=WCapi_GetParameter("LastName"; "")
	pvZip:=WCapi_GetParameter("Zip"; "")
	pvPhone:=WCapi_GetParameter("Phone"; "")
	$customerID:=WCapi_GetParameter("customerID"; "")
	$LeadTable:=(WCapi_GetParameter("LeadTable"; "")="true")
	$CustTable:=(WCapi_GetParameter("CustomerTable"; "")="true")
	$ServTable:=(WCapi_GetParameter("ServiceTable"; "")="true")
	$ConTable:=(WCapi_GetParameter("ContactTable"; "")="true")
	$CallTable:=(WCapi_GetParameter("CallReportTable"; "")="true")
	If ($doDate)
		If ($begDateStr="")
			$begDate:=Current date:C33-2
		Else 
			$begDate:=Date_GoFigure($begDateStr)
		End if 
		If ($endDateStr="")
			$endDate:=Current date:C33+5
		Else 
			$endDate:=Date_GoFigure($endDateStr)
		End if 
		C_LONGINT:C283($dtBegin; $dtEnd)
		$dtBegin:=DateTime_Enter($begDate; ?00:00:00?)
		$dtEnd:=DateTime_Enter($endDate; ?23:59:59?)
	End if 
	Case of 
		: (vWccSecurity>4999)
			If ($CustTable)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1#""; *)  //wide open search  
			End if 
			If ($ConTable)
				QUERY:C277([Contact:13]; [Contact:13]idNum:28>0; *)
			End if 
			If ($LeadTable)
				QUERY:C277([zzzLead:48]; [zzzLead:48]idNum:32>0; *)
			End if 
			If ($ServTable)
				QUERY:C277([Service:6]; [Service:6]idNum:26>0; *)
			End if 
		: (vWccTableNum=(Table:C252(->[Rep:8])))
			WccRelateRecords(->[Rep:8])
			If (False:C215)
				If ($CustTable)
					QUERY:C277([Customer:2]; [Customer:2]repID:58=[Rep:8]RepID:1; *)
				End if 
				If ($ConTable)
					QUERY:C277([Contact:13]; [Contact:13]repID:45=[Rep:8]RepID:1; *)
				End if 
				If ($LeadTable)
					QUERY:C277([zzzLead:48]; [zzzLead:48]repID:12=[Rep:8]RepID:1; *)
				End if 
				If ($ServTable)
					QUERY:C277([Service:6]; [Service:6]repID:2=[Rep:8]RepID:1; *)
				End if 
			End if 
		: (vWccTableNum=(Table:C252(->[Employee:19])))
			If ($CustTable)
				QUERY:C277([Customer:2]; [Customer:2]salesNameID:59=[Employee:19]nameID:1; *)
			End if 
			If ($ConTable)
				QUERY:C277([Contact:13]; [Contact:13]salesNameID:39=[Employee:19]nameID:1; *)
			End if 
			If ($LeadTable)
				QUERY:C277([zzzLead:48]; [zzzLead:48]salesNameID:13=[Employee:19]nameID:1; *)
			End if 
			If ($ServTable)
				QUERY:C277([Service:6]; [Service:6]actionBy:12=[Employee:19]nameID:1; *)
			End if 
	End case 
	$suffix:=""
	$doError:=False:C215
	READ ONLY:C145([CallReport:34])
	READ ONLY:C145([Service:6])
	READ ONLY:C145([Customer:2])
	READ ONLY:C145([zzzLead:48])
	READ ONLY:C145([Contact:13])
	//        
	C_LONGINT:C283($startSrch)
	If ($CustTable)
		If ($doDate)
			QUERY:C277([Customer:2];  & [Customer:2]actionDate:61>=$begDate; *)
			QUERY:C277([Customer:2];  & [Customer:2]actionDate:61<=$endDate; *)
		End if 
		If ($company#"")
			QUERY:C277([Customer:2];  & [Customer:2]company:2=$company+"@"; *)
		End if 
		If (pvNameFirst#"")
			QUERY:C277([Customer:2];  & [Customer:2]nameFirst:73=pvNameFirst+"@"; *)
		End if 
		If (pvNameLast#"")
			QUERY:C277([Customer:2];  & [Customer:2]nameLast:23=pvNameLast+"@"; *)
		End if 
		If (pvZip#"")
			QUERY:C277([Customer:2];  & [Customer:2]zip:8=pvZip+"@"; *)
		End if 
		If (pvPhone#"")
			QUERY:C277([Customer:2];  & [Customer:2]phone:13=pvPhone+"@"; *)
		End if 
		If ($customerID#"")
			QUERY:C277([Customer:2];  & [Customer:2]customerID:1=$customerID+"@"; *)
		End if 
		If ($repID#"")
			QUERY:C277([Customer:2];  & [Customer:2]repID:58=$repID; *)
		End if 
		If ($salesNameID#"")
			QUERY:C277([Customer:2];  & [Customer:2]salesNameID:59=$salesNameID; *)
		End if 
		QUERY:C277([Customer:2])
		If (Records in selection:C76([Customer:2])>1)
			ORDER BY:C49([Customer:2]; [Customer:2]actionDate:61)
			If (Records in selection:C76([Customer:2])><>viMaxShow)
				REDUCE SELECTION:C351([Customer:2]; <>viMaxShow)
				$num:=Records in selection:C76([Customer:2])
			End if 
		End if 
	End if 
	//
	If ($ConTable)
		If ($doDate)
			QUERY:C277([Contact:13];  & [Contact:13]actionDate:33>=$begDate; *)
			QUERY:C277([Contact:13];  & [Contact:13]actionDate:33<=$endDate; *)
		End if 
		If ($company#"")
			QUERY:C277([Contact:13];  & [Contact:13]company:23=$company+"@"; *)
		End if 
		If (pvNameFirst#"")
			QUERY:C277([Contact:13];  & [Contact:13]nameFirst:2=pvNameFirst+"@"; *)
		End if 
		If (pvNameLast#"")
			QUERY:C277([Contact:13];  & [Contact:13]nameLast:4=pvNameLast+"@"; *)
		End if 
		If (pvZip#"")
			QUERY:C277([Contact:13];  & [Contact:13]zip:11=pvZip+"@"; *)
		End if 
		If (pvPhone#"")
			QUERY:C277([Contact:13];  & [Contact:13]phone:30=pvPhone+"@"; *)
		End if 
		If ($customerID#"")
			QUERY:C277([Contact:13];  & [Contact:13]customerID:1=$customerID+"@"; *)
		End if 
		If ($repID#"")
			QUERY:C277([Contact:13];  & [Contact:13]repID:45=$repID; *)
		End if 
		If ($salesNameID#"")
			QUERY:C277([Contact:13];  & [Contact:13]salesNameID:39=$salesNameID; *)
		End if 
		QUERY:C277([Contact:13])
		If (Records in selection:C76([Contact:13])>1)
			ORDER BY:C49([Contact:13]; [Contact:13]actionDate:33)
			If (Records in selection:C76([Contact:13])><>viMaxShow)
				REDUCE SELECTION:C351([Contact:13]; <>viMaxShow)
				$num:=Records in selection:C76([Contact:13])
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($startSrch)
	If ($LeadTable)
		If ($doDate)
			QUERY:C277([zzzLead:48];  & [zzzLead:48]actionDate:23>=$begDate; *)
			QUERY:C277([zzzLead:48];  & [zzzLead:48]actionDate:23<=$endDate; *)
		End if 
		If ($company#"")
			QUERY:C277([zzzLead:48];  & [zzzLead:48]company:5=$company+"@"; *)
		End if 
		If (pvNameFirst#"")
			QUERY:C277([zzzLead:48];  & [zzzLead:48]nameFirst:1=pvNameFirst+"@"; *)
		End if 
		If (pvNameLast#"")
			QUERY:C277([zzzLead:48];  & [zzzLead:48]nameLast:2=pvNameLast+"@"; *)
		End if 
		If (pvZip#"")
			QUERY:C277([zzzLead:48];  & [zzzLead:48]zip:10=pvZip+"@"; *)
		End if 
		If (pvPhone#"")
			QUERY:C277([zzzLead:48];  & [zzzLead:48]phone:4=pvPhone+"@"; *)
		End if 
		If ($customerID#"")
			QUERY:C277([zzzLead:48];  & [zzzLead:48]idNum:32=Num:C11($customerID); *)
		End if 
		If ($repID#"")
			QUERY:C277([zzzLead:48];  & [zzzLead:48]repID:12=$repID; *)
		End if 
		If ($salesNameID#"")
			QUERY:C277([zzzLead:48];  & [zzzLead:48]salesNameID:13=$salesNameID; *)
		End if 
		QUERY:C277([zzzLead:48])
		If (Records in selection:C76([zzzLead:48])>1)
			ORDER BY:C49([zzzLead:48]; [zzzLead:48]actionDate:23)
			If (Records in selection:C76([zzzLead:48])><>viMaxShow)
				REDUCE SELECTION:C351([zzzLead:48]; <>viMaxShow)
				$num:=Records in selection:C76([zzzLead:48])
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($startSrch)
	If ($ServTable)
		QUERY:C277([Service:6];  | [Service:6]actionBy:12=$theAcct; *)
		QUERY:C277([Service:6];  | [Service:6]actionCreatedBy:40=$theAcct; *)
		If ($doDate)
			QUERY:C277([Service:6];  & [Service:6]dtAction:35>=DateTime_Enter($begDate); *)
			QUERY:C277([Service:6];  & [Service:6]dtAction:35<=DateTime_Enter($endDate; ?23:59:59?); *)
		End if 
		//SEARCH([Service];&[Service]DTAction>=$dtBegin;*)
		//SEARCH([Service];&[Service]DTAction<=$dtEnd;*)
		If ($OpenOnly)
			QUERY:C277([Service:6];  & [Service:6]complete:17=False:C215; *)
		End if 
		QUERY:C277([Service:6])
		If (Records in selection:C76([Service:6])>1)
			ORDER BY:C49([Service:6]; [Service:6]dtAction:35)
			If (Records in selection:C76([Service:6])><>viMaxShow)
				REDUCE SELECTION:C351([Service:6]; <>viMaxShow)
				$num:=Records in selection:C76([Service:6])
			End if 
		End if 
	End if 
	//
	If ($CallTable)
		QUERY:C277([CallReport:34]; [CallReport:34]actionBy:3=$theAcct; *)
		If ($doDate)
			QUERY:C277([CallReport:34];  & [CallReport:34]dtAction:4>=$dtBegin; *)
			QUERY:C277([CallReport:34];  & [CallReport:34]dtAction:4<=$dtEnd; *)
		End if 
		If ($OpenOnly)
			QUERY:C277([CallReport:34];  & [CallReport:34]complete:7=False:C215; *)
		End if 
		QUERY:C277([CallReport:34])
		If (Records in selection:C76([CallReport:34])>1)
			ORDER BY:C49([CallReport:34]; [CallReport:34]dtAction:4)
			If (Records in selection:C76([CallReport:34])><>viMaxShow)
				REDUCE SELECTION:C351([CallReport:34]; <>viMaxShow)
				$num:=$num+Records in selection:C76([CallReport:34])
			End if 
		End if 
	End if 
	$doPage:=WC_DoPage("WccCalendar.html"; $jitPageList)
	$err:=WC_PageSendWithTags($1; $doPage; 0)
End if 
READ WRITE:C146([Order:3])
READ WRITE:C146([RemoteUser:57])
If ($doError)
	$doPage:=WC_DoPage("Error.html"; "")
	vResponse:="Not valid Employee or Rep"
	$err:=WC_PageSendWithTags($1; $doPage; 0)
End if 