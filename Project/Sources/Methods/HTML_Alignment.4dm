//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/03/19, 14:38:55
// ----------------------------------------------------
// Method: HTML_Alignment
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)
C_TEXT:C284($0; $theAlignment)
C_LONGINT:C283($viType)

$viType:=Type:C295($1->)
Case of 
	: (($viType=0) | ($viType=2) | ($viType=24))  //string or text
		$theAlignment:=atTableHTML{6}
	: ($viType=4)  //date
		$theAlignment:=atTableHTML{7}
	: (($viType=1) | ($viType=8))  //integer or real
		$theAlignment:=atTableHTML{8}
	: ($viType=9)  //long int
		If (Field name:C257($1)="DT@")
			$theAlignment:=atTableHTML{7}
		Else 
			$theAlignment:=atTableHTML{8}
		End if 
	: ($viType=6)  //boolean
		$theAlignment:=atTableHTML{6}
	: ($viType=11)  //time
		$theAlignment:=atTableHTML{7}
	Else 
		$theAlignment:=atTableHTML{6}
End case 
$0:=$theAlignment