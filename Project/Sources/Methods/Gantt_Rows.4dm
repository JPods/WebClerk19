//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/26/21, 01:42:10
// ----------------------------------------------------
// Method: Gantt_Rows
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_DATE:C307($1; vdDateBegin; $2; vdDateEnd)
vdDateBegin:=$1
vdDateEnd:=$2
C_TEXT:C284($vtActionBy)
C_OBJECT:C1216($voRows)
$voRows:=New object:C1471
$vtActionBy:=WCapi_GetParameter("ActionBy")
If ($vtActionBy="")
	$vtActionBy:=[QQQRemoteUser:57]userName:2
End if 
If ($vtActionBy="all")
	C_LONGINT:C283($inc; $cnt)
	$cnt:=Size of array:C274(<>aNameID)
	For ($inc; 2; $cnt)
		$voRows.label:=<>aNameID{$inc}
		// will return an array
		C_COLLECTION:C1488($vcRows)
		//$vcRows:=Gantt_Row(<>aNameID{$inc}; vdDateBegin; vdDateEnd)
		//$voRows.barList:=Gantt_Row(<>aNameID{$inc}; vdDateBegin; vdDateEnd)
	End for 
Else 
	$voRows.label:=$vtActionBy
	// will return an array
	//$voRows.barList:=Gantt_Row($vtActionBy; vdDateBegin; vdDateEnd)
End if 

