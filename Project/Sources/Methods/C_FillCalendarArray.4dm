//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/28/20, 12:38:18
// ----------------------------------------------------
// Method: C_FillCalendarArray
// Description
// 
//
// Parameters
// ----------------------------------------------------

QUERY:C277([Order:3]; [Order:3]actionDate:149>=C_DstartDate_V; *)
QUERY:C277([Order:3];  & ; [Order:3]actionDate:149<=C_DendDate_V)
SELECTION TO ARRAY:C260([Order:3]attention:44; C_EmployeeNameID_R; [Order:3]actionDate:149; C_DrecDates_R; [Order:3]actionBy:55; C_TrecDesc_R; [Order:3]actionTime:37; C_HrecTimes_R)
C_LONGINT:C283($k; $i)
$k:=Size of array:C274(C_EmployeeNameID_R)

ARRAY TEXT:C222(C_TrecFonts_R; $k)
ARRAY INTEGER:C220(C_LrecSizes_R; $k)
ARRAY INTEGER:C220(C_LrecFaces_R; $k)
ARRAY INTEGER:C220(C_LrecColors_R; $k)

If (False:C215)
	C_LONGINT:C283($start)
	INSERT IN ARRAY:C227(C_EmployeeNameID_R; $start+1; $nbRows)
	INSERT IN ARRAY:C227(C_DrecDates_R; $start+1; $nbRows)
	INSERT IN ARRAY:C227(C_TrecDesc_R; $start+1; $nbRows)
	INSERT IN ARRAY:C227(C_HrecTimes_R; $start+1; $nbRows)
	
	C_EmployeeNameID_R{$start+$i}:=[Order:3]attention:44
	C_DrecDates_R{$start+$i}:=$Date
	C_TrecDesc_R{$start+$i}:=[Order:3]actionBy:55
	C_HrecTimes_R{$start+$i}:=[Order:3]actionTime:37
	
	INSERT IN ARRAY:C227(C_TrecFonts_R; $start+1; $nbRows)
	INSERT IN ARRAY:C227(C_LrecSizes_R; $start+1; $nbRows)
	INSERT IN ARRAY:C227(C_LrecFaces_R; $start+1; $nbRows)
	INSERT IN ARRAY:C227(C_LrecColors_R; $start+1; $nbRows)
End if 
