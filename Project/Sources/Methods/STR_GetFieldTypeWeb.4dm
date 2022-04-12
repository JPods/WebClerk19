//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/03/20, 18:01:00
// ----------------------------------------------------
// Method: STR_GetFieldTypeWeb
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($1; $tableName)
C_TEXT:C284($2; $vtFieldName; $vtType)
C_OBJECT:C1216($obStore; $obClass; $obSel; $obField)

$tableName:=$1
$vtFieldName:=$2

$obSel:=ds:C1482[$tableName].new()
If ($obSel#Null:C1517)
	$obDataClass:=$obSel.getDataClass()
	$obField:=$obDataClass[$vtFieldName]
	If ($obField#Null:C1517)
		$vtType:=$obField.type
	End if 
End if 
$0:=$vtType


//   dataClassAttribute.autoFilled  
//   dataClassAttribute.fieldNumber  
//   dataClassAttribute.fieldType  
//   dataClassAttribute.indexed  
//   dataClassAttribute.inverseName  
//   dataClassAttribute.keyWordIndexed  
//   dataClassAttribute.kind  
//   dataClassAttribute.mandatory  
//   dataClassAttribute.name  
//   dataClassAttribute.relatedDataClass  
//   dataClassAttribute.type  
//   dataClassAttribute.unique  

If (False:C215)
	Case of 
		: ($viType=Is alpha field:K8:1)  // 0
			$type:="Alpha"
			
		: ($viType=Is real:K8:4)  // 1
			$type:="Real"
			
		: ($viType=Is text:K8:3)  // 2
			$type:="Text"
			
		: ($viType=Is picture:K8:10)  // 3
			$type:="Picture"
			
		: ($viType=Is date:K8:7)  // 4
			$type:="Date"
			
		: ($viType=Is boolean:K8:9)  // 6
			$type:="Boolean"
			
		: ($viType=Is subtable:K8:11)  // 7
			$type:="SubTable"
			
		: ($viType=Is integer:K8:5)  // 8
			$type:="Integer"
			
		: ($viType=Is longint:K8:6)  // 9
			$type:="LongInt"
			
		: ($viType=Is time:K8:8)  // 11
			$type:="Time"
			
		: ($viType=Is integer 64 bits:K8:25)  // 25
			$type:="Int64"
			
		: ($viType=Is BLOB:K8:12)  // 30
			$type:="Blob"
			
		: ($viType=_o_Is float:K8:26)  // 35
			$type:="Float"
			
		: ($viType=Is object:K8:27)  // 38
			$type:="Object"
			
			
			
		Else 
			$type:="Unknown"
	End case 
End if 