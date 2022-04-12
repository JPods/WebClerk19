//%attributes = {}
//*************************************************************************************//
//** GLOBAL & INTERPROCESS VARIABLES USED *********************************************//
//*************************************************************************************//

// GLOBAL VARIABLES USED
//
// PROCESS VARIABLES USED:
// vtResourceName, filled out before TallyMaster is called
// voResponse, initialized empty in Kepler_InitPageRequest
//
// PSEUDO-RETURN VIA PROCESS VARIABLE:
// voResponse
//



//*************************************************************************************//
//** TYPE AND INITIALIZE LOCAL VARIABLES **********************************************//
//*************************************************************************************//

C_TEXT:C284($vtDefaultFieldNames; $vtUniqueIDFieldName; $vtResourceName; $tableName; $vtFieldName)
C_BOOLEAN:C305($vbCreateable)
C_LONGINT:C283($viCounter)
ARRAY OBJECT:C1221($aoRecords; 0)
ARRAY TEXT:C222($atDefaultFieldNames; 0)
ARRAY TEXT:C222($atDefaultFieldNamesOverride; 0)
ARRAY TEXT:C222($atAllowedActions; 0)
ARRAY TEXT:C222($atAllowedResourceNames; 0)



//*************************************************************************************//
//** CHECK IF RESOURCE NAME IS VALID **************************************************//
//*************************************************************************************//

$vtResourceName:=vtResourceName

If (WCR_IsResource($vtResourceName)=False:C215)
	
	vrErrorCode:=500.21
	vResponse:="The specified resource is invalid."
	
End if 



//*************************************************************************************//
//** BUILD OUT DATA BASED ON RESOURCE TYPE ********************************************//
//*************************************************************************************//

If (vrErrorCode=0)
	
	// FILL IN DEFAULTS
	
	$vtUniqueIDFieldName:="idNum"
	$vbCreateable:=False:C215
	
	// LOAD RESOURCE INFO
	
	$voResource:=WCR_GetResourceDefinition($vtResourceName)
	$tableName:=OB Get:C1224($voResource; "tableName")
	$vtUniqueIDFieldName:=OB Get:C1224($voResource; "uniqueFieldName")
	
	// CHECK TO SEE IF THIS RESOURCE IS CREATBLE VIA WEBCLERK
	
	OB GET ARRAY:C1229($voResource; "allowedActions"; $atAllowedActions)
	If (Find in array:C230($atAllowedActions; "addSingle")>-1)
		$vbCreateable:=True:C214
	End if 
	
	// LOAD THE DEFAULT FIELD NAMES FOR THIS RESOURCE
	
	If (OB Is defined:C1231($voResource; "defaultFields"))
		OB GET ARRAY:C1229($voResource; "defaultFields"; $atDefaultFieldNames)
	Else 
		OB GET ARRAY:C1229($voResource; "displayFieldNames"; $atDefaultFieldNames)
	End if 
	$vtDefaultFieldNames:=TextFromArray(->$atDefaultFieldNames; ";")
	CLEAR VARIABLE:C89($atDefaultFieldNames)
	
	// CHECK FOR OVERRIDES TO DEFAULT FIELDS
	
	If (WCapi_GetParameter("fieldNames"; "")#"")
		
		$vtDefaultFieldNames:=""
		C_TEXT:C284($vtFieldName)
		
		GET TEXT KEYWORDS:C1141(WCapi_GetParameter("fieldNames"; ""); $atDefaultFieldNamesOverride)
		
		For ($viCounter; 1; Size of array:C274($atDefaultFieldNamesOverride))
			
			$vtFieldName:=$atDefaultFieldNamesOverride{$viCounter}
			
			If (Position:C15("_"; $vtFieldName)>0)
				
				$vtFieldName:=";["+Replace string:C233($vtFieldName; "_"; "]")
				
			Else 
				
				$vtFieldName:=";["+$tableName+"]"+$vtFieldName
				
			End if 
			
			$vtDefaultFieldNames:=$vtDefaultFieldNames+$vtFieldName
			
		End for 
		
		$vtDefaultFieldNames:=Substring:C12($vtDefaultFieldNames; 2)
		
	End if 
	
	If ($vtDefaultFieldNames="")
		$vtDefaultFieldNames:="["+$tableName+"]"+$vtUniqueIDFieldName
	End if 
	
End if 



//*************************************************************************************//
//** BUILD RESPONSE OBJECT ************************************************************//
//*************************************************************************************//

If (vrErrorCode=0)
	
	JSON PARSE ARRAY:C1219(SelectionToJSON($tableName; $vtDefaultFieldNames); $aoRecords)
	
	$vtDefaultFieldNames:=Replace string:C233($vtDefaultFieldNames; "["+$tableName+"]"; "")
	$vtDefaultFieldNames:=Replace string:C233($vtDefaultFieldNames; "["; "")
	$vtDefaultFieldNames:=Replace string:C233($vtDefaultFieldNames; "]"; "_")
	GET TEXT KEYWORDS:C1141($vtDefaultFieldNames; $atDefaultFieldNames)
	
	// ### bj ### 20200326_0736 commented out to compile
	//OB SET ARRAY(voResponse;"records";$aoRecords)
	//OB SET ARRAY(voResponse;"allFields";Get pointer("<>a"+$tableName+"_FL")->)
	//OB SET ARRAY(voResponse;"defaultFields";$atDefaultFieldNames)
	//OB SET(voResponse;"uniqueIDKey";$vtUniqueIDFieldName)
	//OB SET(voResponse;"resourceName";$vtResourceName)
	//OB SET(voResponse;"creatable";$vbCreateable)
	
	vResponse:="Success"
	
End if 