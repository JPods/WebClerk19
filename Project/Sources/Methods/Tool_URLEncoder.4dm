//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/08/14, 14:12:29
// ----------------------------------------------------
// Method: Tool_URLEncoder
// Description
// 
//
// Parameters
// ----------------------------------------------------

// encodes Text (MacRoman) to URL encoding (7 bit)

$result:=""
$WSPI_MyString:=$1

// If the charset is different than Latin-1 please add your translation below
// Parse the string and translate the special characters
For ($WSPI_parser; 1; Length:C16($WSPI_MyString))
	$WSPI_MyChar:=Substring:C12($WSPI_MyString; $WSPI_parser; 1)
	$WSPI_ascii:=Character code:C91($WSPI_MyChar)
	If ((($WSPI_ascii>=Character code:C91("a'")) & ($WSPI_ascii<=Character code:C91("z'"))) | (($WSPI_ascii>=Character code:C91("A")) & ($WSPI_ascii<=Character code:C91("Z"))) | (($WSPI_ascii>=Character code:C91("0")) & ($WSPI_ascii<=Character code:C91("9"))) | ($WSPI_MyChar="*") | ($WSPI_MyChar="-") | ($WSPI_MyChar=".") | ($WSPI_MyChar="_") | ($WSPI_MyChar="/"))
		$result:=$result+$WSPI_MyChar
	Else 
		$result:=$result+"%"
		$WSPI_n:=Character code:C91($WSPI_MyChar)\16
		If ($WSPI_n<10)
			$result:=$result+String:C10($WSPI_n)
		Else 
			$result:=$result+Char:C90(Character code:C91("A")+$WSPI_n-10)
		End if 
		$WSPI_n:=Character code:C91($WSPI_MyChar)%16
		If ($WSPI_n<10)
			$result:=$result+String:C10($WSPI_n)
		Else 
			$result:=$result+Char:C90(Character code:C91("A")+$WSPI_n-10)
		End if 
	End if 
End for 
$0:=$result