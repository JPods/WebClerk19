//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/29/21, 07:11:25
// ----------------------------------------------------
// Method: 19CVT_CaptureOutputFields
// Description
//
// Parameters
// ----------------------------------------------------
var $1; $tableName; $vtProperty; $vtWorking : Text
var $obEach; $obFields; $obWorking : Object
$vtFieldList:=""
$obWorking:=JSON Parse:C1218($1)
If ($obWorking#Null:C1517)
	$obFields:=$obWorking.pages[1].objects
	
	var $vtFieldList; $vtFieldOne : Text
	ARRAY TEXT:C222($atFields; 0)
	
	
	For each ($vtProperty; $obFields)
		If ($vtProperty="Field@")
			$vtFieldOne:=$obFields[$vtProperty].dataSource
			
			$tableName:=Substring:C12($fieldName_t; 2; Position:C15(":"; $fieldName_t)-2)
			
			$vtFieldOne:=Substring:C12($vtFieldOne; Position:C15("]"; $vtFieldOne)+1; Length:C16($vtFieldOne))
			$vtFieldOne:=Substring:C12($vtFieldOne; 1; Position:C15(":"; $vtFieldOne)-1)
			$vtFieldList:=$vtFieldList+$vtFieldOne+","
		End if 
	End for each 
	If ($vtFieldList#"")
		$vtFieldList:=Substring:C12($vtFieldList; 1; Length:C16($vtFieldList)-1)
	End if 
	
	var $obTableOutput : Object
	$obTableOutput:=New object:C1471("tableName"; tableName; "textNames"; $vtFieldList)
	LBX_oLoDefaultSave($obTableOutput)
End if 

If (False:C215)  //test some time
	// should be identical to the above with a change in naming convention
	
	var $1; $tableName; $vtProperty; $vtWorking : Text
	var $fields_o; $obEach; $working_o : Object
	$fieldList_t:=""
	$working_o:=JSON Parse:C1218($1)
	If ($working_o#Null:C1517)
		$fields_o:=$working_o.pages[1].objects
		
		var $fieldList_t; $fieldName_t : Text
		ARRAY TEXT:C222($atFields; 0)
		
		
		For each ($vtProperty; $fields_o)
			If ($vtProperty="Field@")
				$fieldName_t:=$fields_o[$vtProperty].dataSource
				
				$tableName:=Substring:C12($fieldName_t; 2; Position:C15(":"; $fieldName_t)-2)
				
				$fieldName_t:=Substring:C12($fieldName_t; Position:C15("]"; $fieldName_t)+1; Length:C16($fieldName_t))
				$fieldName_t:=Substring:C12($fieldName_t; 1; Position:C15(":"; $fieldName_t)-1)
				$fieldList_t:=$fieldList_t+$fieldName_t+","
			End if 
		End for each 
		If ($fieldList_t#"")
			$fieldList_t:=Substring:C12($fieldList_t; 1; Length:C16($fieldList_t)-1)
		End if 
		
		var $obTableOutput : Object
		$obTableOutput:=New object:C1471("tableName"; tableName; "textNames"; $fieldList_t)
		LBX_oLoDefaultSave($obTableOutput)
	End if 
	
End if 