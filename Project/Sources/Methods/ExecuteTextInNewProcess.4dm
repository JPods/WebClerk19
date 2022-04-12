//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/08/12, 05:54:22
// ----------------------------------------------------
// Method: ExecuteTextInNewProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------
Process_InitLocal

C_TEXT:C284($1; $frText)
C_TEXT:C284($2)
C_TEXT:C284($3)
Case of 
	: (Count parameters:C259=3)
		// unpack variables from $3
		ExecuteText(0; $1; "ExecuteTextInNewProcess")
		If ($2#"")
			// ALERT("$2: "+String(Length($2)))
			If (Length:C16($2)>5)
				ExecuteText(0; $1; "ExecuteTextInNewProcess")
			End if 
		End if 
		// unpack variables from $3
	: ($1#"")
		ExecuteText(0; $1; "ExecuteTextInNewProcess")
End case 