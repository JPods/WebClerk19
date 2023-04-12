//%attributes = {}

// Modified by: Bill James (2022-12-14T06:00:00Z)
// Method: STR_FCGet
// Description 
// Parameters
// ----------------------------------------------------

#DECLARE($input_o : Object; $create : Boolean)->$rec : Object
If ($create)
	// UpdateWithResources by: Bill James (2023-01-07T06:00:00Z)
	// this should require authority level 5000
	
	$rec:=ds:C1482.FC.new()
	$rec.purpose:=$input_o.purpose
	$rec.tableName:=$input_o.dataClassName
	$rec.role:=$input_o.role
	If ($input_o.name=Null:C1517)
		$input_o.name:="Initial"
	End if 
	$rec.name:=$input_o.name  // not used
	If ($input_o.view=Null:C1517)
		$input_o.view:="default"
	End if 
	$rec.view:=$input_o.view  // not used
	
	If ($input_o.fields=Null:C1517)
		$input_o.fields:="id"
	End if 
	
	$rec.status:="new: "+String:C10(Current date:C33)
	$rec.comment:="/r/r"+Current user:C182+": "+$rec.status
	$rec.obGeneral:=Init_obGeneral
	$rec.data:=New object:C1471("views"; New object:C1471(\
		$input_o.view; \
		New object:C1471("fields"; $input_o.fields; \
		"columns"; Null:C1517; \
		"sfListbox"; Null:C1517; \
		"sfEntry"; Null:C1517)); \
		"editNot"; $input_o.editNo; \
		"viewNot"; "")
	
	//If ((Storage.user.securityLevel#Null) || (Storage.user.securityLevel>4999))
	//// allow editing of all fields
	//$rec.data
	//Else 
	//var $c : Collection
	//var $field : Text
	//For each ($field; ds[$input_o.dataClassName])
	//STR_GetFieldNames()
	//End for each 
	//$rec.data.views[$input_o.editNo]
	//End if 
	
	//$rec.save()
	
Else 
	$fc_s:=ds:C1482.FC.query("purpose = :1 and tableName = :2 "+\
		"and role = :3 and name = :4"; \
		$input_o.purpose; \
		$input_o.dataClassName; \
		$input_o.role; \
		$input_o.name)
	
	Case of 
		: ($fc_s.length>1)
			ConsoleLog("Multiple FC records, Form: "+$input_o.name+\
				"; dataClassName: "+$input_o.dataClassName+\
				"; count "+String:C10($fc_s.length))
			// clean up if there are multiple records
			// should $input_o. be automated?
			$rec:=$fc_s.first()
			$result:=$fc_s.minus($rec)
			$result.drop()
			
		: ($fc_s.length=1)
			$rec:=$fc_s.first()
			// if aspect are to be sent to the web, convert toObject()
			// specify the fields to be sent based on role
			
			
			If (($rec.data.views.default.fields="") & ($input_o.role="admin"))
				
				var $fields_c : Collection
				$fields_c:=STR_FieldCollection($input_o.dataClassName)
				$rec.data.fields:=$fields_c.join(";")
				$rec.save()
			End if 
			
		: (($input_o.name#"process_o") && ($fc_s.length=0))
			$rec:=STR_FCGet($input_o; True:C214)
	End case 
End if 