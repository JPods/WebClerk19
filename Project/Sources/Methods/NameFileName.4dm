//%attributes = {"publishedWeb":true}
//method NameFileName
If (False:C215)
	//Date: 03/01/02
	//Who: Peter Fleming, Arkware
	//Description: Function - pass the full path name - returns just the file name
	VERSION_960
End if 
C_TEXT:C284($0; $1)
$Name:=$1
$result:=""
Repeat 
	$result:=Substring:C12($Name; Length:C16($Name))+$result
	$Name:=Delete string:C232($Name; Length:C16($Name); 1)
Until ((Substring:C12($Name; Length:C16($Name))=":") | (Substring:C12($Name; Length:C16($Name))="\\") | (Length:C16($Name)=0))
$0:=$result