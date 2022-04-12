Case of 
	: (Before:C29)
		C_LONGINT:C283(vDebitInv; vCreditInv; $i; $e; $k; $curInvNum)
		IvcCredRayInit(0)
		pDiffCurr:=0
		vi7:=aInvoices{aInvoices}
		$curInvNum:=aInvoices{aInvoices}
		For ($i; 1; Size of array:C274(aInvoices))
			If ((aInvoices{$i}#$curInvNum) & (aInvCust{$i}=[Customer:2]customerID:1))
				GOTO RECORD:C242([Invoice:26]; aInvRecs{$i})
				INSERT IN ARRAY:C227(aCredUnPaid; 1; 1)
				INSERT IN ARRAY:C227(aCredDscAmt; 1; 1)
				INSERT IN ARRAY:C227(aCredTot; 1; 1)
				INSERT IN ARRAY:C227(aCredDays; 1)
				INSERT IN ARRAY:C227(aCredIvc; 1; 1)
				INSERT IN ARRAY:C227(aCredRec; 1; 1)
				aCredUnPaid{1}:=aUnPaid{$i}
				aCredDscAmt{1}:=aInvDiscountAmounts{$i}
				aCredTot{1}:=aInvTotals{$i}
				aCredDays{1}:=aInvDays{$i}
				aCredIvc{1}:=aInvoices{$i}
				aCredRec{1}:=aInvRecs{$i}
				//GOTO RECORD([Invoice];aInvRecs{$i})
				//GOTO RECORD([Invoice];aCredRec{1})
			End if 
		End for 
		APOffSetALDefine(eCreditList)
		
		UNLOAD RECORD:C212([Invoice:26])
		//If (Size of array(aCredRec)>0)
		//GOTO RECORD([Invoice];aCredRec{1})
		//End if 
		OBJECT SET ENABLED:C1123(bApply; False:C215)
		OBJECT SET ENABLED:C1123(bCancelB; False:C215)
	Else 
		If ((aCredIvc=0) | (viRecordPushed=-1))
			OBJECT SET ENABLED:C1123(bApply; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(bApply; True:C214)
		End if 
End case 