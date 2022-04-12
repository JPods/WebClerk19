//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 05/23/19, 07:46:22
// ----------------------------------------------------
// Method: GetStructureInfo
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($0; $voReturnObject)
C_BOOLEAN:C305($vbContinue)
$vbContinue:=True:C214

If (Type:C295(<>voTables)#Is undefined:K8:13)
	
	$voReturnObject:=<>voTables
	
	If (Count parameters:C259>0)
		
		C_TEXT:C284($1; $tableName)
		$tableName:=$1
		
		If (OB Is defined:C1231($voReturnObject; $tableName))
			$voReturnObject:=OB Get:C1224($voReturnObject; $tableName)
		Else 
			CLEAR VARIABLE:C89($voReturnObject)
			OB SET:C1220($voReturnObject; "Error"; "Table Name (parameter 1) is invalid.")
			$vbContinue:=False:C215
		End if 
		
	End if 
	
	If (Count parameters:C259>1)
		
		If ($vbContinue)
			
			C_TEXT:C284($2; $vtFieldName)
			$vtFieldName:=$2
			
			$voReturnObject:=OB Get:C1224($voReturnObject; "fields")
			
			If (OB Is defined:C1231($voReturnObject; $vtFieldName))
				$voReturnObject:=OB Get:C1224($voReturnObject; $vtFieldName)
			Else 
				CLEAR VARIABLE:C89($voReturnObject)
				OB SET:C1220($voReturnObject; "Error"; "Field Name (parameter 2) is invalid for the specified Table (parameter 1).")
			End if 
			
		End if 
		
	End if 
	
Else 
	
	OB SET:C1220($voReturnObject; "Error"; "Structure object has not been initialized. Please run InitStructureInfo.")
	
End if 

$0:=$voReturnObject