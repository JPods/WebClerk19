//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/30/12, 09:34:02
// ----------------------------------------------------
// Method: FillContactsPopup
// Description
// 
//
// Parameters
// ----------------------------------------------------


$cntRecs:=Records in selection:C76([QQQContact:13])

FIRST RECORD:C50([QQQContact:13])
For ($i; 1; $cntRecs)
	$theText:=[QQQContact:13]NameFirst:2+" - "+[QQQContact:13]NameLast:4+" - "+[QQQContact:13]City:8+" - "+[QQQContact:13]Zip:11+" - "+[QQQContact:13]Profile1:18+" - "+[QQQContact:13]Phone:30
	$testLen:=Length:C16([QQQContact:13]KeyText:14)
	If ($testLen<4)
		$keyLtrs:=[QQQContact:13]KeyText:14+((4-$testLen)*" ")+" "
	Else 
		$keyLtrs:=Substring:C12([QQQContact:13]KeyText:14; 1; 4)+" "
	End if 
	Case of 
		: ([QQQContact:13]idUnique:28=[QQQCustomer:2]contactBillTo:92)
			$theText:="*B2"+$keyLtrs+$theText
			shipToMe:=$i
		: ([QQQContact:13]idUnique:28=[QQQCustomer:2]contactShipTo:93)
			$theText:="*S2"+$keyLtrs+$theText
			shipToMe:=$i
		: ([QQQContact:13]LetterList:13)
			$useMe:=$i
			$theText:="*"+$keyLtrs+$theText
		Else 
			$theText:=" "+$keyLtrs+$theText
	End case 
	If ([QQQContact:13]ShipToOnly:38)
		$w:=Size of array:C274(aShipTo)+1
		INSERT IN ARRAY:C227(aShipTo; $w)
		INSERT IN ARRAY:C227(aShipToSel; $w)
		INSERT IN ARRAY:C227(aShipToUnique; $w)
		aShipTo{$w}:=$theText
		aShipToSel{$w}:=$i
		aShipToUnique{$w}:=[QQQContact:13]idUnique:28
		aShipTo:=$w
		shipToMe:=$i
	Else 
		$w:=Size of array:C274(aContact)+1
		INSERT IN ARRAY:C227(aContact; $w)
		INSERT IN ARRAY:C227(aCntctSel; $w)
		INSERT IN ARRAY:C227(aContactUnique; $w)
		aContact{$w}:=$theText
		aCntctSel{$w}:=$i
		aContactUnique{$w}:=[QQQContact:13]idUnique:28
		aContact:=$w
	End if 
	NEXT RECORD:C51([QQQContact:13])
End for 