//KeyModifierCurrent 

If ([Order:3]flow:134=0)
	CONFIRM:C162("First convert "+String:C10(srOrd)+" to Bulk Commission???"; "Convert to Bulk Commission"; "Cancel")
	If (OK=1)
		InvoiceBulkCommissions
		//Else 
		//Ord2InvComm 
		//end if
	End if 
Else 
	ALERT:C41("Process in Commission Orders window.")
End if 

If (False:C215)
	viOrdLnCnt:=0
	$backlog:=OrdersFlowToCommission(4)  //Item record must already be the selection
	//[Order]Flow:=4
	
	// UpdateWithResources by: Bill James (2023-01-03T06:00:00Z)
	//CMANewCommOrderLine(-1; $backlog; $backlog; Current date; "CommWindow"; "exact"; $inTest; vR2; vR4)
	//viOrdLnCnt:=MaxValueReturn(viOrdLnCnt; [OrderLine]seq)
	//CMAComOrderOneLine(4)
	
	OrdLnFillRays
	If (eOrdList#0)
		//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
	End if 
End if 


If (False:C215)
	
	OK:=0
	If ([Order:3]flow:134=0)
		CONFIRM:C162("Convert "+String:C10(srOrd)+" to Bulk Commission???")
	End if 
	If (OK=1)
		InvoiceBulkCommissions
		If (False:C215)
			Ord2InvComm
		End if 
	End if 
	
End if 
