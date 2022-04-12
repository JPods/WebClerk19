C_LONGINT:C283($i; $k; $w; $e; $r)
C_LONGINT:C283($jobRec; $jobNew)
If (Records in selection:C76([PO:39])<1)
	jAlertMessage(10003)
Else 
	$jobNew:=Num:C11(Request:C163("Duplicate these PO's for Job?"; "0"))
	If ((OK=1) & ($jobNew>0))
		PUSH RECORD:C176([Project:24])
		QUERY:C277([Project:24]; [Project:24]projectNum:1=$jobNew)
		If (Records in selection:C76([Project:24])=0)
			jAlertMessage(10003)
			POP RECORD:C177([Project:24])  //to release the record
		Else 
			$jobRec:=Record number:C243([Project:24])
			POP RECORD:C177([Project:24])
			FIRST RECORD:C50([PO:39])
			ARRAY LONGINT:C221(aLongInt1; Records in selection:C76([PO:39]))
			For ($i; 1; Records in selection:C76([PO:39]))
				aLongInt1{$i}:=Record number:C243([PO:39])
				NEXT RECORD:C51([PO:39])
			End for 
			GOTO RECORD:C242([Project:24]; $jobRec)
			$booOrg:=booAccept
			booAccept:=True:C214
			For ($i; 1; Size of array:C274(aLongInt1))
				GOTO RECORD:C242([PO:39]; aLongInt1{$i})
				QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]poNum:1=[PO:39]poNum:5)
				PoLnFillRays(Records in selection:C76([QQQPOLine:40]))
				REDUCE SELECTION:C351([QQQPOLine:40]; 0)
				DUPLICATE RECORD:C225([PO:39])
				[PO:39]poNum:5:=CounterNew(->[PO:39])
				newPo:=True:C214
				[PO:39]customerPo:34:=""
				[PO:39]dateOrdered:2:=Current date:C33
				[PO:39]buyer:7:=Current user:C182
				[PO:39]vendorInvoice:29:=""
				[PO:39]shipDate:36:=!00-00-00!
				[PO:39]dateCompleted:4:=!00-00-00!
				[PO:39]completeId:65:=0
				[PO:39]dateNeeded:3:=Current date:C33
				vMod:=True:C214
				For ($e; 1; Size of array:C274(aPOLineAction))
					aPOLineAction{$e}:=-3
					aPOQtyRcvd{$e}:=0
					aPOQtyBL{$e}:=aPOQtyOrder{$e}
					aPOBackLog{$e}:=aPOExtCost{$e}
				End for 
				acceptPO
			End for 
			QUERY:C277([PO:39]; [PO:39]projectNum:6=[Project:24]projectNum:1)
			booAccept:=$booOrg
			ARRAY LONGINT:C221(aLongInt1; 0)
		End if 
	End if 
End if 