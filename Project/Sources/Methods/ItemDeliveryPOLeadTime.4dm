//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: ItemDeliveryPOLeadTime
	//Date: 03/11/03
	//Who: Bill
	//Description: Sets the PO lead time.  Also see ItemDeliveryPObyPoLine
End if 
If (UserInPassWordGroup("Apply2Selection"))
	C_DATE:C307($1; $2; $begDate; $endDate)
	C_LONGINT:C283($3; $leadDefault)
	C_LONGINT:C283($theDT)
	$begDate:=!1995-01-01!
	$endDate:=Current date:C33
	$add2Open:=20
	If (Count parameters:C259>1)
		$begDate:=$1
		$endDate:=$2
		If (Count parameters:C259>2)
			$leadDefault:=$3
			If (Count parameters:C259>3)
				$add2Open:=$4
			End if 
		End if 
	End if 
	$theDT:=DateTime_Enter
	$k:=Records in selection:C76([Item:4])
	FIRST RECORD:C50([Item:4])
	C_LONGINT:C283($incPOLines; $cntPOLines; $leadTime)
	For ($i; 1; $k)
		MESSAGE:C88(String:C10($i))
		QUERY:C277([POLine:40]; [POLine:40]itemNum:2=[Item:4]itemNum:1; *)
		QUERY:C277([POLine:40];  & [POLine:40]dateExpected:15>=$begDate; *)
		QUERY:C277([POLine:40];  & [POLine:40]dateExpected:15<=$endDate)
		$cntPOLines:=Records in selection:C76([POLine:40])
		If ($cntPOLines>0)
			$leadTime:=0
			FIRST RECORD:C50([POLine:40])
			For ($incPOLines; 1; $cntPOLines)
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
				NEXT RECORD:C51([POLine:40])
			End for 
			$leadTime:=Round:C94($leadTime/$cntPOLines; 0)
		Else 
			$leadTime:=$leadDefault
		End if 
		[Item:4]leadTimePo:55:=$leadTime
		//[Item]obSync:=$theDT
		SAVE RECORD:C53([Item:4])
		NEXT RECORD:C51([Item:4])
	End for 
End if 
REDRAW WINDOW:C456