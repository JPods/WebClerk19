//%attributes = {}
#DECLARE($rec_o : Object; $field_t : Text; $incoming : Text)
$typeFld:=Value type:C1509($rec_o[$field_t])

Case of 
	: (($typeFld=Is alpha field:K8:1) | ($typeFld=Is text:K8:3))
		$rec_o[$field_t]:=$incoming
		
	: (($typeFld=Is real:K8:4) | ($typeFld=_o_Is float:K8:26))
		$rec_o[$field_t]:=Num:C11($incoming)
		
	: (($typeFld=Is longint:K8:6) | ($typeFld=Is integer 64 bits:K8:25))
		If ($obField.fieldName="DT@")
			$rec_o[$field_t]:=Num:C11($incoming)
		Else 
			$rec_o[$field_t]:=String:C10($incoming)
		End if 
		
	: ($typeFld=Is date:K8:7)
		$rec_o[$field_t]:=Date:C102($incoming)  //; Internal date short)
		// add goFigure
		
	: ($typeFld=Is time:K8:8)
		$rec_o[$field_t]:=Time:C179($incoming)  // ; HH MM AM PM)
		
	: ($typeFld=Is boolean:K8:9)
		If (($incoming="t@") || ($incoming="1@") || ($incoming="y@"))
			$rec_o[$field_t]:=True:C214
		Else 
			$rec_o[$field_t]:=False:C215
		End if 
		
	: ($typeFld=Is object:K8:27)
		$rec_o[$field_t]:=JSON Parse:C1218($incoming)
	: ($typeFld=Is picture:K8:10)
		//$rec_o[$field_t]:="Error: is picture"
	: ($typeFld=Is BLOB:K8:12)
		//$rec_o[$field_t]:="Error: is blob"
	Else 
		//$rec_o[$field_t]:="Error: undefined"
End case 
If (False:C215)
	
End if 
//