//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 03/22/18, 09:39:20
// ----------------------------------------------------
// Method: SelectionToJSON
// Description
// 
//      API_SelectionToObject
// Parameters
// ----------------------------------------------------

// SelectionToJSON returns paired fieldname and value


// similar
///  jsonRecordsToArray (->$obRecordArray;$tableName;$vtFieldList)

// RETURN VARIABLE
C_TEXT:C284($0; $vtOutput)
$0:=""
$vtOutput:=""

// PARAMETER 1 IS THE TABLE NAME THAT WE ARE CONVERTING
// TO JSON
C_TEXT:C284($1; $tableName)
$tableName:=$1




C_POINTER:C301($ptTable)
C_LONGINT:C283($viTableNum)
$ptTable:=STR_GetTablePointer($tableName)
If (Not:C34(Is nil pointer:C315($ptTable)))
	
	// PARAMETER 2 ARE THE FIELD NAMES
	C_TEXT:C284($2; $vtFieldNames)
	$vtFieldNames:=$2
	$vtFieldList:=""
	// $atFields
	ARRAY TEXT:C222($atFields; 0)
	GET TEXT KEYWORDS:C1141($vtFieldNames; $atFields)
	
	C_LONGINT:C283($findUUID)
	$findUUID:=Find in array:C230($atFields; "id")
	If ($findUUID>0)
		//id is already added
	Else 
		APPEND TO ARRAY:C911($atFields; "id")
	End if 
	
	// $voTemplate IS THE OBJECT TEMPLATE THAT WE WILL USE 
	// FOR THE JSON STRUCTURE
	C_OBJECT:C1216($voTemplate)
	
	// $vpFields HOLDS A REFERENCE TO THE FIELD WHICH WILL
	// BE PLACED IN THE OBJECT TEMPLATE
	C_POINTER:C301($vpField)
	
	C_LONGINT:C283($viTempTableNum; $viTempFieldNum)
	
	// SET AUTOMATIC RELATIONS TO TRUE
	
	SET AUTOMATIC RELATIONS:C310(True:C214; False:C215)
	
	For ($viInc; 1; Size of array:C274($atFields); 2)
		
		// $viTempTableNum:=STR_GetTableNumber ($atFields{$viInc})
		// do not mix tables
		// $viTempFieldNum:=STR_GetFieldNumber ($atFields{$viInc};$atFields{$viInc+1})
		
		$vpField:=STR_GetFieldPointer($tableName; $atFields{$viInc})
		
		If (Not:C34(Is nil pointer:C315($vpField)))
			
			//If ($viTempTableNum=$viTableNum)
			
			OB SET:C1220($voTemplate; $atFields{$viInc}; $vpField)
			If ($vtFieldList="")
				$vtFieldList:=$atFields{$viInc}  //$atFields{$viInc})
			Else 
				$vtFieldList:=$vtFieldList+","+$atFields{$viInc}  //Txt_Quoted ($vtFieldList)+","+Txt_Quoted ($atFields{$viInc})
			End if 
			//Else 
			
			//OB SET($voTemplate;$atFields{$viInc}+"_"+$atFields{$viInc+1};$vpField)
			
			//End if 
		End if 
		
	End for 
	
	C_OBJECT:C1216($obTable)
	$vtOutput:=Selection to JSON:C1234($ptTable->; $voTemplate)
	
	// RETURN THE OUTPUT
	$0:=$vtOutput
Else 
	$0:="Table not defined."
End if 
