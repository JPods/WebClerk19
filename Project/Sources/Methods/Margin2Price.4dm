//%attributes = {"publishedWeb":true}
C_REAL:C285($1; $2; $0)  //Margin; Cost
$0:=Round:C94($2/(1-($1*0.01)); <>tcDecimalUP)