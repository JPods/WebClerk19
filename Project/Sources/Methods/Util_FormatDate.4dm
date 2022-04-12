//%attributes = {"publishedWeb":true}
// Util_FormatDate
// Matt Hartzler 20010807
// The format parameter can consist of any combination of M,D,YY,MM,DD,YYYY
// Any other characters in the format param simply pass through.
// Some examples where $d = DATE("01/05/2000")
// Util_FormatDate($d;"MM-DD-YY") returns "01-05-00"
// Util_FormatDate($d;"M-D-YYYY") returns "1-05-2000"
// Util_FormatDate($d;"MM/DD/YY") returns "01/05/00"
// Util_FormatDate($d;"MM/YY") returns "01/00"
// Util_FormatDate($d;"!@#$%^&*()") returns "!@#$%^&*()"
// Util_FormatDate($d;"YYYYMMDD") returns "20010105"

C_DATE:C307($1; $d)
$d:=$1
C_TEXT:C284($2; $format)
$format:=$2

C_LONGINT:C283($count)
C_TEXT:C284($result)

$count:=1
While ($count<=Length:C16($format))
	Case of 
		: ($format[[$count]]="d")
			If (($count<Length:C16($format)) & ($format[[$count+1]]="d"))
				If (Day of:C23($d)<10)
					$result:=$result+"0"
				End if 
				$count:=$count+1
			End if 
			$result:=$result+String:C10(Day of:C23($d))
			
		: ($format[[$count]]="m")
			If (($count<Length:C16($format)) & ($format[[$count+1]]="m"))
				If (Month of:C24($d)<10)
					$result:=$result+"0"
				End if 
				$count:=$count+1
			End if 
			$result:=$result+String:C10(Month of:C24($d))
			
		: ($format[[$count]]="y")
			If (($count+2<Length:C16($format)) & ($format[[$count+2]]="y"))
				$result:=$result+String:C10(Year of:C25($d))
				$count:=$count+3
			Else 
				$result:=$result+Substring:C12(String:C10(Year of:C25($d)); 3; 2)
				$count:=$count+1
			End if 
			
		Else 
			$result:=$result+$format[[$count]]
	End case 
	
	$count:=$count+1
End while 

$0:=$result