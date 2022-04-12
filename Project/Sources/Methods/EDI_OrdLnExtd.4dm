//%attributes = {"publishedWeb":true}
//Procedure: EDI_OrdLnExtd
//make sure the EDI script didn't mess up the line numbers
If (aOLineNum{aoLineAction}<=0)  //is the current line number invalid?
	aOLineNum{aoLineAction}:=viOrdLnCnt  //re-assign the old over an invalid ln#
Else 
	C_BOOLEAN:C305($unique)
	$unique:=True:C214
	C_LONGINT:C283($soa)
	$soa:=Size of array:C274(aOLineNum)
	C_LONGINT:C283($index)
	$index:=1
	While (($unique) & ($index<=$soa))
		If ($index#aoLineAction)  //skip the current elem; it's alway's itself.
			If (aOLineNum{$index}=aOLineNum{aoLineAction})
				aOLineNum{aoLineAction}:=viOrdLnCnt  //re-assign the old over a duplicate ln#
				$unique:=False:C215
			End if 
		End if 
		$index:=$index+1
	End while 
	If ($unique)
		If (viOrdLnCnt<aOLineNum{aoLineAction})
			viOrdLnCnt:=aOLineNum{aoLineAction}  //jump the line count up to this new largest ln#; next ln will be this +1
		End if 
	End if 
End if 
allowAlerts_boo:=False:C215
OrdLnExtend(aoLineAction)
allowAlerts_boo:=True:C214