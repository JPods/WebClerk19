//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/23/11, 22:09:40
// ----------------------------------------------------
// Method: UtilCheckValidEntry
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($cntPara; $f; $theType)
$cntPara:=Count parameters:C259
If ($cntPara>1)
	$theType:=Type:C295($1->)
	Case of 
		: (cntPara<2)
		: (cntPara=3)
			$f:=Find in array:C230($3->; $1->)
			If ($f<1)
				$1->:=$2->
			End if 
		Else 
			Case of 
				: ($theType=Is alpha field:K8:1)
					$1->:=$2->
				: ($theType=Is longint:K8:6)
					$1->:=$2->
				: ($theType=Is date:K8:7)
					$1->:=$2->
			End case 
	End case 
End if 