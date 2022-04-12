//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $3)
C_LONGINT:C283($2; $i; $k)
$k:=Get last field number:C255($1)
For ($i; 1; $k)
	$type:=Type:C295(Field:C253(Table:C252($1); $i)->)
	Case of 
		: (($type=0) | ($type=2))
			$3->{$i}:=Field:C253(Table:C252($1); $i)->
		: ($type=3)
			$3->{$i}:="PictField"
		: ($type=7)
			$3->{$i}:="SubFile"
		: ($type=6)
			$3->{$i}:=String:C10(Num:C11(Field:C253(Table:C252($1); $i)->))
		: ($type=Is BLOB:K8:12)
			//$3->{$i}:=
		Else 
			$3->{$i}:=String:C10(Field:C253(Table:C252($1); $i)->)
	End case 
End for 