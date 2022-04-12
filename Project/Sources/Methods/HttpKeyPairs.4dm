//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HttpKeyPairs
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//
C_POINTER:C301($1)
C_TEXT:C284($0; $keyWords; $keyPair)
$p:=Position:C15("KeyPairs"; $1->)
$keyWords:=""
$keyPair:=""
If ($p>0)
	vText1:=$1->
	Repeat 
		$keyPair:=WCapi_GetParameter("keyPairs"; "")
		If ($keyPair#"")
			$keyWords:=$keyWords+$keyPair+"; "
		End if 
		vText1:=Substring:C12(vText1; $p+7)
		$p:=Position:C15("KeyPairs"; vText1)
	Until ($p=0)
End if 
$0:=$keyWords