//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/26/21, 00:13:29
// ----------------------------------------------------
// Method: Gantt_Row
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($vtActionBy; $1)
C_DATE:C307($2; $vdDateBegin; $3; $vdDateEnd)
$vtActionBy:=$1
$vdDateBegin:=$2
$vdDateEnd:=$3
C_OBJECT:C1216($voRow)
$voRow:=New object:C1471
$voRow.lable:=$vtActionBy
C_OBJECT:C1216($veEmployees; $veRecEmployee)
C_OBJECT:C1216($voBarConfig)
C_OBJECT:C1216(voState)
$veEmployees:=ds:C1482.Employee.query("nameID = :1 "; $vtActionBy)
$veRecEmployee:=$veEmployees.first()
$voBarConfig:=New object:C1471("color"; [Employee:19]colorForeGround:54; "backgroundColor"; [Employee:19]colorBackground:55)

WCapiTask_ActionBy
