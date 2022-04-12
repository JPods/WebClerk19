//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/01/20, 12:16:11
// ----------------------------------------------------
// Method: SE_javaScriptLoadSubmit
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1; $tableName)
C_TEXT:C284($2; $vtAdder)
C_TEXT:C284($vtReturn; $3)
$vtReturn:="val"
If (Count parameters:C259>0)
	$tableName:=$1
	If (Count parameters:C259>1)
		$vtAdder:=$2
		If (Count parameters:C259>2)
			$vtReturn:=$3
		End if 
	End if 
Else 
	$tableName:=Table name:C256(curTableNum)
End if 

C_LONGINT:C283($i; $k; $viElement)
$k:=Size of array:C274(aFieldLns)

C_TEXT:C284($vtJavaScript)
$vtJavaScript:="<script>\r"
$vtJavaScript:=$vtJavaScript+"$(document).ready(function(){\r"
$vtJavaScript:=$vtJavaScript+"   show"+$tableName+"Record ();\r"
$vtJavaScript:=$vtJavaScript+"}\r"
$vtJavaScript:=$vtJavaScript+");\r\r\r"
$vtJavaScript:=$vtJavaScript+"function show"+$tableName+"Record () {\r"
$vtJavaScript:=$vtJavaScript+"  var url = \"ajax_GetRecord?TableName="+$tableName+"&id=_jit_"+$tableName+"_UUIDKeyjj\";\r"
$vtJavaScript:=$vtJavaScript+"  $.get(url, function (data, status) {\r"
$vtJavaScript:=$vtJavaScript+"    var obj = data; {\r"
For ($i; 1; $k)
	$vtJavaScript:=$vtJavaScript+"    $(\"#"+$vtAdder+$tableName+"_"+theFields{aFieldLns{$i}}+"\")."+$vtReturn+"(obj."+$tableName+"_"+theFields{aFieldLns{$i}}+");  \r"
End for 
$vtJavaScript:=$vtJavaScript+"    }\r"
$vtJavaScript:=$vtJavaScript+"  }); \r"
$vtJavaScript:=$vtJavaScript+"}\r\r\r\r"
$vtJavaScript:=$vtJavaScript+"$(document).ready(function(){\r"
$vtJavaScript:=$vtJavaScript+"   $(\"#"+$tableName+"SubmitBtn\").click(function () {\r"
$vtJavaScript:=$vtJavaScript+"       submit"+$tableName+"Record();\r"
$vtJavaScript:=$vtJavaScript+"});\r"
$vtJavaScript:=$vtJavaScript+"}\r"
$vtJavaScript:=$vtJavaScript+");\r\r\r"

$vtJavaScript:=$vtJavaScript+"function submit"+$tableName+"Record () {\r"
$vtJavaScript:=$vtJavaScript+"  combineComments();\r"
$vtJavaScript:=$vtJavaScript+"  var url = \"ajax_SaveRecord\";\r"
$vtJavaScript:=$vtJavaScript+"  var obj = {\r"
$vtJavaScript:=$vtJavaScript+"    \"TableName\": \""+$tableName+"\",\r"
For ($i; 1; $k)
	$vtJavaScript:=$vtJavaScript+"    \""+$tableName+"_"+theFields{aFieldLns{$i}}+"\": $(\"#"+$tableName+"_"+theFields{aFieldLns{$i}}+"\").val()"
	If ($i<$k)
		$vtJavaScript:=$vtJavaScript+",\r"
	Else 
		$vtJavaScript:=$vtJavaScript+"\r"
	End if 
End for 
$vtJavaScript:=$vtJavaScript+"  }\r"
$vtJavaScript:=$vtJavaScript+"  var payloadData = JSON.stringify(obj);\r"
$vtJavaScript:=$vtJavaScript+"  $.post(url, payloadData, function (data, status) {\r\r\r"

$vtJavaScript:=$vtJavaScript+"  });\r"
$vtJavaScript:=$vtJavaScript+"}\r"
$vtJavaScript:=$vtJavaScript+"}\r<\\script>\r"

$0:=$vtJavaScript