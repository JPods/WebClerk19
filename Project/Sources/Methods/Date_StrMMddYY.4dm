//%attributes = {"publishedWeb":true}
//Date_StrMMddYY
//C_DATE($1)
//C_TEXT($0)
//$0:=String(Month of($1); "00")+String(Day of($1); "00")+Substring(String(Year of($1)); 3)

var $period : Object
$name:="month"
$dateBeg:=Current date:C33
$dateEnd:=Current date:C33
var $length : Integer
Case of 
	: ($name="week")
		$length:=7
	: ($name="")
		$name:="month"
		$length:=30
	: ($name="month")
		$length:=30
	: ($name="quarter")
		$length:=90
	: ($name="year")
		$length:=365
	Else 
		$length:=Num:C11($name)
		If ($length=0)
			$length:=30
			$name:="month"
		End if 
End case 

//If (($length<1) | ($length<10000))
//$length:=30
//end if
var $doEnd : Boolean
Case of 
	: (($dateBeg=!00-00-00!) & ($dateEnd=!00-00-00!))
		$dateBeg:=Current date:C33-Day of:C23(Current date:C33)+1
		$doEnd:=True:C214
	: ($dateBeg#!00-00-00!)
		If (($name="month") | ($name="quarter") | ($name="year"))
			$dateBeg:=$dateBeg-Day of:C23($dateBeg)+1
		End if 
		$dateEnd:=$dateBeg+$length
		$doEnd:=True:C214
	Else 
		$dateBeg:=$dateEnd-$length
		If (($name="month") | ($name="quarter") | ($name="year"))
			$dateBeg:=$dateBeg+5
			$dateBeg:=$dateBeg-Day of:C23($dateEnd)+1
		End if 
End case 

If (($name="month") | ($name="quarter") | ($name="year"))
	$dateEnd:=$dateEnd+5
	$dateEnd:=$dateEnd-Day of:C23($dateEnd)
	$length:=$dateEnd-$dateBeg+1
End if 

$period:=New object:C1471("name"; $name; "begin"; $dateBeg; "end"; $dateEnd; "length"; $length)