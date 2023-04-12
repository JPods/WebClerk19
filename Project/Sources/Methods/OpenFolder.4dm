//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 07/12/19, 13:44:43
// ----------------------------------------------------
// Method: OpenFolder
// Description
// 
//
// Parameters $1 - Folder path to open
// ----------------------------------------------------

C_TEXT:C284($1; $vtCommand; $vtPath)
C_BOOLEAN:C305(allowAlerts_boo)

$vtCommand:=""
$vtPath:=""
//</declarations>

If (Count parameters:C259>=1)
	$vtPath:=$1
Else 
	$vtPath:=Select folder:C670("")
	ConsoleLog($vtPath)
	If (ok=0)  // user did not select a folder
		$vtPath:=Storage:C1525.folder.jitDocs
	End if 
End if 

If (Test path name:C476($vtPath)=Is a document:K24:1)
	$vtPath:=HFS_GetParent($vtPath)
End if 

If (Is macOS:C1572)
	
	If (Position:C15("/"; $vtPath)#1)  // Posix path should begin with /
		$vtPath:=Convert path system to POSIX:C1106($vtPath)
	End if 
	
	$vtPath:=Replace string:C233($vtpath; " "; "\\ ")  // escape spaces 
	ConsoleLog($vtPath)
	$vtCommand:="Open "+$vtPath
Else 
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	$vtCommand:="cmd.exe /C start "+$vtPath
End if 

If (allowAlerts_boo)
	ALERT:C41("Opening: "+$vtPath)
End if 

LAUNCH EXTERNAL PROCESS:C811($vtCommand)