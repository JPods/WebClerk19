//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/16/20, 23:27:14
// ----------------------------------------------------
// Method: KeyWordsMake
// Description
//
//
// Parameters
// ----------------------------------------------------

var $1 : Variant
var $ptTable : Pointer
var $2; $vbLoadFromKeyText : Boolean
var $ptFieldOb; $ptFieldTags; $ptFieldText; $ptID : Pointer
var $viTableNum : Integer
var $tableName; $vtTags : Text

var $entity_o : Object

If (Count parameters:C259=0)
	$ptTable:=ptCurTable
Else 
	If (Value type:C1509($1)=Is object:K8:27)
		// QQQ clean this up to just using ORDA
		$viTableNum:=$1.getDataClass().getInfo().tableNumber
		$ptTable:=Table:C252($viTableNum)
		$tableName:=Table name:C256($ptTable)
		$ptID:=STR_Get_idPointer($tableName)
		$doEntity:=True:C214
		$1.save()
		$entity_o:=$1
	Else   // (Type($1)=Is pointer)
		$ptTable:=$1
		$viTableNum:=Table:C252($ptTable)
		$tableName:=Table name:C256($ptTable)
		$ptID:=STR_Get_idPointer($tableName)
		$entity_o:=ds:C1482[$tableName].query("id = :1"; $ptID->).first()
		
		
		
		$entity_o:=ds:C1482[$tableName].get($ptID->)  //access the employee with ID 
		UNLOAD RECORD:C212($ptTable->)
	End if 
End if 

$vtTags:=KeyTagsFromAlphaFields($entity_o)

If ($doEntity=False:C215)
	LOAD RECORD:C52($ptTable->)
End if 



