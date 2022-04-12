//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-27T00:00:00, 19:32:09
// ----------------------------------------------------
// Method: jsonTextToValue
// Description
// Modified: 08/27/17
// 
// 
//
// Parameters
// ----------------------------------------------------
// ### bj ### 20190113_1331
// good reference on types
C_TEXT:C284($1; $2; $varString)
C_POINTER:C301($ptVarField)
C_LONGINT:C283($type)
$varString:=$1
If (Count parameters:C259=2)
	If (Is a variable:C294(Get pointer:C304($varString)))
		$ptVarField:=Get pointer:C304($varString)
		$type:=Type:C295($ptVarField->)
		Case of 
			: ($type=Is alpha field:K8:1)  //  0
				$ptVarField->:=$2
				
			: ($type=Is BLOB:K8:12)  //  30
				TEXT TO BLOB:C554($2; $ptVarField->; UTF8 text without length:K22:17)
				
			: ($type=Is boolean:K8:9)  //  6
				$ptVarField->:=(($2="t@") | ($2="y@") | ($2="1@"))
				
			: ($type=Is date:K8:7)  //  4
				$ptVarField->:=Date:C102($2)
				
			: ($type=_o_Is float:K8:26)  //  35
				$ptVarField->:=Num:C11($2)
				
			: ($type=Is longint:K8:6)  //  9
				$ptVarField->:=Num:C11($2)
				
			: ($type=Is integer:K8:5)  //  8
				$ptVarField->:=Num:C11($2)
				
			: ($type=Is integer 64 bits:K8:25)  //  25
				$ptVarField->:=Num:C11($2)
				
			: ($type=Is real:K8:4)  //  1
				$ptVarField->:=Num:C11($2)
				
			: ($type=Is string var:K8:2)  //  24
				$ptVarField->:=$2
				
			: ($type=Is text:K8:3)  //  2
				$ptVarField->:=$2
				
			: ($type=Is time:K8:8)  //  11
				$ptVarField->:=Time:C179($2)
				
			: ($type=Is null:K8:31)  //  255
				
			: ($type=Is pointer:K8:14)  //  23
				
				
			: ($type=Is object:K8:27)  //  38
				
				
				
			: ($type=Is subtable:K8:11)  //  7
				
				
			: ($type=Is undefined:K8:13)  //  5
				
				
			: ($type=LongInt array:K8:19)  //  16
				
				
			: ($type=Object array:K8:28)  //  39
				
			: ($type=Is picture:K8:10)  //  3
				
				
			: ($type=Picture array:K8:22)  //  19
				
				
			: ($type=Pointer array:K8:23)  //  20
				
				
			: ($type=Real array:K8:17)  //  14
				
				
			: ($type=String array:K8:15)  //  21
				
				
			: ($type=Text array:K8:16)  //  18
				
				
			: ($type=Time array:K8:29)  //  32
				
			: ($type=Array 2D:K8:24)  //  13
				$ptVarField->:=$2
				
			: ($type=Blob array:K8:30)  //  31
				TEXT TO BLOB:C554($2; $ptVarField->; UTF8 text without length:K22:17)
				
			: ($type=Boolean array:K8:21)  //  22
				
				
			: ($type=Date array:K8:20)  //  17
				
				
			: ($type=Integer array:K8:18)  //  15
				
				
		End case 
	End if 
End if 
