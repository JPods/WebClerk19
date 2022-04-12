//%attributes = {"publishedWeb":true}
//Procedure: Exch_dPriceCost
//[Order]ExchangeRate; aOLineNum{aoLineAction}
C_POINTER:C301($1; $2)
C_LONGINT:C283($fiaLine)
If ($1->#0)
	$fiaLine:=Find in array:C230(aExLnNum; $2->)
	If ($fiaLine>0)
		aExUnitPrc{$fiaLine}:=Round:C94(pUnitPrice/$1->; viExConPrec)
	End if 
End if 