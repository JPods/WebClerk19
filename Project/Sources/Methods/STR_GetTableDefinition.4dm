//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: STR_GetTableDefinition
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

#DECLARE($tableName : Text)->$dataClass : Object
$dataClass:=ds:C1482[$tableName]


If (False:C215)
	// HOWTO:
	//C_OBJECT($1; $entity; $entityContent; $newEntity; $status)
	//C_OBJECT($2; $attribute)
	var $text : Text
	
	$text:=JSON Stringify:C1217(ds:C1482.Customer.id)
	If (Undefined:C82(ds:C1482.Customer.sdfasd))
		
	End if 
	
	If (ds:C1482.Customer.sdfasd)
	End if 
	
	$entity:=ds:C1482.Customer  // $1
	//$attribute:="address1"  // $2
	
	$newEntity:=$entity.getDataClass().new()
	
	$entityContent:=$entity.toObject("address1.*")
	//We copy address from the received entity
	$newEntity.fromObject($entityContent)
	
	//We fill the created entity with received property name and value
	$newEntity[$attribute.name]:=$attribute.value
	$status:=$newEntity.save()
	
End if 