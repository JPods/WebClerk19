//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccRelateValid
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_POINTER:C301($1; $2; $3)
If ($1->#$2->)
	REDUCE SELECTION:C351($3->; 0)
End if 