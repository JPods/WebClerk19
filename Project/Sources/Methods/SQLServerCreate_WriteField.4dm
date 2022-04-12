//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $typeCode)
$typeCode:=$1
C_TEXT:C284($2; $field)
$field:=$2
C_LONGINT:C283($3; $length)
$length:=$3

C_TEXT:C284($type)

If ($typeCode=Is alpha field:K8:1)
	If (Position:C15("DT"; $field)=1)
		$type:="datetime/*** DT_TYPE ***/"
	Else 
		$type:="varchar("+String:C10($length)+")"
	End if 
End if 
If ($typeCode=Is real:K8:4)
	$type:="real"
End if 
If ($typeCode=Is text:K8:3)
	$type:="text"
End if 
If ($typeCode=Is picture:K8:10)
	$type:="image"
End if 
If ($typeCode=Is date:K8:7)
	$type:="datetime"
End if 
If ($typeCode=Is boolean:K8:9)
	$type:="bit"
End if 
If ($typeCode=Is subtable:K8:11)
	$type:="/*** SUBTABLE ***/"
End if 
If ($typeCode=Is integer:K8:5)
	$type:="smallint"
End if 
If ($typeCode=Is longint:K8:6)
	$type:="int"
End if 
If ($typeCode=Is time:K8:8)
	$type:="/*** TIME_FIELD ***/"
End if 
If ($typeCode=Is BLOB:K8:12)
	$type:="image"
End if 
If ($typeCode=-99)
	$type:="bigint"
End if 

If (($type="image") & (msSQLLeft=""))  //for MySQL
	SEND PACKET:C103(myDoc; "  "+msSQLLeft+$field+msSQLRight+" text/*** Image Replace ***/")
Else 
	SEND PACKET:C103(myDoc; " "+msSQLLeft+$field+msSQLRight+" "+$type)
End if 