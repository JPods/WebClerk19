//%attributes = {"publishedWeb":true}
//Exe_Cmdr_FutureStatement
//*** Hard coded values section.  These variables are ment to
//*** be changed by the user to effect the way this script works.
//*** This is the [Order]Terms type for Futures orders
vText9:="FUT"

SRpt_StRayFill(vi9)

//strip out all invoices and non-Futures Payments

For (vi1; Size of array:C274(aLongInt2); 1; -1)
	vMod:=False:C215
	If (a3Str1{vi1}="Inv")
		vMod:=True:C214
	Else 
		QUERY:C277([Payment:28]; [Payment:28]idNum:8=aLongInt2{vi1})
		If (Records in selection:C76([Payment:28])=1)
			QUERY:C277([Order:3]; [Order:3]orderNum:2=[Payment:28]orderNum:2)
			If (Records in selection:C76([Order:3])=1)
				If (([Order:3]terms:23#vText9) | ([Order:3]dateInvoiceComp:6#!00-00-00!))
					vMod:=True:C214
				End if 
			End if 
		End if 
	End if 
	If (vMod)
		DELETE FROM ARRAY:C228(a25Str1; vi1)  //inv(PO)/payment(check#/Card Approval/comment)
		DELETE FROM ARRAY:C228(a3Str1; vi1)  //TypeDoc
		DELETE FROM ARRAY:C228(aLongInt1; vi1)  //LedgerID
		DELETE FROM ARRAY:C228(aLongInt2; vi1)  //DocRefID
		DELETE FROM ARRAY:C228(aLongInt3; vi1)  //days past due
		DELETE FROM ARRAY:C228(aTmp20Str1; vi1)  //Invoice Num
		DELETE FROM ARRAY:C228(aTmp20Str2; vi1)  //terms
		DELETE FROM ARRAY:C228(aDate1; vi1)  //Date Shipped/Payment Date Received
		DELETE FROM ARRAY:C228(aDate2; vi1)  //due date
		DELETE FROM ARRAY:C228(aDate3; vi1)  //Invoice Date/Payment Date Received
		DELETE FROM ARRAY:C228(aReal1; vi1)  //original value
		DELETE FROM ARRAY:C228(aReal2; vi1)  //Open amount
		DELETE FROM ARRAY:C228(aReal3; vi1)  //future
		DELETE FROM ARRAY:C228(aReal4; vi1)  //current
		DELETE FROM ARRAY:C228(aReal5; vi1)  //past period 1
		DELETE FROM ARRAY:C228(aReal6; vi1)  //past period 2
		DELETE FROM ARRAY:C228(aReal7; vi1)  //past period 3
	End if 
End for 

QUERY:C277([Order:3]; [Order:3]customerid:1=[Customer:2]customerID:1; *)
QUERY:C277([Order:3];  & [Order:3]terms:23=vText9)
vi1:=Records in selection:C76([Order:3])
INSERT IN ARRAY:C227(a25Str1; 1; vi1)  //inv(PO)/payment(check#/Card Approval/comment)
INSERT IN ARRAY:C227(a3Str1; 1; vi1)  //TypeDoc
INSERT IN ARRAY:C227(aLongInt1; 1; vi1)  //LedgerID
INSERT IN ARRAY:C227(aLongInt2; 1; vi1)  //DocRefID
INSERT IN ARRAY:C227(aLongInt3; 1; vi1)  //days past due
INSERT IN ARRAY:C227(aTmp20Str1; 1; vi1)  //Invoice Num
INSERT IN ARRAY:C227(aTmp20Str2; 1; vi1)  //terms
INSERT IN ARRAY:C227(aDate1; 1; vi1)  //Date Shipped/Payment Date Received
INSERT IN ARRAY:C227(aDate2; 1; vi1)  //due date
INSERT IN ARRAY:C227(aDate3; 1; vi1)  //Invoice Date/Payment Date Received
INSERT IN ARRAY:C227(aReal1; 1; vi1)  //original value
INSERT IN ARRAY:C227(aReal2; 1; vi1)  //Open amount
INSERT IN ARRAY:C227(aReal3; 1; vi1)  //future
INSERT IN ARRAY:C227(aReal4; 1; vi1)  //current
INSERT IN ARRAY:C227(aReal5; 1; vi1)  //past period 1
INSERT IN ARRAY:C227(aReal6; 1; vi1)  //past period 2
INSERT IN ARRAY:C227(aReal7; 1; vi1)  //past period 3
For (vi2; 1; vi1)
	a25Str1{vi2}:=[Order:3]customerPO:3  //inv(PO)/payment(check#/Card Approval/comment)
	a3Str1{vi2}:=vText9  //TypeDoc
	aLongInt1{vi2}:=0  //LedgerID
	aLongInt2{vi2}:=[Order:3]orderNum:2  //DocRefID
	aLongInt3{vi2}:=0  //days past due
	aTmp20Str1{vi2}:=String:C10([Order:3]orderNum:2)  //Invoice Num
	aTmp20Str2{vi2}:=vText9  //terms
	aDate1{vi2}:=[Order:3]dateOrdered:4  //Date Shipped/Payment Date Received
	aDate2{vi2}:=[Order:3]dateOrdered:4  //due date
	aDate3{vi2}:=[Order:3]dateOrdered:4  //Invoice Date/Payment Date Received
	aReal1{vi2}:=[Order:3]total:27  //original value
	aReal2{vi2}:=[Order:3]total:27  //Open amount
	aReal3{vi2}:=[Order:3]total:27  //future
	aReal4{vi2}:=0  //current
	aReal5{vi2}:=0  //past period 1
	aReal6{vi2}:=0  //past period 2
	aReal7{vi2}:=0  //past period 3
End for 

SORT ARRAY:C229(aDate1; aDate2; aDate3; a25Str1; aTmp20Str1; aTmp20Str2; aLongInt1; aLongInt2; aLongInt3; a3Str1; aReal1; aReal2; aReal3; aReal4; aReal5; aReal6; aReal7)