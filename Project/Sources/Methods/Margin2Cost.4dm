//%attributes = {"publishedWeb":true}
If (False:C215)
	//01/21/03.prf
	//New method to calculate cost from margin and price
	VERSION_9919
	VERSION_9919_ISC
End if 

C_REAL:C285($1; $2; $0)  //Margin; Price
$0:=Round:C94($2*(1-($1*0.01)); <>tcDecimalUP)