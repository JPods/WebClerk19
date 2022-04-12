//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-26T00:00:00, 14:54:43
// ----------------------------------------------------
// Method: WebClerkPageUsage
// Description
// Modified: 08/26/17
// 
// 
//
// Parameters
// ----------------------------------------------------
// ### bj ### 20181226_1906
// replace with a log of the EventLogs.
If (False:C215)
	ARRAY TEXT:C222(<>aWebPagePaths; 0)
	ARRAY TEXT:C222(<>aWebPages; 0)
	ARRAY LONGINT:C221(<>aWebPageSecurityLevel; 0)
	ARRAY LONGINT:C221(<>aWebPageTimesCalled; 0)
	ARRAY LONGINT:C221(<>aWebPageTimesSecurityFails; 0)
End if 
C_TEXT:C284($report; $0)
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(<>aWebPagePaths)
$report:="\r"+"\r"+DateTime+"\r"+"\r"
For ($i; 1; $k)
	$report:=$report+String:C10(<>aWebPageSecurityLevel{$i})+"_"
	$report:=$report+String:C10(<>aWebPageTimesCalled{$i})+"_"
	<>aWebPageTimesCalled{$i}:=0
	$report:=$report+String:C10(<>aWebPageTimesSecurityFails{$i})+"_"
	<>aWebPageTimesSecurityFails{$i}:=0
	$report:=$report+<>aWebPagePaths{$i}+"\r"
End for 
$0:=$report

