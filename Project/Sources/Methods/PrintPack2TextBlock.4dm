//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/30/06, 16:29:58
// ----------------------------------------------------
// Method: PrintPack2TextBlock
// Description
// 
//
// Parameters
//$1 catagory of base line item (array or fields)
// ----------------------------------------------------
C_POINTER:C301($1; $2)
C_LONGINT:C283($3; $decimalPrecision)
If (Count parameters:C259>2)
	$format:=$3
Else 
	$format:=1
End if 
$getType:=Type:C295($1->)
$doField:=False:C215
$doRay:=False:C215
Case of 
	: ($getType=Is alpha field:K8:1)  // Long Integer 0
		$doField:=True:C214
	: ($getType=Is string var:K8:2)  // Long Integer 24
	: ($getType=Is text:K8:3)  // Long Integer 2
		$doField:=True:C214
	: ($getType=Is real:K8:4)  //Long Integer 1
		$doField:=True:C214
		If (Count parameters:C259>2)
			$format:=$3
		Else 
			$format:=2
		End if 
	: ($getType=Is integer:K8:5)  //Long Integer 8
		$doField:=True:C214
	: ($getType=Is longint:K8:6)  // Long Integer 9
		$doField:=True:C214
	: ($getType=Is date:K8:7)  // Long Integer 4
		$doField:=True:C214
	: ($getType=Is time:K8:8)  // Long Integer 11
		$doField:=True:C214
		If (Count parameters:C259>2)
			$format:=$3
		Else 
			$format:=2
		End if 
	: ($getType=Is boolean:K8:9)  // Long Integer 6
		$doField:=True:C214
	: ($getType=Is picture:K8:10)  // Long Integer 3
	: ($getType=Is subtable:K8:11)  //Long Integer 7
	: ($getType=Is BLOB:K8:12)  // Long Integer 30
	: ($getType=Is undefined:K8:13)  // Long Integer 5
	: ($getType=Is pointer:K8:14)  // Long Integer 23
		
	: ($getType=String array:K8:15)  // Long Integer 21
		$doRay:=True:C214
	: ($getType=Text array:K8:16)  // Long Integer 18
		$doRay:=True:C214
	: ($getType=Real array:K8:17)  // Long Integer 14
		$doRay:=True:C214
		If (Count parameters:C259>2)
			$format:=$3
		Else 
			$format:=2
		End if 
	: ($getType=Integer array:K8:18)  // Long Integer 15
		$doRay:=True:C214
	: ($getType=LongInt array:K8:19)  // Long Integer 16
		$doRay:=True:C214
	: ($getType=Date array:K8:20)  // Long Integer 17
		$doRay:=True:C214
		If (Count parameters:C259>2)
			$format:=$3
		Else 
			$format:=1
		End if 
	: ($getType=Boolean array:K8:21)  // Long Integer 22
		$doRay:=True:C214
	: ($getType=Picture array:K8:22)  // Long Integer 19
	: ($getType=Pointer array:K8:23)  // Long Integer 20
	: ($getType=Array 2D:K8:24)  // Long Integer 13
		
End case 

If ($doField)
	C_POINTER:C301($ptTable)
	$ptTable:=Table:C252(Table:C252($1))
	FIRST RECORD:C50($ptTable->)
	$cntRec:=Records in selection:C76($ptTable->)
	$2->:=""
	For ($incRec; 1; $cntRec)
		$termChar:="\r"*Num:C11($incRec<$cntRec)
		Case of 
			: ($getType=Is real:K8:4)
				C_TEXT:C284($strFormat)
				$strFormat:="###,###,##0"+("."*Num:C11($format>0))+("0"*$format)
				$2->:=$2->+String:C10($1->; $strFormat)+$termChar
			: (($getType=Is integer:K8:5) | ($getType=Is longint:K8:6))
				$2->:=$2->+String:C10($1->)+$termChar
			: ($getType=Is date:K8:7)  // Long Integer 4
				$2->:=$2->+String:C10($1->; $format)+$termChar
			: ($getType=Is time:K8:8)  // Long Integer 11
				$2->:=$2->+String:C10($1->; $format)+$termChar
			: ($getType=Is boolean:K8:9)  // Long Integer 6
				$2->:=$2->+String:C10($1->)+$termChar
			Else 
				If ($format>0)
					$2->:=$2->+Substring:C12($1->; 1; $format)+$termChar
				Else 
					$2->:=$2->+$1->+$termChar
				End if 
				
				//: ($getType=Is Alpha Field)// Long Integer 0
				//: ($getType=Is Text)// Long Integer 2
		End case 
		NEXT RECORD:C51($ptTable->)
	End for 
End if 


If ($doRay)
	$cntRec:=Size of array:C274($1->)
	$2->:=""
	For ($incRec; 1; $cntRec)
		$termChar:="\r"*Num:C11($incRec<$cntRec)
		Case of 
			: ($getType=Real array:K8:17)  // Long Integer 14
				$strFormat:="###,###,##0"+("."*Num:C11($format>0))+("0"*$format)
				$realValue:=Round:C94($1->{$incRec}; $format)
				$2->:=$2->+String:C10($realValue; $strFormat)+$termChar
			: ($getType=Integer array:K8:18)  // Long Integer 15
				$2->:=$2->+String:C10($1->{$incRec})+$termChar
			: ($getType=LongInt array:K8:19)  // Long Integer 16
				$2->:=$2->+String:C10($1->{$incRec})+$termChar
			: ($getType=Date array:K8:20)  // Long Integer 17
				
				
				$2->:=$2->+String:C10($1->{$incRec}; $format)+$termChar
			: ($getType=Boolean array:K8:21)  // Long Integer 22
				$2->:=$2->+String:C10($1->{$incRec}; $format)+$termChar
			: ($getType=String array:K8:15)  // Long Integer 21
				$2->:=$2->+$1->{$incRec}+$termChar
			: ($getType=Text array:K8:16)  // Long Integer 18
				$2->:=$2->+$1->{$incRec}+$termChar
		End case 
	End for 
End if 
