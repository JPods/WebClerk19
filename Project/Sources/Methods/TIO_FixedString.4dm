//%attributes = {"publishedWeb":true}
//Procedure: TIO_FixedString
C_TEXT:C284($0)  //Fixed Position String
C_TEXT:C284($1; $InStr)  //Required: Original String to be formated
$InStr:=$1
C_LONGINT:C283($2; $FieldLen)  //Required: Resulting fixed position string length
$FieldLen:=$2
C_TEXT:C284($3; $FillChar)  //Optional: Char to fill with
If (Count parameters:C259>=3)
	$FillChar:=$3
Else 
	$FillChar:=" "  //space
End if 
C_BOOLEAN:C305($4; $LeftFill)  //Optional: Fill the extra chars on the left if true or right if false or missing
If (Count parameters:C259>=4)
	$LeftFill:=$4
Else 
	$LeftFill:=False:C215
End if 

$InStr:=Substring:C12($InStr; 1; $FieldLen)
If ($LeftFill)
	$0:=($FillChar*($FieldLen-Length:C16($InStr)))+$InStr
Else 
	$0:=$InStr+($FillChar*($FieldLen-Length:C16($InStr)))
End if 