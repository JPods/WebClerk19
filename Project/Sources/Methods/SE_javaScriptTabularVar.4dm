//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/22/20, 10:47:17
// ----------------------------------------------------
// Method: SE_javaScriptTabularVar
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($obTabular)
C_TEXT:C284($tableName; $vtQueryField; $vtStringified)
$vtQueryField:="CustomersID"
$tableName:="Customer"

$obTabular:=New object:C1471
$obTabular.ajaxURL:="/ajax_QueryField?TableName="+$tableName+"&Field1="+$vtQueryField+"&Value1=\" + $(\"#Customers_customerID\").text() + \"&Operator1=equal&jitFieldList="+$tableName+"FieldListWcc.txt"
$obTabular.detailUrl:="/WCC_QueryUUIDKey?tableName="+$tableName+"&jitPageOne=Wcc"+$tableName+"One.html&id="

$vtStringified:=JSON Stringify:C1217($obTabular)