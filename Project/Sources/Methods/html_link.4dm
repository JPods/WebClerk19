//%attributes = {"publishedWeb":true}
// make an HTML link
// $1 -> link URL
// $2 -> link text

C_TEXT:C284($0; $1; $2)
Case of 
	: (($1="@.gif") | ($1="@.jpg") | ($1="@.jpeg"))  // inlined picture
		$0:="<img src="+Char:C90(34)+$1+Char:C90(34)
		If ($2#"")
			$0:=$0+" ALT="+Char:C90(34)+NTKString2HTML($2)+Char:C90(34)
		End if 
		$0:=$0+">"
	: (True:C214)  // normal link
		If ($2="")
			$2:=$1
		End if 
		$0:="<a href="+Char:C90(34)+$1+Char:C90(34)+">"+NTKString2HTML($2)+"</a>"
End case 