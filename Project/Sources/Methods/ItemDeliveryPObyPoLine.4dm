//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: ItemDeliveryPOLeadTime
	//Date: 03/11/03
	//Who: Bill
	//Description: Sets the PO lead time.  Also see ItemDeliveryPObyPoLine
End if 
C_DATE:C307($1; $2; $begDate; $endDate)
C_LONGINT:C283($3; $leadDefault)
C_LONGINT:C283($theDT; $add2Open; $4)

If (Count parameters:C259>2)
	$leadDefault:=$3
	If (Count parameters:C259>3)
		$add2Open:=$4
	End if 
End if 
REDUCE SELECTION:C351([Item:4]; 0)
$theDT:=DateTime_DTTo
$k:=Records in selection:C76([POLine:40])
FIRST RECORD:C50([POLine:40])
C_LONGINT:C283($incPOLines; $cntPOLines; $leadTime)
C_TEXT:C284($currentItem)
$currentItem:=Storage:C1525.char.crlf+"qwer;q~oia;fjoifawgfhwoe"+Storage:C1525.char.crlf
For ($i; 1; $k)
	MESSAGE:C88(String:C10($i))
	If ($currentItem#[POLine:40]itemNum:2)
		If (Records in selection:C76([Item:4])=1)
			If ($cntPOLines>0)
				$leadTime:=Round:C94($leadTime/$cntPOLines; 0)
			Else 
				$leadTime:=$leadDefault
			End if 
			[Item:4]leadTimePo:55:=$leadTime
			SAVE RECORD:C53([Item:4])
		End if 
		$currentItem:=[POLine:40]itemNum:2
		$leadTime:=0
		$cntPOLines:=1
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[POLine:40]itemNum:2)
	Else 
		$cntPOLines:=$cntPOLines+1
	End if 
	If (Records in selection:C76([Item:4])=1)
		If ([PO:39]idNum:5#[POLine:40]idNumPO:1)
			QUERY:C277([PO:39]; [PO:39]idNum:5=[POLine:40]idNumPO:1)
		End if 
		If ([POLine:40]dateReceived:17#!00-00-00!)
			$thisLead:=[POLine:40]dateReceived:17-[PO:39]dateOrdered:2
			If ($thisLead>0)
				$leadTime:=$leadTime+$thisLead
			End if 
		Else 
			$leadTime:=Current date:C33-[PO:39]dateOrdered:2+$add2Open
		End if 
	End if 
	NEXT RECORD:C51([POLine:40])
End for 
//
REDRAW WINDOW:C456