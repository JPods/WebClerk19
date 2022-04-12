//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/29/20, 23:45:46
// ----------------------------------------------------
// Method: WCapiTask_Query
// Description
// 
//
// Parameters
// ----------------------------------------------------

WCapil_TableFieldvoState
If (voState.working.tableName=Null:C1517)
	
Else 
	C_OBJECT:C1216($voRequest; $voLine; $veSelection)
	C_COLLECTION:C1488($vcQuery)
	$voRequest:=voState.request.parameters
	For each ($voLine; $voRequest)
		
		
	End for each 
	$tableNum:=WccQuery3Fields
	If ($tableNum<1)
		vResponse:="Error: Delete is not a web function."
	End if 
End if 