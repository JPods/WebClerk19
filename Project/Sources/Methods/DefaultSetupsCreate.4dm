//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-09-12T00:00:00, 11:30:40
// ----------------------------------------------------
// Method: DefaultSetupsCreate
// Description
// Modified: 09/12/16
// 
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $variableName; $2; $value; $3; $type; $4; $group; $5; $layout; $6; $howused)
$variableName:=$1
$value:=$2
$type:=$3
$group:=$4
$layout:=$5
$howused:=$6
var $rec_ent : Object

$rec_ent:=ds:C1482.DefaultSetup.query("variableName = :1"; $variableName).first()
If ($rec_ent=Null:C1517)
	$rec_ent:=ds:C1482.DefaultSetup.new()
	
	$rec_ent.value:=$value  // 50 milliseconds. This is to give ser
	$rec_ent.variableName:=$variableName
	$rec_ent.type:=$type
	$rec_ent.group:=$group
	$rec_ent.layoutName:=$layout
	$rec_ent.howUsed:=$howused
	$rec_ent.save()
End if 
