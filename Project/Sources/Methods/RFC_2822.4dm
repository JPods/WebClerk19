//%attributes = {}

//RFC_2822 ($vtDateString;->$vdDate;->$vdTime)

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/11/19, 17:23:22
// ----------------------------------------------------
// Method: RFC_2822
// Description
// 
//
// Parameters
// ----------------------------------------------------

//<declarations>
//==================================
//  Type variables 
//==================================

// $atEmailDate;$monthArray
C_DATE:C307($vdEmailDate)
C_TEXT:C284($1; $vtDay; $vtEmailDate; $vtMonth; $vtTime; $vtYear)
C_TIME:C306($vhTime)
C_POINTER:C301($2; $3; $vpDate; $vpTime)

//==================================
//  Initialize variables 
//==================================

$vdEmailDate:=!00-00-00!
$vtDay:=""
$vtEmailDate:=""
$vtMonth:=""
$vtTime:=""
$vtYear:=""
$vhTime:=0
//</declarations>

ARRAY TEXT:C222($monthArray; 12)
$monthArray{1}:="Jan"
$monthArray{2}:="Feb"
$monthArray{3}:="Mar"
$monthArray{4}:="Apr"
$monthArray{5}:="May"
$monthArray{6}:="Jun"
$monthArray{7}:="Jul"
$monthArray{8}:="Aug"
$monthArray{9}:="Sep"
$monthArray{10}:="Oct"
$monthArray{11}:="Nov"
$monthArray{12}:="Dec"

//$vtEmailDate:="Thu, 5 Sep 2019 11:58:33 -0400"

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/11/19, 17:18:14
// ----------------------------------------------------
// Method: RFC_2822
// Description
// 
//
// Parameters
// ----------------------------------------------------



If (Count parameters:C259>=1)
	$vtEmailDate:=$1
End if 

If (Count parameters:C259>=2)
	$vpDate:=$2
End if 

If (Count parameters:C259>=3)
	$vpTime:=$3
End if 

ARRAY TEXT:C222($atEmailDate; 0)

Txt_2Array($vtEmailDate; ->$atEmailDate; " "; True:C214)

If (Size of array:C274($atEmailDate)=6)  // valid RFC 2822 date string
	$vtMonth:=String:C10(Find in array:C230($monthArray; $atEmailDate{3}))
	$vtDay:=$atEmailDate{2}
	$vtYear:=$atEmailDate{4}
	$vtTime:=$atEmailDate{5}
	
	$vdEmailDate:=Date:C102($vtMonth+"/"+$vtDay+"/"+$vtYear)
	$vhTime:=Time:C179($vtTime)
	
	If (Count parameters:C259>=2)
		$vpDate->:=$vdEmailDate
	End if 
	
	If (Count parameters:C259>=3)
		$vpTime->:=$vhTime
	End if 
	
	$0:=1
Else 
	$0:=0
End if 


