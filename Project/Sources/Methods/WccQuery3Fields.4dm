//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/22/14, 14:58:53
// ----------------------------------------------------
// Method: WccQuery3Fields
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($theQuery)
$raySize:=10
$tableName:=WCapi_GetParameter("tableName"; "")
If ($tableName="")
	$tableName:=WCapi_GetParameter("TableName"; "")
	If ($tableName="")
		$tableName:=WCapi_GetParameter("table"; "")
		If ($tableName="")
			$tableName:=WCapi_GetParameter("Table"; "")
		End if 
	End if 
End if 
vtTableName:=$tableName
$tableNum:=STR_GetTableNumber($tableName)
viTableNum:=$tableNum

$allowEmpty:=WCapi_GetParameter("AllowEmpty"; "")
//
// ### jwm ### 20141022_1456 $allowEmpty="on" html Checkbox returns "ON"
If (($allowEmpty="1") | ($allowEmpty="t") | ($allowEmpty="y") | ($allowEmpty="Yes") | ($allowEmpty="ON"))
	$allowEmpty:="true"
End if 

$0:=$tableNum
$raySize:=20
$queryText:=""
C_LONGINT:C283($theType; $tableNum; $fieldNum; $recCount; $doQuery; $firstLine)
If ($tableNum>0)
	C_TEXT:C284(vResponseQuery)
	$i:=0
	$firstLine:=1
	Repeat 
		$i:=$i+1
		$queryField0:="Field"+String:C10($i)
		$queryValue0:="Value"+String:C10($i)
		$queryBoolean0:="Boolean"+String:C10($i)
		$queryOperator0:="Operator"+String:C10($i)
		//
		$queryField0:=WCapi_GetParameter("Field"+String:C10($i); "")  // $queryField0 
		If (($i=1) & ($queryField0=""))
			
			// Modified by: William James (2014-05-11T00:00:00 Subrecord eliminated)
			
			$queryField0:=WCapi_GetParameter("Field"; "")  // Allow no number on the first item, notably when there is only one field being searched
		End if 
		If ($queryField0="")
			$queryField0:=WCapi_GetParameter("FieldName"+String:C10($i); "")
			If ($queryField0="")
				$queryField0:=WCapi_GetParameter("QueryField"+String:C10($i); "")
			End if 
		End if 
		
		$queryValue0:=WCapi_GetParameter("Value"+String:C10($i); "")  // $queryValue0
		If (($i=1) & ($queryValue0=""))
			$queryValue0:=WCapi_GetParameter("Value"; "")  // Allow no number on the first item, notably when there is only one field being searched
		End if 
		If ($queryValue0="")
			$queryValue0:=WCapi_GetParameter("QueryValue"+String:C10($i); "")
		End if 
		
		
		$queryBoolean0:=WCapi_GetParameter("Boolean"+String:C10($i); "")  // $queryBoolean0
		If (($i=1) & ($queryBoolean0=""))
			$queryBoolean0:=WCapi_GetParameter("Boolean"; "")  // Allow no number on the first item, notably when there is only one field being searched
		End if 
		If ($queryBoolean0="")
			$queryBoolean0:=WCapi_GetParameter("QueryBoolean"+String:C10($i); "")
		End if 
		
		
		$queryOperator0:=WCapi_GetParameter("Operator"+String:C10($i); "")  //  $queryOperator0
		If (($i=1) & ($queryOperator0=""))
			$queryOperator0:=WCapi_GetParameter("Operator"; "")  // Allow no number on the first item, notably when there is only one field being searched
		End if 
		If ($queryOperator0="")
			$queryOperator0:=WCapi_GetParameter("QueryOperator"+String:C10($i); "")
		End if 
		//
		$fieldNum:=STR_GetFieldNumber($tableName; $queryField0)
		Case of 
			: ($fieldNum<1)
				$i:=-1
			: (($queryValue0#"") | ($allowEmpty="true") | ($queryOperator0="@blank@"))  // ### jwm ### 20141022_1146 new blank operators
				If ($firstLine=1)
					$firstLine:=2
					$queryBoolean0:="single"
				End if 
				$theQuery:=$theQuery+QueryBuild($tableNum; $fieldNum; $queryBoolean0; $queryOperator0; $queryValue0)
		End case 
	Until ($i=-1)
	vURLQueryScript:=$theQuery
	If ($theQuery#"")
		$theQuery:=$theQuery+"Query(["+$tableName+"])"
		vURLQueryScript:=$theQuery
		ExecuteText(0; $theQuery)
	End if 
Else 
	C_TEXT:C284($tableName; $fieldName1)
	vResponse:="Error: TableName: "+$tableName+" or FieldName: "+$fieldName1+" not correct"
End if 

