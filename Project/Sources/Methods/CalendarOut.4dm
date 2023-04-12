//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/21/06, 10:37:27
// ----------------------------------------------------
// Method: Method: CalendarOut
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20181204_2312
// aligned date variables

// need to test this.
// it will not work in this layout because the parameters are not passed
// designed to work on the web

C_LONGINT:C283($1)
C_POINTER:C301($2)
C_TEXT:C284($iCalDoc; $newLine; $theText)
If ([RemoteUser:57]securityLevel:4>4000)
	$theRemoteUser:=WCapi_GetParameter("EmployeeID"; "")
	If ($theRemoteUser="")
		$theRemoteUser:=[RemoteUser:57]customerID:10
	End if 
Else 
	$theRemoteUser:=[RemoteUser:57]customerID:10
End if 

$newLine:="\n"

$iCalDoc:=$iCalDoc+"BEGIN:VCALENDAR"+Storage:C1525.char.crlf
$iCalDoc:=$iCalDoc+"PRODID:-//WebCalendar-v1.0RC2"+Storage:C1525.char.crlf
$iCalDoc:=$iCalDoc+"VERSION:2.0"+Storage:C1525.char.crlf
$tableName:=WCapi_GetParameter("TableName"; "")
$tableNum:=STR_GetTableNumber($tableName)
If ($tableNum>0)
	//$tableName:="WorkOrder"
	Case of 
		: ($tableName="WorkOrder")
			$iCalDoc:=$iCalDoc+"X-WR-CALNAME:"+$theRemoteUser+"_WorkOrders"+Storage:C1525.char.crlf
			$iCalDoc:=$iCalDoc+"METHOD:PUBLISH"+Storage:C1525.char.crlf
			$strBeginValue:=WCapi_GetParameter("beginValue"; "")
			$strEndValue:=WCapi_GetParameter("endValue"; "")
			$strOpen:=WCapi_GetParameter("Open"; "")
			
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]actionBy:8=$theRemoteUser; *)
			If ($strOpen="true")
				QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtComplete:6=0; *)
			End if 
			$dateBegin:=Date:C102($strBeginValue)
			If ($dateBegin>!00-00-00!)
				$dtBegin:=DateTime_DTTo($dateBegin)
				QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5>=$dtBegin; *)
			End if 
			$dateEnd:=Date:C102($strEndValue)
			If ($dateEnd>!00-00-00!)
				$dtEnd:=DateTime_DTTo($dateEnd; ?23:59:59?)
				QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=$dtEnd; *)
			End if 
			QUERY:C277([WorkOrder:66])
			$k:=Records in selection:C76([WorkOrder:66])
			FIRST RECORD:C50([WorkOrder:66])
			C_LONGINT:C283($i; $k)
			$newLine:=", "
			$comma:=","
			$commaiCal:="\\,"
			For ($i; 1; $k)
				$iCalDoc:=$iCalDoc+"BEGIN:VEVENT"+Storage:C1525.char.crlf
				DateTime_DTFrom([WorkOrder:66]dtCreated:44; ->iLoDate1; ->iLoTime1)
				DateTime_DTFrom([WorkOrder:66]dtRequested:31; ->iLoDate2; ->iLoTime2)
				DateTime_DTFrom([WorkOrder:66]dtAction:5; ->vdWoAction; ->vtWoAction)
				DateTime_DTFrom([WorkOrder:66]dtStarted:79; ->iLoDate4; ->iLoTime4)
				DateTime_DTFrom([WorkOrder:66]dtUpdated:78; ->iLoDate5; ->iLoTime5)
				// ### bj ### 20190428_0901
				// use the human readable dates and times for begin and end
				DateTime_DTFrom([WorkOrder:66]dtComplete:6; ->iLoDate6; ->iLoTime6)
				DateTime_DTFrom([WorkOrder:66]dtArchived:81; ->iLoDate7; ->iLoTime7)
				$timeString:=""
				$timeString:=String:C10(vtWoAction; 1)
				$dateStr:=String:C10(Month of:C24(vdWoAction); "00")+"/"+String:C10(Day of:C23(vdWoAction); "00")+"/"+Substring:C12(String:C10(Year of:C25(vdWoAction)); 3; 2)
				$timeStr:=$timeString
				// 161025 Fixed Deprecated Command
				// 161025 fix GMT  @XXAP Timestamp to GMT
				$strStart:=String:C10(Date:C102($dateStr); Date RFC 1123:K1:11; vtWoAction)
				// $strStart:=Date_RFC2iCal ($startTime)
				$iCalDoc:=$iCalDoc+"DTSTART:"+$strStart+Storage:C1525.char.crlf
				//
				If ([WorkOrder:66]durationPlanned:10=0)
					[WorkOrder:66]durationPlanned:10:=1
				End if 
				DateTime_DTFrom([WorkOrder:66]dtAction:5+(3600*[WorkOrder:66]durationPlanned:10); ->vdWoAction; ->vtWoAction)
				$endtimeString:=""
				$endtimeString:=String:C10(vdWoAction; 1)
				$dateStr:=String:C10(Month of:C24(vdWoAction); "00")+"/"+String:C10(Day of:C23(vdWoAction); "00")+"/"+Substring:C12(String:C10(Year of:C25(vdWoAction)); 3; 2)
				$timeStr:=$endtimeString
				$endTime:=String:C10(vdWoPlan; Date RFC 1123:K1:11; vtWoAction)
				// 161025 fix GMT  @XXAP Timestamp to GMT
				// $endTime:=@XXAP Timestamp to GMT (Date($dateStr);Time($timeStr))
				// $endTime:=Date_RFC2iCal ($endTime)
				$iCalDoc:=$iCalDoc+"DTEND:"+$endTime+Storage:C1525.char.crlf
				//
				$theText:=[WorkOrder:66]activity:7+", WONum: "+String:C10([WorkOrder:66]idNum:29)+", taskID: "+String:C10([WorkOrder:66]idNumTask:22)+", Customer: "+[WorkOrder:66]company:36
				$iCalDoc:=$iCalDoc+"SUMMARY:"+Replace string:C233($theText; $comma; $commaiCal)+Storage:C1525.char.crlf
				$iCalDoc:=$iCalDoc+"URL;VALUE=URI:http://"+Storage:C1525.wc.localHost+"/Calendar_Record?TableName=WorkOrders&RecordNum="+String:C10(Record number:C243([WorkOrder:66]))+"&Key="+[RemoteUser:57]key:21+"&jitPageOne=WCCWorkOrdersOne.html"+Storage:C1525.char.crlf
				$iCalDoc:=$iCalDoc+"CLASS:PUBLIC"+Storage:C1525.char.crlf
				//
				$theText:=[WorkOrder:66]actionBy:8+$newLine+[WorkOrder:66]address1:50+$newLine+[WorkOrder:66]address2:51+$newLine+[WorkOrder:66]city:52+", "+[WorkOrder:66]zip:54+$newLine+Replace string:C233([WorkOrder:66]description:3; "\r"; $newLine)
				$iCalDoc:=$iCalDoc+"DESCRIPTION:"+Replace string:C233($theText; $comma; $commaiCal)+Storage:C1525.char.crlf
				//
				//$iCalDoc:=$iCalDoc+"ATTENDEE;ROLE=OWNER;STATUS=CONFIRMED:William James"+Storage.char.crlf
				//
				//$iCalDoc:=$iCalDoc+"JIT-RECORDID:"+"WorkOrders_"+String(Record number([WorkOrder]))+<>CRLF
				$iCalDoc:=$iCalDoc+"END:VEVENT"+Storage:C1525.char.crlf
				NEXT RECORD:C51([WorkOrder:66])
			End for 
			
			$iCalDoc:=$iCalDoc+"END:VCALENDAR"+Storage:C1525.char.crlf
			
			//SET TEXT TO CLIPBOARD($iCalDoc)
			$0:=$iCalDoc
			
		: ($tableName="Service")
			$iCalDoc:=$iCalDoc+"X-WR-CALNAME:"+$theRemoteUser+"_Service"+Storage:C1525.char.crlf
			$iCalDoc:=$iCalDoc+"METHOD:PUBLISH"+Storage:C1525.char.crlf
			$strBeginValue:=WCapi_GetParameter("beginValue"; "")
			$strEndValue:=WCapi_GetParameter("endValue"; "")
			$strOpen:=WCapi_GetParameter("Open"; "")
			
			$strInitiatedBy:=WCapi_GetParameter("InitiatedBy"; "")
			If ($strInitiatedBy="true")
				QUERY:C277([Service:6]; [Service:6]actionCreatedBy:40=$theRemoteUser; *)
			Else 
				QUERY:C277([Service:6]; [Service:6]actionBy:12=$theRemoteUser; *)
			End if 
			If ($strOpen="true")
				QUERY:C277([Service:6];  & [Service:6]dtComplete:18=0; *)
			End if 
			$dateBegin:=Date:C102($strBeginValue)
			If ($dateBegin>!00-00-00!)
				$dtBegin:=DateTime_DTTo($dateBegin)
				QUERY:C277([Service:6];  & [Service:6]dtAction:35>=$dtBegin; *)
			End if 
			$dateEnd:=Date:C102($strEndValue)
			If ($dateEnd>!00-00-00!)
				$dtEnd:=DateTime_DTTo($dateEnd; ?23:59:59?)
				QUERY:C277([Service:6];  & [Service:6]dtAction:35<=$dtEnd; *)
			End if 
			QUERY:C277([Service:6])
			$k:=Records in selection:C76([Service:6])
			FIRST RECORD:C50([Service:6])
			C_LONGINT:C283($i; $k)
			For ($i; 1; $k)
				$iCalDoc:=$iCalDoc+"BEGIN:VEVENT"+Storage:C1525.char.crlf
				$iCalDoc:=$iCalDoc+"URL;VALUE=URL:"+"http://"+Storage:C1525.wc.localHost+"/Calendar_Record?TableName=Service&RecordNum="+String:C10(Record number:C243([Service:6]))+"&Key="+[RemoteUser:57]key:21+"&jitPageOne=WCCServiceOne.html"+Storage:C1525.char.crlf
				$iCalDoc:=$iCalDoc+"SUMMARY:"+[Service:6]action:20+", Service: "+String:C10([Service:6]idNum:26)+", SONum: "+String:C10([Service:6]idNumOrder:22)+", Customer: "+[Service:6]customerID:1+Storage:C1525.char.crlf
				$theText:="DESCRIPTION: CreatedBy, "+[Service:6]actionCreatedBy:40+$newLine+"ActionBy: "+[Service:6]actionBy:12+$newLine+"Process: "+[Service:6]process:4+"/"+[Service:6]attribute:5+"/"+[Service:6]cause:7+$newLine+Replace string:C233([Service:6]comment:11; "\r"; "\n")+Storage:C1525.char.crlf
				$iCalDoc:=$iCalDoc+$theText
				$iCalDoc:=$iCalDoc+"CLASS:PUBLIC"+Storage:C1525.char.crlf
				//$iCalDoc:=$iCalDoc+"ATTENDEE;ROLE=OWNER;STATUS=CONFIRMED:WebClerk <>"+Storage.char.crlf
				
				DateTime_DTFrom([Service:6]dtAction:35; ->vdWoAction; ->vtWoAction)
				
				$timeString:=""
				$timeString:=String:C10(vtWoAction; 1)
				$dateStr:=String:C10(Month of:C24(vdWoAction); "00")+"/"+String:C10(Day of:C23(vdWoAction); "00")+"/"+Substring:C12(String:C10(Year of:C25(vdWoAction)); 3; 2)
				$timeStr:=$timeString
				// 161025 fix GMT  @XXAP Timestamp to GMT
				//$startTime:=@XXAP Timestamp to GMT (Date($dateStr);Time($timeStr))
				// $strStart:=Date_RFC2iCal ($startTime)
				$strStart:=String:C10(vdWoAction; Date RFC 1123:K1:11; vtWoAction)
				$iCalDoc:=$iCalDoc+"DTSTART:"+$strStart+Storage:C1525.char.crlf
				If ([Service:6]durationPlanned:36=0)
					[Service:6]durationPlanned:36:=1
				End if 
				DateTime_DTFrom([Service:6]dtAction:35+(3600*[Service:6]durationPlanned:36); ->vdWoAction; ->vtWoAction)  //replaced [WorkOrder]DurationPlanned with 1
				
				$endtimeString:=""
				$endtimeString:=String:C10(vtWoAction; 1)
				$dateStr:=String:C10(Month of:C24(vdWoAction); "00")+"/"+String:C10(Day of:C23(vdWoAction); "00")+"/"+Substring:C12(String:C10(Year of:C25(vdWoAction)); 3; 2)
				$timeStr:=$endtimeString
				
				// 161025 fix GMT  @XXAP Timestamp to GMT
				// $endTime:=@XXAP Timestamp to GMT (Date($dateStr);Time($timeStr))
				// $endTime:=Date_RFC2iCal ($endTime)
				$endTime:=String:C10(vdWoAction; Date RFC 1123:K1:11; vtWoAction)
				$iCalDoc:=$iCalDoc+"DTEND:"+$endTime+Storage:C1525.char.crlf
				//$iCalDoc:=$iCalDoc+"JIT-RECORDID:"+"Service_"+String(Record number([Service]))+<>CRLF
				$iCalDoc:=$iCalDoc+"END:VEVENT"+Storage:C1525.char.crlf
				NEXT RECORD:C51([Service:6])
			End for 
			$iCalDoc:=$iCalDoc+"END:VCALENDAR"+Storage:C1525.char.crlf
			
			$0:=$iCalDoc
			
			
		: ($tableName="CallReport")
			$iCalDoc:=$iCalDoc+"X-WR-CALNAME:"+$theRemoteUser+"_CallReports"+Storage:C1525.char.crlf
			$iCalDoc:=$iCalDoc+"METHOD:PUBLISH"+Storage:C1525.char.crlf
			$strBeginValue:=WCapi_GetParameter("beginValue"; "")
			$strEndValue:=WCapi_GetParameter("endValue"; "")
			$strOpen:=WCapi_GetParameter("Open"; "")
			
			QUERY:C277([Call:34]; [Call:34]actionBy:3=$theRemoteUser; *)
			If ($strOpen="true")
				QUERY:C277([Call:34];  & [Call:34]dtComplete:33=0; *)
			End if 
			$dateBegin:=Date:C102($strBeginValue)
			If ($dateBegin>!00-00-00!)
				$dtBegin:=DateTime_DTTo($dateBegin)
				QUERY:C277([Call:34];  & [Call:34]dtAction:4>=$dtBegin; *)
			End if 
			$dateEnd:=Date:C102($strEndValue)
			If ($dateEnd>!00-00-00!)
				$dtEnd:=DateTime_DTTo($dateEnd; ?23:59:59?)
				QUERY:C277([Call:34];  & [Call:34]dtAction:4<=$dtEnd; *)
			End if 
			QUERY:C277([Call:34])
			$k:=Records in selection:C76([Call:34])
			FIRST RECORD:C50([Call:34])
			C_LONGINT:C283($i; $k)
			$newLine:=", "
			$comma:=","
			$commaiCal:="\\,"
			For ($i; 1; $k)
				$iCalDoc:=$iCalDoc+"BEGIN:VEVENT"+Storage:C1525.char.crlf
				DateTime_DTFrom([Call:34]dtAction:4; ->vdWoPlan; ->vtWoPlan)
				DateTime_DTFrom([Call:34]dtComplete:33; ->vdWOAction; ->vtWoAction)
				$timeString:=""
				$timeString:=String:C10(vtWoPlan; 1)
				$dateStr:=String:C10(Month of:C24(vdWoPlan); "00")+"/"+String:C10(Day of:C23(vdWoPlan); "00")+"/"+Substring:C12(String:C10(Year of:C25(vdWoPlan)); 3; 2)
				$timeStr:=$timeString
				// $startTime:=@XXAP Timestamp to GMT (Date($dateStr);Time($timeStr))
				// $strStart:=Date_RFC2iCal ($startTime)
				// 161025 fix GMT  @XXAP Timestamp to GMT
				$strStart:=String:C10(vdWoPlan; Date RFC 1123:K1:11; vtWoPlan)
				
				$iCalDoc:=$iCalDoc+"DTSTART:"+$strStart+Storage:C1525.char.crlf
				//
				If ([Call:34]durationPlanned:5=0)
					[Call:34]durationPlanned:5:=1
				End if 
				DateTime_DTFrom([Call:34]dtAction:4+(3600*[Call:34]durationPlanned:5); ->vdWoPlan; ->vtWoPlan)
				$endtimeString:=""
				$endtimeString:=String:C10(vtWoPlan; 1)
				$dateStr:=String:C10(Month of:C24(vdWoPlan); "00")+"/"+String:C10(Day of:C23(vdWoPlan); "00")+"/"+Substring:C12(String:C10(Year of:C25(vdWoPlan)); 3; 2)
				$timeStr:=$endtimeString
				// 161025 fix GMT  @XXAP Timestamp to GMT
				// $endTime:=@XXAP Timestamp to GMT (Date($dateStr);Time($timeStr))
				// $endTime:=Date_RFC2iCal ($endTime)
				
				$endTime:=String:C10(vdWoPlan; Date RFC 1123:K1:11; vtWoPlan)
				$iCalDoc:=$iCalDoc+"DTEND:"+$endTime+Storage:C1525.char.crlf
				//
				$theText:=[Call:34]action:15+", Customer:"+[Call:34]customerID:1+", Attention:"+[Call:34]attention:18
				$iCalDoc:=$iCalDoc+"SUMMARY:"+Replace string:C233($theText; $comma; $commaiCal)+Storage:C1525.char.crlf
				$iCalDoc:=$iCalDoc+"URL;VALUE=URI:http://"+Storage:C1525.wc.localHost+"/Calendar_Record?TableName=WorkOrders&RecordNum="+String:C10(Record number:C243([Call:34]))+"&Key="+[RemoteUser:57]key:21+"&jitPageOne=WCCWorkOrdersOne.html"+Storage:C1525.char.crlf
				$iCalDoc:=$iCalDoc+"CLASS:PUBLIC"+Storage:C1525.char.crlf
				//
				Case of 
					: ([Call:34]tableNum:2=2)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Call:34]customerID:1)
						$theText:="Customer Record: ActionBy: "+[Call:34]actionBy:3+$newLine+"Initiated By: "+[Call:34]initiatedBy:23+$newLine+[Customer:2]address1:4+$newLine+[Customer:2]address2:5+$newLine+[Customer:2]city:6+", "+[Customer:2]state:7+" "+[Customer:2]zip:8+$newLine+Replace string:C233([Call:34]comment:16; "\r"; $newLine)
						
					: ([Call:34]tableNum:2=Table:C252(->[Contact:13]))
						QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([Call:34]customerID:1))
						$theText:="Contact Record: ActionBy: "+[Call:34]actionBy:3+$newLine+"Initiated By: "+[Call:34]initiatedBy:23+$newLine+[Contact:13]address1:6+$newLine+[Contact:13]address2:7+$newLine+[Contact:13]city:8+", "+[Contact:13]state:9+" "+[Contact:13]zip:11+$newLine+Replace string:C233([Call:34]comment:16; "\r"; $newLine)
						
						
				End case 
				
				$iCalDoc:=$iCalDoc+"DESCRIPTION:"+Replace string:C233($theText; $comma; $commaiCal)+Storage:C1525.char.crlf
				//
				//$iCalDoc:=$iCalDoc+"ATTENDEE;ROLE=OWNER;STATUS=CONFIRMED:William James"+Storage.char.crlf
				//
				//$iCalDoc:=$iCalDoc+"JIT-RECORDID:"+"WorkOrders_"+String(Record number([CallReport]))+<>CRLF
				$iCalDoc:=$iCalDoc+"END:VEVENT"+Storage:C1525.char.crlf
				NEXT RECORD:C51([Call:34])
			End for 
			
			$iCalDoc:=$iCalDoc+"END:VCALENDAR"+Storage:C1525.char.crlf
			
			//SET TEXT TO CLIPBOARD($iCalDoc)
			$0:=$iCalDoc
			
	End case 
End if 

