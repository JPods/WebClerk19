//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/06/21, 21:18:01
// ----------------------------------------------------
// Method: LB_TextStringAddID
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0; $1)

Case of 
	: ($1=",id,")  // ignore
	: ($1="id,")  // ignore
	: ($1="@,id")  // ignore
	Else 
		$1:=$1+","+"id"
End case 
$0:=$1