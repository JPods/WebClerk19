//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/30/06, 08:47:26
// ----------------------------------------------------
// Method: QueryBuild
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141022_1149 new blank, not blank operators


C_LONGINT:C283($1; $2; $tableNum; $fieldNum)
C_TEXT:C284($3; $4; $5; $0; $tableName; $fieldName)
$tableNum:=$1
$fieldNum:=$2
$tableName:="["+Table name:C256($1)+"]"
$fieldName:=Field name:C257($1; $2)
$doQuery:=1
$5:=Replace string:C233($5; "%20"; " ")
$queryValue:=$5
$theType:=Type:C295(Field:C253($tableNum; $fieldNum)->)
C_POINTER:C301($ptValue1)
$preWild:=""
$endWild:=""
$typeChar:=""
$0:=""
Case of 
	: (($theType=0) | ($theType=2) | ($theType=24))
		$endWild:="@"
		$typeChar:=Char:C90(34)
	: ($theType=4)
		$typeChar:="!"
		If ($queryValue="")
			$queryValue:="00/00/00"
		End if 
	: (($theType=1) | ($theType=8) | ($theType=9))
		If ($queryValue="")
			$queryValue:="0"
		End if 
	: ($theType=11)
		$typeChar:=""
		If ($queryValue="")
			$queryValue:="00:00:00"
		End if 
	: ($theType=Is boolean:K8:9)
		$typeChar:=""
		If (($queryValue="1@") | ($queryValue="t@") | ($queryValue="y@"))
			$queryValue:="true"
		Else 
			$queryValue:="false"
		End if 
	Else 
		$doQuery:=0
End case 
$myBoolean:=""
$w:=Find in array:C230(<>aBooleanOperators; $3)
Case of 
	: ($w>0)
		$myBoolean:=(" &; "*Num:C11($w=1))+(" |; "*Num:C11($w=2))+(""*Num:C11($w=3))
	: ($3="single")
		//$myBoolean:=""
	Else 
		$myBoolean:=" &; "
End case 
//
$4:=Replace string:C233($4; "%20"; " ")  // should this be gneralized for URL Encoding ?
$w:=Find in array:C230(<>aOperators; $4)
Case of 
	: ($w>11)  // Modified by: William James (2014-02-12T00:00:00)
		$operator:=<>aOperators{$w}
	: ($w>0)
		$operator:=("="*Num:C11($w=1))+("#"*Num:C11($w=2))+(">"*Num:C11($w=3))+(">="*Num:C11($w=4))+("<"*Num:C11($w=5))+("<="*Num:C11($w=6))+("="*Num:C11($w=7))+("#"*Num:C11($w=8))+("literal"*Num:C11($w=9))+("blank"*Num:C11($w=10))+("not blank"*Num:C11($w=11))
		If ($w=9)
			$endWild:=""
			$operator:="="
		End if 
		If ($w=10)  // ### jwm ### 20141022_1149 blank
			$endWild:=""
			$operator:="="
			$queryValue:=""
		End if 
		If ($w=11)  // ### jwm ### 20141022_1149 not blank
			$endWild:=""
			$operator:="#"
			$queryValue:=""
		End if 
		If ($w=7)
			$operator:="="
			$preWild:="@"
		End if 
		If ($operator="")
			$operator:="="
		End if 
	Else 
		$operator:="="
End case 

If ($doQuery>0)
	$0:="Query("+$tableName+";"+$myBoolean+$tableName+$fieldName+$operator+$typeChar+$preWild+$queryValue+$endWild+$typeChar+";*)"+"\r"
End if 