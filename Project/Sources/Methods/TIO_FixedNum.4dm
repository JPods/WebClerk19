//%attributes = {"publishedWeb":true}
//Procedure: TIO_FixedNum
C_TEXT:C284($0)  //Fixed Position String
C_REAL:C285($1; $InNum)  //Required: Original String to be formated
$InNum:=$1
C_LONGINT:C283($2; $FieldLen)  //Required: Resulting fixed position string length
$FieldLen:=$2
C_LONGINT:C283($3)  //Required: Number of decimal places
C_TEXT:C284($format)
If ($3>$FieldLen)
	$3:=$FieldLen-1
End if 
If ($3>0)
	$format:=("#"*($FieldLen-$3-2))+"0."+("0"*$3)
Else 
	$format:=("#"*($FieldLen-1))+"0"
End if 
C_TEXT:C284($4; $FillChar)  //Optional: Char to fill with
If (Count parameters:C259>=4)
	$FillChar:=$4
Else 
	$FillChar:="0"  //Zero
End if 
C_BOOLEAN:C305($5; $LeftFill)  //Optional: Fill the extra chars on the left if true or missing or right if false
If (Count parameters:C259>=5)
	$LeftFill:=$5
Else 
	$LeftFill:=True:C214
End if 

$0:=Substring:C12(String:C10($InNum; $format); 1; $FieldLen)
If ($LeftFill)
	$0:=($FillChar*($FieldLen-Length:C16($0)))+$0
Else 
	$0:=$0+($FillChar*($FieldLen-Length:C16($0)))
End if 