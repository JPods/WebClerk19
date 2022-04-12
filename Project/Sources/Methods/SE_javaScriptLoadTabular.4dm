//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/21/20, 20:54:02
// ----------------------------------------------------
// Method: SE_javaScriptLoadTabular
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

$vtQueryField:="CustomersID"

C_LONGINT:C283($i; $k; $viElement)
$k:=Size of array:C274(aFieldLns)

C_TEXT:C284($vtJavaScript)
$vtJavaScript:="<script>\r"
$vtJavaScript:=$vtJavaScript+"$(document).ready(function(){\r"
$vtJavaScript:=$vtJavaScript+"   show"+$tableName+"Table ();\r"
$vtJavaScript:=$vtJavaScript+"}\r"
$vtJavaScript:=$vtJavaScript+");\r\r\r"


$vtJavaScript:=$vtJavaScript+"function show"+$tableName+"Table () {\r"
$vtJavaScript:=$vtJavaScript+"   var table = new Tabulator(\"#"+$tableName+"Table\", {\r"

C_TEXT:C284($vtQuery)

$vtQuery:="/ajax_QueryField?TableName="+$tableName+"&Field1="+$vtQueryField+"&Value1=\" + $(\"#Customers_customerID\").text() + \"&Operator1=equal&jitFieldList="+$tableName+"FieldListWcc.txt"
$vtJavaScript:=$vtJavaScript+"    ajaxURL: \""+$vtQuery+"\",\r"
$vtJavaScript:=$vtJavaScript+"    detailUrl: \"/WCC_QueryUUIDKey?tableName="+$tableName+"&jitPageOne=Wcc"+$tableName+"One.html&id=\",\r"
$vtJavaScript:=$vtJavaScript+"    index: \""+$tableName+"_UUIDKey\",\r"

$vtJavaScript:=$vtJavaScript+"    pagination: \"local\", \r"
$vtJavaScript:=$vtJavaScript+"    paginationSize: 10, \r"
$vtJavaScript:=$vtJavaScript+"    title: \""+$tableName+":\",\r"
$vtJavaScript:=$vtJavaScript+"    topColor: \"lightblue\",\r"
$vtJavaScript:=$vtJavaScript+"    layout: \"fitDataFill\",\r"
$vtJavaScript:=$vtJavaScript+"    responsiveLayout:\"collapse\",\r"
$vtJavaScript:=$vtJavaScript+"    initialSort: [\r"
$vtJavaScript:=$vtJavaScript+"       { column: \""+$tableName+"_"+"ActionDate\", dir: \"desc\" },\r"
$vtJavaScript:=$vtJavaScript+"       { column: \""+$tableName+"_"+"ActionBy\", dir: \"asc\" },\r"
$vtJavaScript:=$vtJavaScript+"    ],\r"
$vtJavaScript:=$vtJavaScript+"    columns: [\r"
$vtJavaScript:=$vtJavaScript+"      {\r"
C_TEXT:C284($vtLable; $vtAlign; $vtSorter; $vtFormatter; $vtFormatParams)
$vtAlign:="left"
$vtSorter:="date"
$vtFormatParams:=", formatterParams: { symbol: \"$\" }"
For ($i; 1; $k)
	If ($i=1)
		$vtJavaScript:=$vtJavaScript+"      title: \""+theFields{aFieldLns{$i}}+"\", field: \""+$tableName+"_"+theFields{aFieldLns{$i}}+"\", formatter: \"link\", "
		$vtJavaScript:=$vtJavaScript+"formatterParams: {\r"
		$vtJavaScript:=$vtJavaScript+"        labelField: \""+$tableName+"_"+theFields{aFieldLns{$i}}+"\", urlField: \""+$tableName+"_UUIDKey\", "
		$vtJavaScript:=$vtJavaScript+"urlPrefix: \"WCC_QueryUUIDKey?tableName="+$tableName+"&jitPageOne=Wcc"+$tableName+"One.html&id=\"\r"
		$vtJavaScript:=$vtJavaScript+"        }\r"
		$vtJavaScript:=$vtJavaScript+"      }"
	Else 
		$vtJavaScript:=$vtJavaScript+"      { title: \""+theFields{aFieldLns{$i}}+"\", field: \""+$tableName+"_"+theFields{aFieldLns{$i}}+"\", "
		$vtJavaScript:=$vtJavaScript+"align: \""+$vtAlign+"\", sorter: \""+$vtSorter+"\""+$vtFormatParams+", formatter: \""+$vtFormatter+"\"}"
	End if 
	If ($i<$k)
		$vtJavaScript:=$vtJavaScript+",\r"
	Else 
		$vtJavaScript:=$vtJavaScript+"\r"
	End if 
End for 

$vtJavaScript:=$vtJavaScript+"    ],"

$vtJavaScript:=$vtJavaScript+"  });\r"
$vtJavaScript:=$vtJavaScript+"}\r"
$vtJavaScript:=$vtJavaScript+"}\r<\\script>\r"

$0:=$vtJavaScript