//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-27T06:00:00Z)
// Method: WccExecuteTask
// Description 
// Parameters
// ----------------------------------------------------

var $rec : Object
var $1; $3; $4; pvParseStatus; $queryString; $profile1; $profile2; $purpose : Text
var $2; $security; $tableNum : Integer
If (Count parameters:C259>0)
	$queryString:=" publish >= :1 "
	If (vWccSecurity>0)
		$security:=vWccSecurity
	Else 
		$security:=viEndUserSecurityLevel
	End if 
	$purpose:=$1
	If (Count parameters:C259>1)
		$tableNum:=$2
		$queryString:=$queryString+" & tableNum = :2"
	End if 
	
	$rec:=ds:C1482.TallyMaster.query($queryString; $security; $tableNum; profile1; $profile2).first()
	
	If ($rec#Null:C1517)
		pvParseStatus:=pvParseStatus+"\r"+$purpose+": Execute Procedure in [TallyMaster]UniqueID="+String:C10($rec.idNum)
		ExecuteText(0; $rec.script)
	Else 
		pvParseStatus:=pvParseStatus+"\r"+$purpose+": No Execute Procedure in [TallyMaster]"
	End if 
End if 