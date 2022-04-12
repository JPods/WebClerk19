//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_LONGINT:C283($theLength; $i)
$theLength:=Length:C16($1->)
Case of 
		//: ($theLength=0)
		////drop out
		// : (UserInPassWordGroup ("CreditCardView"))
		// //  confirm 20170419
		
		// test this // ### jwm ### 20161109_1624
	: ($theLength>16)
		OBJECT SET FORMAT:C236($1->; "####-####-####-####-####")
	: ($theLength>12)
		OBJECT SET FORMAT:C236($1->; "####-####-####-####")
	Else 
		OBJECT SET FORMAT:C236($1->; "####-####-####-####-####")
End case 