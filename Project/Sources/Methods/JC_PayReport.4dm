//%attributes = {"publishedWeb":true}
//Procedure: JC_PayReport
//vDate1:=Date(Request("Enter Begin";String(Date_ThisYear (Current date;0)))
//)
//vDate2:=Date(Request("Enter End";String(Date_ThisMon (Current date;1))))
//vi2:=Records in selection([Item])
////<>aTndClass{<>aPayTypes}
//TRACE
//FIRST RECORD([Item])
//vi2:=Records in selection([Item])
//For (vi1;1;vi2)
QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]itemNum:4=[Item:4]itemNum:1; *)
QUERY:C277([InvoiceLine:54];  & [InvoiceLine:54]dateShipped:25>=vDate1; *)
QUERY:C277([InvoiceLine:54];  & [InvoiceLine:54]dateShipped:25<=vDate2)
vi4:=Records in selection:C76([InvoiceLine:54])
SELECTION TO ARRAY:C260([InvoiceLine:54]qtyShipped:7; aTmpReal1; [InvoiceLine:54]extendedPrice:11; aTmpReal2; [InvoiceLine:54]invoiceNum:1; aTmpLong1)
ARRAY TEXT:C222(aTmp35Str1; vi4)
ARRAY LONGINT:C221(aTmpInt1; vi4)
If (vi4>0)
	For (vi3; 1; vi4)
		QUERY:C277([Payment:28]; [Payment:28]invoiceNum:3=aTmpLong1{vi3})
		If (Records in selection:C76([Payment:28])=0)
			aTmpInt1{vi3}:=-1
		Else 
			FIRST RECORD:C50([Payment:28])
			vi9:=Find in array:C230(<>aPayTypes; [Payment:28]TypePayment:6)
			If (vi9>0)
				aTmpInt1{vi3}:=<>aTndClass{vi9}
			Else 
				aTmpInt1{vi3}:=-2
			End if 
		End if 
	End for 
End if 
ARRAY REAL:C219(aReal1; 5)  //#TransActions
ARRAY REAL:C219(aReal2; 5)  //Qty
ARRAY REAL:C219(aReal3; 5)  //StdUnitPrice
ARRAY REAL:C219(aReal4; 5)  //AveUnitPrice
ARRAY REAL:C219(aReal5; 5)  //ItemSales
ARRAY REAL:C219(aReal6; 5)
ARRAY TEXT:C222(aText1; 5)  //Explanation
aText1{1}:="By Compensation"
aText1{2}:="By Check"
aText1{3}:="By Credit Card"
aText1{4}:="Other"
aText1{5}:="Total"
aReal1{1}:=0
aReal1{2}:=0
aReal1{3}:=0
aReal1{4}:=0
aReal1{5}:=0
aReal2{1}:=0
aReal2{2}:=0
aReal2{3}:=0
aReal2{4}:=0
aReal2{5}:=0
aReal3{1}:=0
aReal3{2}:=0
aReal3{3}:=0
aReal3{4}:=0
aReal3{5}:=0
aReal4{1}:=0
aReal4{2}:=0
aReal4{3}:=0
aReal4{4}:=0
aReal4{5}:=0
aReal5{1}:=0
aReal5{2}:=0
aReal5{3}:=0
aReal5{4}:=0
aReal5{5}:=0
If (vi4>0)
	SORT ARRAY:C229(aTmpLong1; aTmpReal1; aTmpReal2; aTmpInt1)
	vi10:=-111
	For (vi3; 1; vi4)
		vi8:=Num:C11(vi10#aTmpLong1{vi3})
		vi10:=aTmpLong1{vi3}
		Case of 
			: ((aTmpInt1{vi3}=1) | (aTmpInt1{vi3}=2))  //cash & checks
				aReal1{2}:=aReal1{2}+vi8  //CntTrans
				aReal2{2}:=aReal2{2}+aTmpReal1{vi3}  //Qty
				aReal5{2}:=aReal5{2}+aTmpReal2{vi3}  //ExtPrice
			: (aTmpInt1{vi3}=3)  //cc
				aReal1{3}:=aReal1{3}+vi8  //CntTrans
				aReal2{3}:=aReal2{3}+aTmpReal1{vi3}  //Qty
				aReal5{3}:=aReal5{3}+aTmpReal2{vi3}  //ExtPrice
			: (aTmpInt1{vi3}=-1)  //cc
				aReal1{1}:=aReal1{1}+vi8  //CntTrans
				aReal2{1}:=aReal2{1}+aTmpReal1{vi3}  //Qty
				aReal5{1}:=aReal5{1}+aTmpReal2{vi3}  //ExtPrice      
			Else 
				aReal1{4}:=aReal1{4}+vi8  //CntTrans
				aReal2{4}:=aReal2{4}+aTmpReal1{vi3}  //Qty
				aReal5{4}:=aReal5{4}+aTmpReal2{vi3}  //ExtPrice
		End case 
		aReal1{5}:=aReal1{5}+vi8  //CntTrans
		aReal2{5}:=aReal2{5}+aTmpReal1{vi3}  //Qty
		aReal5{5}:=aReal5{5}+aTmpReal2{vi3}  //ExtPrice
	End for 
	If (aReal2{1}>0)
		aReal4{1}:=Round:C94(aReal5{1}/aReal2{1}; 2)
	End if 
	If (aReal2{2}>0)
		aReal4{2}:=Round:C94(aReal5{2}/aReal2{2}; 2)
	End if 
	If (aReal2{3}>0)
		aReal4{3}:=Round:C94(aReal5{3}/aReal2{3}; 2)
	End if 
	If (aReal2{4}>0)
		aReal4{4}:=Round:C94(aReal5{4}/aReal2{2}; 2)
	End if 
	If (aReal2{5}>0)
		aReal4{5}:=Round:C94(aReal5{5}/aReal2{5}; 2)
	End if 
End if 
//End for 