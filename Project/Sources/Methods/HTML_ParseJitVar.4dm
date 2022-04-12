//%attributes = {"publishedWeb":true}
//Method: HTML_ParseJitVar
C_TEXT:C284($1; $myStr)
//
ARRAY TEXT:C222(aWebJITVar; 4)
aWebJITVar{1}:=Substring:C12($1; 1; 5)
C_LONGINT:C283($p)
$myStr:=Substring:C12($1; 6)
$p:=Position:C15("_"; $myStr)
If ($p=0)
	aWebJITVar{2}:="0"
	aWebJITVar{3}:="jitError1"
	aWebJITVar{4}:=$1
	$0:=0
	http_SendLog($c; "Error1: "+$1)  // send out the error
Else 
	aWebJITVar{2}:=Substring:C12($myStr; 1; $p-1)
	$myStr:=Substring:C12($myStr; 1; $p+1)
	$p:=Position:C15("_"; $myStr)
	If ($p=0)
		aWebJITVar{2}:="0"
		aWebJITVar{3}:="jitError2"
		aWebJITVar{4}:=$1
		$0:=0
		http_SendLog($c; "Error2: "+$1)  // send out the error
	Else 
		aWebJITVar{3}:=Substring:C12($myStr; 1; $p-1)
		aWebJITVar{4}:=aWebJITVar{1}+aWebJITVar{2}+"_"+aWebJITVar{3}+"_"
		$0:=Length:C16(aWebJITVar{4})
	End if 
End if 