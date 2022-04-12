//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/27/18, 16:16:51
// ----------------------------------------------------
// Method: HTML_jitTagMake
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	// also see for a leaner version
	$response:=Tag_jit_FromNumbers(2; 1)  //  $tableNum;$fieldNum;$format)
	$response:=Tag_jit_FromNames("Customer"; "Country")
End if 

C_BOOLEAN:C305(<>webPagesByNames)
<>webPagesByNames:=True:C214

C_TEXT:C284($2; $3; $4; $thisTag)
C_TEXT:C284($0)
C_TEXT:C284($action; $tableName; $fieldName; $formatTag)
C_LONGINT:C283($1; $tableNum)
$formatTag:=""
$tableNum:=Num:C11($2)
$fieldNum:=Num:C11($3)
Case of 
	: (($tableNum>0) & ($fieldNum>0))
		// Modified by: Bill James (2017-06-08T00:00:00)
		
		$tableName:=Table name:C256($tableNum)  // "["+Table name($tableNum)+"]"
		$fieldName:=Field name:C257(Field:C253($tableNum; $fieldNum))
	: ($tableNum>0)
		$tableName:=Table name:C256($tableNum)
		$tableName:=$3
	Else 
		$tableName:=$2
		$fieldName:=$3
End case 

// Modified by: Bill James (2017-06-08T00:00:00)  jitByNames
$1:=4
<>webPagesByNames:=True:C214


Case of 
	: ($1=4)  // do as numbers  // ### bj ### 20181127_1825
		$thisTag:=<>jitTag
		If ((<>webPagesByNames) & ($tableNum>0))
			$0:=$thisTag+$tableName+<>midTag+$fieldName+$formatTag+<>endTag
		Else 
			$0:=$thisTag+$2+<>midTag+$3+$formatTag+<>endTag
		End if 
		// if doing xml
		// $0:="<"+$fieldName+">"+$0+"</"+$fieldName+">"
		// if doing xml
		
	: ($1=3)  // DreamWeaver  DW_BuildXML
		$formatTag:=""
		If ($1=3)  // ### bj ### 20181127_1834   This makes no sense
			$thisTag:=<>jitTag
		Else 
			$thisTag:=<>refTag
		End if 
		$doAsIs:=True:C214
		If (($tableNum>0) & ($tableNum<=Get last table number:C254))
			If (($fieldNum>0) & ($fieldNum<=Get last field number:C255($tableNum)))
				$0:=Tag_jit_FromNames($tableName; $fieldName; $thisTag; $formatTag)
				// $0:=$thisTag+$tableName+<>midTag+$fieldName+$formatTag+<>endTag
				$doAsIs:=False:C215
			End if 
		End if 
		If ($doAsIs)
			$0:=Tag_jit_FromNames($tableName; $fieldName; $thisTag)
			// $0:=$thisTag+$tableName+<>midTag+$fieldName+<>endTag
		End if 
		$0:="<"+$fieldName+">"+$0+"</"+$fieldName+">"
	: ($1=2)
		$formatTag:=""
		If ($1=3)  // ### bj ### 20181127_1834   This makes no sense
			$thisTag:=<>jitTag
		Else 
			$thisTag:=<>refTag
		End if 
		$doAsIs:=True:C214
		$0:=Tag_jit_FromNames($tableName; $fieldName; $thisTag; $formatTag)
		// $0:=$thisTag+$tableName+<>midTag+$fieldName+$formatTag+<>endTag
		$doAsIs:=False:C215
		
		If ($doAsIs)
			$0:=$thisTag+$2+<>midTag+$3+<>endTag
		End if 
	Else   //: ($1<2)  1 or zero determines the value or return tag
		$tableNum:=Num:C11($2)
		If ($1=1)
			$thisTag:=<>jitTag
		Else 
			$thisTag:=<>refTag
		End if 
		If ((<>webPagesByNames) & (Num:C11($2)>0))
			$0:=$thisTag+$tableName+<>midTag+$fieldName+$formatTag+<>endTag
		Else 
			$0:=$thisTag+$2+<>midTag+$3+$formatTag+<>endTag
		End if 
End case 