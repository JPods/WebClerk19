//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/14/20, 10:46:16
// ----------------------------------------------------
// Method: UtilClean2SafeChar
// Description
//   // need to review with Jim and Andy
//
// Parameters
// ----------------------------------------------------


//
//\ / : ; * ? " < > |
C_TEXT:C284($1; $0)
C_LONGINT:C283($i; $k)
$k:=Length:C16($1)
$result:=""
For ($i; 1; $k)
	$charNum:=Character code:C91($1[[$i]])
	Case of 
		: ($charNum<32)
			$result:=$result+"-"
		: (($1[[$i]]="\\") | ($1[[$i]]="/") | ($1[[$i]]=":") | ($1[[$i]]=";") | ($1[[$i]]="*") | ($1[[$i]]="?") | ($1[[$i]]=Char:C90(34)) | ($1[[$i]]="<") | ($1[[$i]]=">") | ($1[[$i]]="&") | ($1[[$i]]="|") | ($1[[$i]]="@"))
			$result:=$result+"-"
			//: (($charNum>90)&($charNum<97))
			//$result:=$result+"_"
		: ($charNum>126)
			$result:=$result+"-"
		Else 
			$result:=$result+$1[[$i]]
	End case 
End for 
$0:=$result
