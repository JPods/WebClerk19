//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/15/21, 00:41:55
// ----------------------------------------------------
// Method: DataEx_FieldToText
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($tableName : Text; $vtFieldName : Text)->$return : Text
C_POINTER:C301($ptField)
C_OBJECT:C1216($obTable; $obField)
C_LONGINT:C283($viTableNum; $viFieldNum; $viType)
If (Count parameters:C259=0)
	$tableName:="Order"
	$vtFieldName:="company"
End if 
$dsTable:=ds:C1482[$tableName]
$viTableNum:=$obTable.getInfo().tableNumber
$obField:=ds:C1482[$tableName][$vtFieldName]
$viFieldNum:=$obField.fieldNumber
$typeFld:=$obField.fieldType
$ptField:=Field:C253($viTableNum; $viFieldNum)
Case of 
	: (($typeFld=Is alpha field:K8:1) | ($typeFld=Is text:K8:3))
		$return:=$ptField->
		
	: (($typeFld=Is real:K8:4) | ($typeFld=_o_Is float:K8:26))
		$return:=String:C10($ptField->)
		
	: (($typeFld=Is longint:K8:6) | ($typeFld=Is integer 64 bits:K8:25))
		If ($obField.fieldName="DT@")
			$return:=jDateTimeRBoth($ptField->)
		Else 
			$return:=String:C10($ptField->)
		End if 
		
	: ($typeFld=Is date:K8:7)
		$return:=String:C10($ptField->; Internal date short:K1:7)
		
	: ($typeFld=Is time:K8:8)
		$return:=String:C10($ptField->; HH MM AM PM:K7:5)
		
	: ($typeFld=Is boolean:K8:9)
		If ($ptField->)
			$return:="true"
		Else 
			$return:="false"
		End if 
		
	: ($typeFld=Is object:K8:27)
		$return:="Error: is object"
	: ($typeFld=Is picture:K8:10)
		$return:="Error: is picture"
	: ($typeFld=Is BLOB:K8:12)
		$return:="Error: is blob"
	Else 
		$return:="undefined"
End case 
//  $0:=$return
// not sure if needed
