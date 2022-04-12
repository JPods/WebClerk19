//%attributes = {"publishedWeb":true}
//Procedure: http_CalendarBu
C_TEXT:C284($0)
C_DATE:C307($1; $keyDate; $begMon; $endMon; $begCal; $doCal)

C_TEXT:C284($return; $quote)
$return:=Char:C90(13)
$return:=""

$quote:=Char:C90(34)
//TRACE
////
ARRAY TEXT:C222(<>aMonthName; 12)
<>aMonthName{1}:="January"
<>aMonthName{2}:="Febuary"
<>aMonthName{3}:="March"
<>aMonthName{4}:="April"
<>aMonthName{5}:="May"
<>aMonthName{6}:="June"
<>aMonthName{7}:="July"
<>aMonthName{8}:="August"
<>aMonthName{9}:="September"
<>aMonthName{10}:="October"
<>aMonthName{11}:="November"
<>aMonthName{12}:="December"
If (Count parameters:C259=0)
	$keyDate:=Current date:C33
Else 
	$keyDate:=$1
End if 

//must be in a form
//C_Longint($i)
//C_TEXT($monChoice)
//$begMon:=Date_ThisMon ($keyDate-190;0)
//$monChoice:="<SELECT NAME="+$quote+"calendarMon"+$quote+">"+$return+
//"<Option value="+$quote+$quote+" Selected="selected">Change Month"
//For ($i;1;24)
//$monChoice:=$monChoice+"<OPTION>"+String(Month of($begMon))+"/"+String
//(Year of($begMon))+$return
//$begMon:=Date_ThisMon ($begMon+35;0)
//End for 
//$monChoice:=$monChoice+"</SELECT>"
//CopyTEXT ($monChoice)
$begMon:=Date_ThisMon($keyDate; 0)
$endMon:=Date_ThisMon($keyDate; 1)
$doCal:=$begMon+1-Day number:C114($begMon)
C_LONGINT:C283($cntWeek; $cntDays; $incDay; $theMon)
C_TEXT:C284($theCalendar; $monStr)
$theMon:=Month of:C24($begMon)
//
$incDay:=0
$theCalendar:="<table Border=2 cellspacing=2 cellpadding=2 width=505>"+$return
$theCalendar:=$theCalendar+"  <tr><td colspan=8 align=center>"+<>aMonthName{$theMon}+" "+String:C10(Year of:C25($begMon))+"</td></tr>"+$return
$theCalendar:=$theCalendar+"  <tr><td>Week</td><td align=center>S</td><td align=center>M</td>"
$theCalendar:=$theCalendar+"<td align=center>T</td><td align=center>W</td>"
$theCalendar:=$theCalendar+"<td align=center>Th</td><td align=center>F</td>"
$theCalendar:=$theCalendar+"<td align=center>S</td></tr>"+$return
For ($cntWeek; 1; 5)
	$theCalendar:=$theCalendar+"  <tr>"+$return
	$theCalendar:=$theCalendar+"    <td><a href="+$quote+"/sales_Calendar?DateBegin="+String:C10($doCal; 1)+"&DateEnd="+String:C10($doCal+6; 1)
	$theCalendar:=$theCalendar+"&LeadTable=true&CustomerTable=true&ServiceTable=true&ContactTable=true&"
	If (<>doeventID)
		$theCalendar:=$theCalendar+"CallReportTable=true&jitUser="+$quote+">Week "+String:C10($cntWeek)+"</a></td>"+$return
	Else 
		$theCalendar:=$theCalendar+"CallReportTable=true"+$quote+">Week "+String:C10($cntWeek)+"</a></td>"+$return
	End if 
	For ($cntDays; 1; 7)
		$theCalendar:=$theCalendar+"    <td align=right><a href="+$quote+"/sales_Calendar?DateBegin="+String:C10($doCal; 1)+"&DateEnd="+String:C10($doCal; 1)
		$theCalendar:=$theCalendar+"&LeadTable=true&CustomerTable=true&ServiceTable=true&ContactTable=true&"
		If (<>doeventID)
			$theCalendar:=$theCalendar+"CallReportTable=true&jitUser="+String:C10(vleventID)+$quote+">"+String:C10(Day of:C23($doCal))+"</a></td>"+$return
		Else 
			$theCalendar:=$theCalendar+"CallReportTable=true"+$quote+">"+String:C10(Day of:C23($doCal))+"</a></td>"+$return
		End if 
		$doCal:=$doCal+1
	End for 
	$theCalendar:=$theCalendar+"  </tr>"+$return
End for 
$0:=$theCalendar+"</table>"+$return
//scripts
//CopyTEXT (<>calThisMon)
//