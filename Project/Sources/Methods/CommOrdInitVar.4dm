//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
If ($1=1)
	srOrd:=0
	srCustPo:=""
	srMfgOrd:=""
	srPhone:=""
	srZip:=""
	srCustomer:=""
	srAcct:=""
	REDUCE SELECTION:C351([Customer:2]; 0)
End if 
If ($2>0)
	vDate2:=!00-00-00!
	vDate3:=!00-00-00!
	vDate4:=!00-00-00!
	vDate5:=!00-00-00!
	v1:=""
	v2:=""
	v3:=""
	v4:=""
	v5:=""
	v6:=""
	v7:=""
	vAmount:=0
	vR1:=0
	vR2:=0
	vR3:=0
	vR4:=0
	vR7:=0
	vR8:=0
	If ($2>1)  //invoices
		aUnPaid:=0
		v8:=""
		vR5:=0
		vR6:=0
		
		If ($2>2)  //Payments
			pCkNum:=""
			pPayment:=0
			pDiff:=0
			bCredit:=0
		End if   //
	End if 
End if 