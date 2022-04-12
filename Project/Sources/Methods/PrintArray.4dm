//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/11/07, 20:40:35
// ----------------------------------------------------
// Method: Method: PrintArray
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $2; $3)

Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aPrintTableNum; 0)
		ARRAY LONGINT:C221(aPrintRecNums; 0)
		ARRAY LONGINT:C221(aPrintTMRec; 0)
		
	: ($1=-3)
		INSERT IN ARRAY:C227(aPrintTableNum; $2; $3)
		INSERT IN ARRAY:C227(aPrintRecNums; $2; $3)
		INSERT IN ARRAY:C227(aPrintTMRec; $2; $3)
		
	: ($1=-4)
		aPrintTableNum{$2}:=$1
		aPrintRecNums{$2}:=$2
		aPrintTMRec{$2}:=$3
End case 


