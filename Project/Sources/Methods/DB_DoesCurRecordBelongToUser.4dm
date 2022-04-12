//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 01/13/20, 11:58:28
// ----------------------------------------------------
// Method: DB_DoesCurRecordBelongToUser
// Description
// 
//
// Parameters
// ----------------------------------------------------
//
// Usage: DB_DoesCurRecordBelongToUser($vtResourceName;$voUser)

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_BOOLEAN:C305($0; $vbRecordBelongsToUser)
$vbRecordBelongsToUser:=False:C215

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

C_OBJECT:C1216($2; $voUser)
$voUser:=$2

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($vtInput; $vtOutput)

C_OBJECT:C1216($voResourceDefinition)

C_COLLECTION:C1488($vcOwnershipConditions)
$vcOwnershipConditions:=New collection:C1472

C_OBJECT:C1216($voOwnershipCondition)
$voOwnershipCondition:=New object:C1471

C_TEXT:C284($vtRecordValue; $vtComparisonValue)



//*************************************************************************************//
//** CHECK TO SEE IF THE CURRENT RECORD BELONGS TO THE USER ***************************//
//*************************************************************************************//

If ((WCR_IsResource($vtResourceName)) & (DB_RecordsInSelection($vtResourceName)=1))
	
	$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
	
	If (OB Is defined:C1231($voResourceDefinition.userOwnershipConditions; $voUser.type))
		$vcOwnershipConditions:=$voResourceDefinition.userOwnershipConditions[$voUser.type]
	End if 
	
	If ($vcOwnershipConditions.length>0)
		
		$vbRecordBelongsToUser:=True:C214
		
		For each ($voOwnershipCondition; $vcOwnershipConditions)
			
			$vtRecordValue:=String:C10(WCR_GetFieldPointer($vtResourceName; $voOwnershipCondition.fieldName)->)
			
			If ((OB Is defined:C1231($voOwnershipCondition; "userProperty")) | (OB Is defined:C1231($voOwnershipCondition; "value")))
				
				If (OB Is defined:C1231($voOwnershipCondition; "userProperty"))
					$vtComparisonValue:=String:C10($voUser[$voOwnershipCondition.userProperty])
				Else 
					$vtComparisonValue:=String:C10($voOwnershipCondition.value)
				End if 
				
				If ($vtRecordValue#$vtComparisonValue)
					$vbRecordBelongsToUser:=False:C215
				End if 
				
			End if 
			
		End for each 
		
	End if 
	
End if 

//*************************************************************************************//
//** RETURN THE RESULT ****************************************************************//
//*************************************************************************************//

$0:=$vbRecordBelongsToUser