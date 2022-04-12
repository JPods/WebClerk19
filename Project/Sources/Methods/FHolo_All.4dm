//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/22/21, 12:46:25
// ----------------------------------------------------
// Method: FormHead_olo_All
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tableName; vtTableName)
If (Count parameters:C259=0)
	If (vtTableName="")
		vtTableName:="Customer"
	End if 
Else 
	If (Count parameters:C259>0)
		$tableName:=$1
		// define the form object
	End if 
End if 
entSel:=ds:C1482[$tableName].all()