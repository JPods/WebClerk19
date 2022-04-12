//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/20/13, 22:37:22
// ----------------------------------------------------
// Method: Prs_ExecuteProcedures
// Description
// 
//
// Parameters
// ----------------------------------------------------
//$childProcess:=New process("Prs_ExecuteProcedures";<>tcPrsMemory;String(Count user processes)+"- Inships PO";Current process;$title;$script1;$script2)

// Not Counted -- Procedure called
// Not Counted -- Memory stack
// Not counted -- Process Name
// $1 Longint  Parent Process
// $2 Text title
// $3 Text script1
// $4 Text script2
// $5 Text script3
// $6 Text script4

C_LONGINT:C283($1; $processParent)
C_TEXT:C284($2; $title)
C_TEXT:C284($3; $script1; $4; $script2; $5; $script3; $6; $script4; $7; $script5)

C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
SET MENU BAR:C67(6; $viProcess; *)
Process_InitLocal

vWindowTitle:=$2
ExecuteText(0; $3)
If (Count parameters:C259>3)
	ExecuteText(0; $4)
	If (Count parameters:C259>4)
		ExecuteText(0; $5)
		If (Count parameters:C259>5)
			ExecuteText(0; $6)
			If (Count parameters:C259>6)
				ExecuteText(0; $7)
			End if 
		End if 
	End if 
End if 


