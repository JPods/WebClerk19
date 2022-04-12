//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: txt_FixLength
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($1; $0; $2; $3)
C_LONGINT:C283($4; $5; $needSpace; $theLen; $cntParam)
C_TEXT:C284($fillChar)
$cntParam:=Count parameters:C259
//
$fillChar:=$2
//
If ($cntParam=5)
	$0:=txt_MaxLength($1; $4)
	$theLen:=Length:C16($0)
	$needSpace:=$5-$theLen
	If ($needSpace>0)
		If (($3="Right") | ($3="R"))
			$0:=($fillChar*$needSpace)+$0
		Else 
			$0:=$0+($fillChar*$needSpace)
		End if 
	End if 
Else 
	$0:=$1
End if 