//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/30/08, 19:09:09
// ----------------------------------------------------
// Method: Http_SerialIssue
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_REAL:C285($QtyOrd; $disPrice)
C_LONGINT:C283($cntSrl; $incSrl)
$QtyOrd:=aOQtyOrder{aoLineAction}
QUERY:C277([ItemSerial:47]; [ItemSerial:47]status:8="Av@"; *)
QUERY:C277([ItemSerial:47];  & [ItemSerial:47]itemNum:1=[Item:4]itemNum:1)
REDUCE SELECTION:C351([ItemSerial:47]; $QtyOrd)
//CREATE RECORD([ItemSerial])
C_LONGINT:C283($srlRefID)
$srlRefID:=CounterNew(->[DialingInfo:81])
aOSerialRc{aoLineAction}:=$srlRefID
$cntSrl:=Records in selection:C76([ItemSerial:47])
If ($cntSrl>0)
	READ WRITE:C146([ItemSerial:47])
	C_DATE:C307($warDate)
	$warDate:=Current date:C33+[ItemSerial:47]warrantyDays:20
	ARRAY TEXT:C222($aSrlNum; 0)
	SELECTION TO ARRAY:C260([ItemSerial:47]serialNum:4; $aSrlNum)
	ARRAY REAL:C219($aSrlPrice; $cntSrl)
	ARRAY LONGINT:C221($aSrlRefID; $cntSrl)
	ARRAY TEXT:C222($aSrlStatus; $cntSrl)
	ARRAY TEXT:C222($aSrlCustID; $cntSrl)
	ARRAY DATE:C224($aSrlWarranty; $cntSrl)
	$disPrice:=Round:C94(DiscountApply(pUnitPrice; pDiscnt; 10); <>tcDecimalUP)
	C_TEXT:C284($seperator)
	$seperator:=""
	For ($incSrl; 1; $cntSrl)
		If ($incSrl=2)
			$seperator:="; "
		End if 
		$aSrlRefID{$incSrl}:=$srlRefID
		$aSrlPrice{$incSrl}:=$disPrice
		$aSrlStatus{$incSrl}:="WebOrd"
		$aSrlCustID{$incSrl}:=[Customer:2]customerID:1
		$aSrlWarranty{$incSrl}:=$warDate
		Srl_Transaction(Table:C252(->[Order:3]); $srlRefID; True:C214; "WebOrd"; $srlRefID; $aSrlNum{$incSrl}; [Item:4]itemNum:1)
		aOSerialNm{aoLineAction}:=aOSerialNm{aoLineAction}+$seperator+$aSrlNum{$incSrl}
	End for 
	ARRAY TO SELECTION:C261($aSrlPrice; [ItemSerial:47]price:26; $aSrlRefID; [ItemSerial:47]salesLnRefid:11; $aSrlCustID; [ItemSerial:47]customerid:9; $aSrlWarranty; [ItemSerial:47]dateWarrantyEnd:21; $aSrlStatus; [ItemSerial:47]status:8)
	READ ONLY:C145([ItemSerial:47])
Else 
	$cntSrl:=1
	aOSerialNm{aoLineAction}:="Serial Numbers assigned at Shipment."
End if 
