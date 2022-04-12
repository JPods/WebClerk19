//%attributes = {}


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/24/19, 21:07:34
// ----------------------------------------------------
// Method: oloDTVariables
// Description
// creates and fills a date time variable for all date time fields in a table
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($viFieldNum; $viTableNum)
C_TEXT:C284($vtFieldName; $vtVariable)
C_POINTER:C301($vpField; $vpVariable)

$viTableNum:=Table:C252(ptCurTable)

For ($viFieldNum; 1; Get last field number:C255(ptCurTable))
	
	If (Is field number valid:C1000($viTableNum; $viFieldNum))  // field number is valid
		
		$vtFieldName:=Field name:C257($viTableNum; $viFieldNum)  // get field name
		
		If ($vtFieldName="DT@")  // Field Name begins with DT
			
			$vtVariable:="vt"+$vtFieldName  // build variable name
			$vpVariable:=Get pointer:C304($vtVariable)  // get pointer to variable
			$vpField:=Field:C253($viTableNum; $viFieldNum)  // get pointer to field
			$vpVariable->:=jDateTimeRBoth($vpField->)  // set variable to date time string
			
			//ConsoleMessage ($vtFieldName+"\t"+String($vpField->)+"\t"+$vpVariable->)
			
		End if   // Field Name begins with DT
		
	End if   // field number valid
	
End for 