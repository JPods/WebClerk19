//%attributes = {"publishedWeb":true}
//CmmCalcMfgReps

OK:=1
If (Records in selection:C76([Invoice:26])>5000)
	CONFIRM:C162("Assure you have memory to process large numbers of Invoices.")
End if 
If (OK=1)
	vi2:=Records in selection:C76([Invoice:26])
	If (vi2>0)
		//ARRAY TEXT(aTmpText1;vi2)//[Invoice]Company
		//ARRAY TEXT(aTmpText2;vi2)//[Invoice]CustPONum
		//ARRAY TEXT(aTmpText3;vi2)//[Invoice]Profile1
		
		//ARRAY REAL(aTmpReal1;vi2)//[Invoice]AppliedAmount
		//ARRAY REAL(aTmpReal2;vi2)//[Invoice]TotalCost
		
		ARRAY TEXT:C222(aTmpText4; vi2)  //[Customer]RepID
		ARRAY TEXT:C222(aTmpText5; vi2)  //[Customer]SalesName
		ARRAY TEXT:C222(aTmpText6; vi2)  //[Order]MfgAcctCode
		ARRAY REAL:C219(aTmpReal3; vi2)  //Calc Amount Margins Paid
		ARRAY REAL:C219(aTmpReal4; vi2)  //Calc .40
		
		//ARRAY LONGINT(aTmpLong1;vi2)//[Invoice]OrderNum
		//ARRAY LONGINT(aTmpLong2;vi2)//[Invoice]InvoiceNum
		
		SELECTION TO ARRAY:C260([Invoice:26]company:7; aTmpText1; [Invoice:26]orderNum:1; aTmpLong1; [Invoice:26]invoiceNum:2; aTmpLong2; [Invoice:26]customerPO:29; aTmpText2; [Invoice:26]profile1:53; aTmpText3; [Invoice:26]appliedAmount:46; aTmpReal1; [Invoice:26]totalCost:37; aTmpReal2)
		For (vi1; 1; vi2)
			QUERY:C277([Order:3]; [Order:3]orderNum:2=[Invoice:26]orderNum:1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
			aTmpText4{vi1}:=[Customer:2]repID:58
			aTmpText5{vi1}:=[Customer:2]salesNameID:59
			aTmpText6{vi1}:=[Order:3]mfrid:52
			If (aTmpReal1{vi1}>aTmpReal2{vi1})
				aTmpReal3{vi1}:=aTmpReal1{vi1}-aTmpReal2{vi1}
			Else 
				aTmpReal3{vi1}:=0
			End if 
			aTmpReal4{vi1}:=Round:C94(aTmpReal3{vi1}*0.4; 2)
		End for 
	End if 
	SORT ARRAY:C229(aTmpText4; aTmpText1; aTmpLong1; aTmpLong2; aTmpText2; aTmpText3; aTmpText5; aTmpText6; aTmpReal1; aTmpReal2; aTmpReal3; aTmpReal4)
End if 
