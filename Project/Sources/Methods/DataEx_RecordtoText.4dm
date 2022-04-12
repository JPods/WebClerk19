//%attributes = {"publishedWeb":true}

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
#DECLARE($tableName : Text; $obRec : Object)->$return : Collection
C_POINTER:C301($ptField)
C_OBJECT:C1216($obTable; $obField)
C_LONGINT:C283($viTableNum; $viFieldNum; $viType; $cntFields; $incFields)
C_TEXT:C284($vtFieldValue)
C_COLLECTION:C1488($cText)
$cText:=New collection:C1472
C_OBJECT:C1216($obField)
If (Count parameters:C259=0)
	$tableName:="Order"
	$obRec:=ds:C1482[$tableName].all().first()
End if 
$dsTable:=ds:C1482[$tableName]
$viTableNum:=$dsTable.getInfo().tableNumber
$cntFields:=Get last field number:C255($viTableNum)
C_OBJECT:C1216($obData)
For ($incFields; 1; $cntFields)
	$obData:=New object:C1471
	$ptField:=Field:C253($viTableNum; $incFields)
	$vtFieldName:=Field name:C257($ptField)
	$obField:=$dsTable[$vtFieldName]
	$typeFld:=$obField.fieldType
	
	Case of 
		: (($typeFld=Is alpha field:K8:1) | ($typeFld=Is text:K8:3))
			$vtFieldValue:=$obRec[$vtFieldName]
			
		: (($typeFld=Is real:K8:4) | ($typeFld=_o_Is float:K8:26))
			$vtFieldValue:=String:C10($obRec[$vtFieldName])
			
		: (($typeFld=Is longint:K8:6) | ($typeFld=Is integer 64 bits:K8:25))
			If ($obField.name="DT@")
				$vtFieldValue:=jDateTimeRBoth($obRec[$vtFieldName])
			Else 
				$vtFieldValue:=String:C10($obRec[$vtFieldName])
			End if 
			
		: ($typeFld=Is date:K8:7)
			$vtFieldValue:=String:C10($obRec[$vtFieldName]; Internal date short:K1:7)
			
		: ($typeFld=Is time:K8:8)
			$vtFieldValue:=String:C10($obRec[$vtFieldName])  //  QQQ how to do time; 5)  // HH MM AM PM)
			
		: ($typeFld=Is boolean:K8:9)
			If ($obRec[$vtFieldName])
				$vtFieldValue:="true"
			Else 
				$vtFieldValue:="false"
			End if 
			
		: ($typeFld=Is object:K8:27)
			$vtFieldValue:="is object"
		: ($typeFld=Is picture:K8:10)
			$vtFieldValue:="is picture"
		: ($typeFld=Is BLOB:K8:12)
			$vtFieldValue:="is blob"
		: ($typeFld=Is variant:K8:33)
			$vtFieldValue:="is variant"
		Else 
			$vtFieldValue:="undefined"
	End case 
	$obData[$vtFieldName]:=$vtFieldValue
	$obData.fieldObject:=$obField
	$cText.push($obData)
	//  $0:=$return
	// not sure if needed
End for 
$return:=$cText
