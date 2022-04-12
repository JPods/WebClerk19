//%attributes = {}


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/04/19, 14:19:46
// ----------------------------------------------------
// Method: Txt_Pad
// Description
// 
//
// Parameters
// ----------------------------------------------------

// $vtResult:=Txt_Pad("myText";" ";"right";12)

C_TEXT:C284($0; $1; $vtString; $2; $vtPad; $3; $vtAlign; $vtTemplate)
C_LONGINT:C283($4; $viLength; $viWhere)


If (Count parameters:C259=4)
	$vtString:=$1
	$vtPad:=$2
	$vtAlign:=$3
	$viLength:=$4
	$vtTemplate:=$vtPad*$viLength
	
	If ($vtAlign="Left")
		$viWhere:=1
	Else 
		$viWhere:=$viLength-Length:C16($vtString)+1
		
		If ($viWhere<0)
			$viWhere:=Abs:C99($viWhere)
			// ### bj ### 20190210_1704
			// unsure what this was supposed to be 
			//   was
			//  Substring($vtString;$viWhere;$viLength)
			// i changed it to
			$vtString:=Substring:C12($vtString; $viWhere; $viLength)
			$viWhere:=1
		End if 
	End if 
	//Change string ( source ; newChars ; where ) -> Function result 
	$0:=Change string:C234($vtTemplate; $vtString; $viwhere)
	
End if 