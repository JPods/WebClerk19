//%attributes = {"publishedWeb":true}

If (False:C215)
	//Method: XMLReturnTagValue
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($w; $cntParameters)
C_POINTER:C301($2; $3; $ptTagRay; $ptDataRay)
C_TEXT:C284($0; $1)
$0:=""
$cntParameters:=Count parameters:C259
If ($cntParameters>0)
	If ($cntParameters>2)
		$ptTagRay:=$2
		$ptDataRay:=$3
	Else 
		$ptTagRay:=(->aXMLTag)
		$ptDataRay:=(->aXMLValue)
	End if 
	If ($cntParameters=4)
		$0:=$4
	End if 
	If (Size of array:C274($ptTagRay->)>0)
		$w:=Find in array:C230($ptTagRay->; $1)
		If ($w>0)
			$0:=$ptDataRay->{$w}
		End if 
	End if 
End if 