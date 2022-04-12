//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 07/31/21, 11:36:40
// ----------------------------------------------------
// Method: Util_GetTypeNum
// Description
// 
//
// Parameters
// ----------------------------------------------------

// see Util_GetTypeString

C_LONGINT:C283($0)
C_TEXT:C284($1)

C_TEXT:C284($typeCode_t)

$typeCode_t:=$1

Case of 
	: ($typeCode_t="Is BLOB")
		$0:=Is BLOB:K8:12
	: ($typeCode_t="Is boolean")
		$0:=Is boolean:K8:9
	: ($typeCode_t="Is collection")
		$0:=Is collection:K8:32
	: ($typeCode_t="Is date")
		$0:=Is date:K8:7
	: ($typeCode_t="Is longint")
		$0:=Is longint:K8:6
	: ($typeCode_t="Is null")
		$0:=Is null:K8:31
	: ($typeCode_t="Is object")
		$0:=Is object:K8:27
	: ($typeCode_t="Is picture")
		$0:=Is picture:K8:10
	: ($typeCode_t="Is pointer")
		$0:=Is pointer:K8:14
	: ($typeCode_t="Is real")
		$0:=Is real:K8:4
	: ($typeCode_t="Is text")
		$0:=Is text:K8:3
	: ($typeCode_t="Is time")
		$0:=Is time:K8:8
	: ($typeCode_t="Is undefined")
		$0:=Is undefined:K8:13
	: ($typeCode_t="Object array")
		$0:=Object array:K8:28
End case 