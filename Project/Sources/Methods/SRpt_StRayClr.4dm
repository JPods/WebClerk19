//%attributes = {"publishedWeb":true}
If (False:C215)
	//07/30/02:janani
	// added array a25Str2 to hold [Payment]Comment  
End if 

//Procedure: SRpt_StRayClr
C_LONGINT:C283($1; $i; $2; $3)
If (Count parameters:C259>0)
	$i:=$1
Else 
	$i:=0
End if 
Case of 
	: ($i>=0)
		ARRAY TEXT:C222(a25Str1; $i)  //inv(PO)/payment(check#/Card Approval/comment)
		ARRAY TEXT:C222(a25Str2; $i)  //payment(comment)
		ARRAY TEXT:C222(a3Str1; $i)  //TypeDoc
		ARRAY LONGINT:C221(aTmpInt1; $i)  //LedgerType
		ARRAY LONGINT:C221(aLongInt1; $i)  //LedgerID
		ARRAY LONGINT:C221(aLongInt2; $i)  //DocRefID
		ARRAY LONGINT:C221(aLongInt3; $i)  //days past due
		ARRAY TEXT:C222(aTmp20Str1; $i)  //Invoice Num
		ARRAY TEXT:C222(aTmp20Str2; $i)  //terms
		ARRAY TEXT:C222(aTmp20Str3; $i)  //Table Name
		ARRAY DATE:C224(aDate1; $i)  //Date Shipped/Payment Date Received
		ARRAY DATE:C224(aDate2; $i)  //due date
		ARRAY DATE:C224(aDate3; $i)  //Invoice Date/Payment Date Received
		ARRAY REAL:C219(aReal1; $i)  //original value
		ARRAY REAL:C219(aReal2; $i)  //Open amount
		ARRAY REAL:C219(aReal3; $i)  //future
		ARRAY REAL:C219(aReal4; $i)  //current
		ARRAY REAL:C219(aReal5; $i)  //past period 1
		ARRAY REAL:C219(aReal6; $i)  //past period 2
		ARRAY REAL:C219(aReal7; $i)  //past period 3
		ARRAY REAL:C219(aReal8; $i)  //finance charge
	: ($1=-3)
		INSERT IN ARRAY:C227(a25Str1; $2; $3)  //inv(PO)/payment(check#/Card Approval/comment)
		INSERT IN ARRAY:C227(a25Str2; $2; $3)  //payment(comment)
		INSERT IN ARRAY:C227(a3Str1; $2; $3)  //TypeDoc
		INSERT IN ARRAY:C227(aTmpInt1; $2; $3)  //file number
		INSERT IN ARRAY:C227(aLongInt1; $2; $3)  //LedgerID
		INSERT IN ARRAY:C227(aLongInt2; $2; $3)  //DocRefID
		INSERT IN ARRAY:C227(aLongInt3; $2; $3)  //days past due
		INSERT IN ARRAY:C227(aTmp20Str1; $2; $3)  //Invoice Num
		INSERT IN ARRAY:C227(aTmp20Str2; $2; $3)  //terms
		INSERT IN ARRAY:C227(aTmp20Str3; $2; $3)  //Table Name
		INSERT IN ARRAY:C227(aDate1; $2; $3)  //Date Shipped/Payment Date Received
		INSERT IN ARRAY:C227(aDate2; $2; $3)  //due date
		INSERT IN ARRAY:C227(aDate3; $2; $3)  //Invoice Date/Payment Date Received
		INSERT IN ARRAY:C227(aReal1; $2; $3)  //original value
		INSERT IN ARRAY:C227(aReal2; $2; $3)  //Open amount
		INSERT IN ARRAY:C227(aReal3; $2; $3)  //future
		INSERT IN ARRAY:C227(aReal4; $2; $3)  //current
		INSERT IN ARRAY:C227(aReal5; $2; $3)  //past period 1
		INSERT IN ARRAY:C227(aReal6; $2; $3)  //past period 2
		INSERT IN ARRAY:C227(aReal7; $2; $3)  //past period 3
		INSERT IN ARRAY:C227(aReal8; $2; $3)  //finance charge
	: ($1=-1)
		DELETE FROM ARRAY:C228(a25Str1; $2; $3)  //inv(PO)/payment(check#/Card Approval/comment)
		DELETE FROM ARRAY:C228(a25Str2; $2; $3)  //payment(comment)
		DELETE FROM ARRAY:C228(a3Str1; $2; $3)  //TypeDoc
		DELETE FROM ARRAY:C228(aTmpInt1; $2; $3)  //file number
		DELETE FROM ARRAY:C228(aLongInt1; $2; $3)  //LedgerID
		DELETE FROM ARRAY:C228(aLongInt2; $2; $3)  //DocRefID
		DELETE FROM ARRAY:C228(aLongInt3; $2; $3)  //days past due
		DELETE FROM ARRAY:C228(aTmp20Str1; $2; $3)  //Invoice Num
		DELETE FROM ARRAY:C228(aTmp20Str2; $2; $3)  //terms
		DELETE FROM ARRAY:C228(aTmp20Str3; $2; $3)  //Table Name
		DELETE FROM ARRAY:C228(aDate1; $2; $3)  //Date Shipped/Payment Date Received
		DELETE FROM ARRAY:C228(aDate2; $2; $3)  //due date
		DELETE FROM ARRAY:C228(aDate3; $2; $3)  //Invoice Date/Payment Date Received
		DELETE FROM ARRAY:C228(aReal1; $2; $3)  //original value
		DELETE FROM ARRAY:C228(aReal2; $2; $3)  //Open amount
		DELETE FROM ARRAY:C228(aReal3; $2; $3)  //future
		DELETE FROM ARRAY:C228(aReal4; $2; $3)  //current
		DELETE FROM ARRAY:C228(aReal5; $2; $3)  //past period 1
		DELETE FROM ARRAY:C228(aReal6; $2; $3)  //past period 2
		DELETE FROM ARRAY:C228(aReal7; $2; $3)  //past period 3    
		DELETE FROM ARRAY:C228(aReal8; $2; $3)  //finance charge
End case 

