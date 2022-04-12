//%attributes = {"publishedWeb":true}
$vtBody:="Error: invalid password, status=401, asdkflansdf"
var $wStatus_i; $err_i : Integer
If ($vtBody="Error@")  // put into json earlierr if practical
	$wStatus_i:=Position:C15("status="; $vtBody)
	If ($wStatus_i>0)
		$err_i:=Num:C11(Substring:C12($vtBody; $wStatus_i+7; 3))
		$vtBody:=JSON Stringify:C1217(New object:C1471("Error"; Substring:C12($vtBody; 8); "status"; $err_i))
	Else 
		$vtBody:=JSON Stringify:C1217(New object:C1471("Error"; Substring:C12($vtBody; 8); "status"; 500))
	End if 
End if 