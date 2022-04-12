//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/22/21, 21:44:19
// ----------------------------------------------------
// Method: CamelCase_ToCatalog
// Description
// 
//
// Parameters
// ----------------------------------------------------


// applies to catalog.

C_COLLECTION:C1488($cFieldNames; $cDistinct)
C_TEXT:C284($vtFieldName; $vtCamelCase; $vtXML)
C_LONGINT:C283($incTable; $incField)
C_LONGINT:C283($findTable)
C_TIME:C306($myDoc; $changeDoc; $saveDoc)
C_TEXT:C284($1; $0)
If (Count parameters:C259=0)
	$myDoc:=Open document:C264("")
	If (OK=1)
		CLOSE DOCUMENT:C267($myDoc)
		$vtXML:=Document to text:C1236(Document)
	End if 
Else 
	$vtXML:=$1
End if 
// Get a list of all the field names by reading the XML catalog.4DCatalog  
$cFieldNames:=New collection:C1472
$cDistinct:=New collection:C1472
For ($incTable; 1; Get last table number:C254)  //Loop for files
	For ($incField; 1; Get last field number:C255($incTable))  //Loop for fields
		$vtFieldName:=Field name:C257(Field:C253($incTable; $incField))
		
		Case of 
			: ($vtFieldName="")
				
			: ($vtFieldName="UUID@")
				TRACE:C157
				$cFieldNames.push($vtFieldName)
			Else 
				//$findTable:=find in array(<>aTableNames;$vtFieldName)
				If ($findTable>0)  // ((Length($vtFieldName)<3) & ($vtFieldName#"id"))
					// missing lines
					TRACE:C157
				End if 
				$cFieldNames.push($vtFieldName)
		End case 
	End for 
End for 
// consolidate to a distinct list
C_TEXT:C284($vtReport; $vtDoTask)
$cDistinct:=$cFieldNames.distinct()

//  $vtDoTask is set to give one of two reports
For each ($vtFieldName; $cDistinct)
	Case of 
		: ($vtDoTask="list")
			// report the list of distinct field names to pasteboard
			$vtReport:=$vtReport+"\r"+$vtFieldName
		: ($vtDoTask="tables")
			// report if there are any fields named the same as tables. 
			// changing the XML catalog name=" can be for a table or field
			$findTable:=Find in array:C230(<>aTableNames; $vtFieldName)
			If ($findTable>0)  // ((Length($vtFieldName)<3) & ($vtFieldName#"id"))
				// missing lines
				$vtReport:=$vtReport+"\r"+<>aTableNames{$findTable}
			End if 
	End case 
End for each 
If (False:C215)
	SET TEXT TO PASTEBOARD:C523($vtReport)
End if 


// loop through the catalog and change the field values
For each ($vtFieldName; $cDistinct)
	$vtCamelCase:=camelCase_FixFieldName($vtFieldName)
	If ($vtXML#"")
		$vtXML:=Replace string:C233($vtXML; "name=\""+$vtFieldName+"\""; "name=\""+$vtCamelCase+"\"")
	End if 
End for each 

If (False:C215)
	SET TEXT TO PASTEBOARD:C523($vtReport)
End if 
$saveDoc:=Create document:C266("")
If (OK=1)
	CLOSE DOCUMENT:C267($saveDoc)
	TEXT TO DOCUMENT:C1237(Document; $vtXML)
End if 