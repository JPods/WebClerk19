//%attributes = {"publishedWeb":true}
//Method: Http_ItemParseAdds
C_TEXT:C284($1; $0; $myStr)
//
//TRACE
C_LONGINT:C283($p)
$p:=Position:C15("_Ad"; $1)
$myStr:=Substring:C12($1; $p+6)  //clip throu =
$p:=Position:C15("&"; $myStr)
If ($p=0)
	$0:=$myStr
Else 
	$0:=Substring:C12($myStr; 1; $p-1)
End if 
//$p:=Position(" ";$0)
//If ($p>0)
//$0:=Substring($0;1;$p-1)
//End if 
$p:=Position:C15("<"; $0)
If ($p>0)
	$0:=Substring:C12($0; 1; $p-1)
End if 