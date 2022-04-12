//%attributes = {}

// Modified by: Bill James (2022-04-09T05:00:00Z)
// Method: Form_process_o_init
// Description 
// Parameters
// ----------------------------------------------------


// ### bj ### 20211030_2200  // use to access and transitiont ORDA
C_OBJECT:C1216(process_o)
var $1 : Variant
var $tableName : Text
$tableName:=""
If (process_o=Null:C1517)
	If (Count parameters:C259=1)
		Case of 
			: ((Value type:C1509($1)=Is longint:K8:6) | (Value type:C1509($1)=Is real:K8:4) | (Value type:C1509($1)=Is integer:K8:5))
				$tableName:=Table name:C256($1)
			: ((Value type:C1509($1)=Is text:K8:3) | (Value type:C1509($1)=Is string var:K8:2))
				$tableName:=$1
			: (Value type:C1509($1)=Is pointer:K8:14)
				$tableName:=Table name:C256($1)
		End case 
	End if 
	If ((ptCurTable#Null:C1517) & ($tableName=""))
		$tableName:=Table name:C256(ptCurTable)
	End if 
	process_o:=New object:C1471("ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"tableName"; $tableName; \
		"tableForm"; ""; \
		"form"; ""; \
		"entsOther"; New object:C1471; \
		"process"; Current process:C322)
End if 
