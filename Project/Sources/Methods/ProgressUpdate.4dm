//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 07/20/18, 10:04:36
// ----------------------------------------------------
// Method: ProgressUpdate
// Description
// 
//
// Parameters
// ----------------------------------------------------
//ProgressUpdate(viID;viCount;viTotal;vtTitle)

C_LONGINT:C283($1; $viProgressID; $2; $viCount; $3; $viTotal; viPercent)
C_TEXT:C284($4; $vtTitle)
C_BOOLEAN:C305($vbForeground)
C_REAL:C285($vrProgress)

$viProgressID:=$1
$viCount:=$2
$viTotal:=$3

$vtTitle:=$4
$vbForeground:=False:C215

If ($viTotal=-1)
	$viPercent:=-1
	$vrProgress:=-1
	$vtMessage:="Records Inported: "+String:C10($viCount)
Else 
	$viPercent:=Round:C94(($viCount/$viTotal*100); 0)
	$vrProgress:=($viCount/$viTotal)
	$vtMessage:=(String:C10($viCount)+" of "+String:C10($viTotal)+"  "+String:C10($viPercent)+" %")
End if 

// Progress SET TITLE ( id ; title {; progress {; message {; foreground}}} )
Progress SET TITLE($viProgressID; $vtTitle; $vrProgress; $vtMessage; $vbForeground)