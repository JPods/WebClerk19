//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 07/31/21, 11:37:46
// ----------------------------------------------------
// Method: Util_GetTypeString
// Description
// 
//
// Parameters
// ----------------------------------------------------

// see // Method: Util_GetTypeNum

C_LONGINT:C283($1)
C_TEXT:C284($0)

C_LONGINT:C283($typeCode_l)

$typeCode_l:=$1

Case of 
	: ($typeCode_l=Is BLOB:K8:12)
		$0:="Is BLOB"
	: ($typeCode_l=Is boolean:K8:9)
		$0:="Is boolean"
	: ($typeCode_l=Is collection:K8:32)
		$0:="Is collection"
	: ($typeCode_l=Is date:K8:7)
		$0:="Is date"
	: ($typeCode_l=Is longint:K8:6)
		$0:="Is longint"
	: ($typeCode_l=Is null:K8:31)
		$0:="Is null"
	: ($typeCode_l=Is object:K8:27)
		$0:="Is object"
	: ($typeCode_l=Is picture:K8:10)
		$0:="Is picture"
	: ($typeCode_l=Is pointer:K8:14)
		$0:="Is pointer"
	: ($typeCode_l=Is real:K8:4)
		$0:="Is real"
	: ($typeCode_l=Is text:K8:3)
		$0:="Is text"
	: ($typeCode_l=Is time:K8:8)
		$0:="Is time"
	: ($typeCode_l=Is undefined:K8:13)
		$0:="Is undefined"
	: ($typeCode_l=Object array:K8:28)
		$0:="Object array"
End case 