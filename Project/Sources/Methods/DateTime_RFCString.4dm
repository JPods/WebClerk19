//%attributes = {}
// (PM) DateTime_RFCString
// Returns a RFC 822 string for a date and time
// $1 = Date
// $2 = TIme
// $0 = RFC string

C_DATE:C307($1; $date; $gmtdate)
C_TIME:C306($2; $time; $gmttime)
C_TEXT:C284($0; $rfcdate)

If (Count parameters:C259>=1)
	$date:=$1
Else 
	$date:=Current date:C33
End if 

If (Count parameters:C259>=2)
	$time:=$2
Else 
	$time:=Current time:C178
End if 

//$rfcdate:=AP Timestamp to GMT ($date;$time;$gmtdate;$gmttime)
//
$hourAfterGMT:=6
$dtLong:=DateTime_Enter($date; $time)
$dtLong:=$dtLong+(60*60*$hourAfterGMT)
$date:=jDateTimeRDate($dtLong)
$time:=jDateTimeRTime($dtLong)
//
$rfcdate:=<>ysSDayNames{Day number:C114($date)}+", "+String:C10(Day of:C23($date); "00")+" "+Substring:C12(<>arrmonth{Month of:C24($date)}; 1; 3)+" "+String:C10(Year of:C25($date))+" "+Time string:C180($time)+" GMT"

$0:=$rfcdate

$myGMTString:=False:C215
If ($myGMTString)  //Mon, 24 Aug 2009 14:01:51 GMT
	$rfcdateMine:=<>ysSDayNames{Day number:C114($date)}+", "+String:C10(Day of:C23($date); "00")+" "+Substring:C12(<>arrmonth{Month of:C24($date)}; 1; 3)+" "+String:C10(Year of:C25($date))+" "+Time string:C180($time)+" GMT"
	// 161025 Fixed Deprecated Command
	// $rfcdate:=@XXAP Timestamp to GMT ($date;$time;$gmtdate;$gmttime)
	// 161025 fix GMT  @XXAP Timestamp to GMT
	$rfcdate:=String:C10($date; Date RFC 1123:K1:11; $time)
End if 