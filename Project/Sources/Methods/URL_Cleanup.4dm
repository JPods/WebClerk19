//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/05/09, 09:45:11
// ----------------------------------------------------
// zzzqqq URL_Cleanup zzzqqq // Method: URL_Cleanup
// Description
// $1 Text Domain
//$0 Text formatted Domain
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)  // QQQQ
If ($1="")
	//no action
Else 
	If ($1[[Length:C16($1)]]="/")
		$0:=Substring:C12($1; 1; Length:C16($1)-1)
	End if 
	If ($1#"http@")
		If ($1="/@")
			$0:="http:/"+$1
		Else 
			$0:="http://"+$1
		End if 
	Else 
		$0:=$1  // ### jwm ### 20150825_1737
	End if 
End if 