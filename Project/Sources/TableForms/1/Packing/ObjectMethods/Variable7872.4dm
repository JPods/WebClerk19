C_LONGINT:C283($i; $k; $w; $incLoadItem; $cntLoadItem; $incPK; $cntPK; $incInvoice; $cntInvoice)
C_REAL:C285($cntOnScale; $calWt; $groupWt)
$k:=Size of array:C274(aoLnSelect)
TRACE:C157
If ($k>0)
	$askCount:=Request:C163("Reset Item Wt based on count of:")
	If (OK=1)
		$cntOnScale:=Num:C11($askCount)
		If ($cntOnScale>0)
			$groupWt:=<>vrWeightScale
			$groupWt:=Num:C11(Request:C163("Weight of Item on Scale"; String:C10($groupWt)))
			If ($groupWt>0)
				READ WRITE:C146([Item:4])
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{aoLnSelect{1}})
				Case of 
					: ((Records in selection:C76([Item:4])=1) & (Not:C34(Locked:C147([Item:4]))))
						$calWt:=Round:C94($groupWt/$cntOnScale; viWtPrecision)
						CONFIRM:C162("Change Item "+[Item:4]itemNum:1+"'s weight to: "+String:C10($calWt)+"\r"+"Count of "+$askCount+" total weight of "+String:C10($groupWt))
						If (OK=1)
							[Item:4]weightAverage:8:=$calWt
							SAVE RECORD:C53([Item:4])
							// update Packing Window
							vrWeightAverage:=[Item:4]weightAverage:8
							UNLOAD RECORD:C212([Item:4])
						End if 
					: (Records in selection:C76([Item:4])=0)
						ALERT:C41("No Item Record")
					: (Records in selection:C76([Item:4])>1)
						ALERT:C41("Multiple Item Records")
					Else 
						ALERT:C41("Item Record is locked")
				End case 
			End if 
		End if 
	End if 
End if 