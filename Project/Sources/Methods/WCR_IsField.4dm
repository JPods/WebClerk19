//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 06/17/19, 11:15:54
// ----------------------------------------------------
// Method: WCR_IsResource
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_BOOLEAN:C305($0; $vbIsField)

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=Lowercase:C14($1)

C_TEXT:C284($2; $vtFieldName)
$vtFieldName:=Lowercase:C14($2)

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($tableName)

// ******************************************************************************************** //
// ** TEST TO SEE IF THE RESOURCENAME IS JUST A TRUE TABLE. IF NOT, CHECK IF IT IS A RESOURCE * //
// ******************************************************************************************** //

If (STR_IsField($vtResourceName; $vtFieldName))
	
	$vbIsField:=True:C214
	
Else 
	
	CREATE SET:C116([GenericChild2:91]; "TempSet_WCRIsResource")
	
	QUERY:C277([GenericChild2:91]; [GenericChild2:91]purpose:4="WebClerkResource"; *)
	QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]name:3=$vtResourceName; *)
	QUERY:C277([GenericChild2:91])
	
	If (Records in selection:C76([GenericChild2:91])>0)
		
		$tableName:=OB Get:C1224([GenericChild2:91]obGeneral:47; "tableName")
		
		If (STR_IsField($tableName; $vtFieldName))
			
			$vbIsField:=True:C214
			
		Else 
			
			$vbIsField:=False:C215
			
		End if 
		
	Else 
		
		$vbIsField:=False:C215
		
	End if 
	
	UNLOAD RECORD:C212([GenericChild2:91])
	REDUCE SELECTION:C351([GenericChild2:91]; 0)
	USE SET:C118("TempSet_WCRIsResource")
	CLEAR SET:C117("TempSet_WCRIsResource")
	
End if 

// ******************************************************************************************** //
// ** RETURN A BOOLEAN SHOWING IF THE PASSED RESOURCE NAME IS REALLY A RESOURCE *************** //
// ******************************************************************************************** //

$0:=$vbIsField