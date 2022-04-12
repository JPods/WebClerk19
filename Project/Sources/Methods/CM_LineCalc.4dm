//%attributes = {"publishedWeb":true}
//Procedure: CM_LineCalc
//could be passed ptrs to arrays and a counter or ptrs to variables
//$2 is the counter for arrays, if = -12 it is ptrs to variables
//CM_LineCalc (viSaleMar;-12;pExtPrice;pExtCost;pCommSpc;pCommSales;pQtyOrd)
//pCommRep;pCommRpc)
//exception for proposals
C_LONGINT:C283($1; $2)
C_POINTER:C301($3; $4; $5; $6; $7)
C_REAL:C285($ComAmt)
If ($2<0)  //working with variable pointers
	Case of 
		: ($5-><0)  //calculate commission base on unit times qty
			$6->:=Round:C94(Abs:C99($5->)*$7->; <>tcDecimalTt)
		: ($2=-12)  //calc % based on Commission Amt, ONLY called in the detail dialogs
			If ($1=1)  //viSaleMar  -- Sales Amount
				If ($3->=0)
					$5->:=0
				Else 
					$5->:=Round:C94($6->/$3->*100; 6)
				End if 
			Else 
				$ComAmt:=($3->-$4->)
				If ($ComAmt=0)
					$5->:=0
				Else 
					$5->:=Round:C94($6->/$ComAmt*100; 6)
				End if 
			End if 
		: ($1=1)  //Sales Amount
			$6->:=Round:C94($3->*$5->*0.01; <>tcDecimalTt)
		Else 
			$ComAmt:=($3->-$4->)
			$6->:=Round:C94($ComAmt*$5->*0.01; <>tcDecimalTt)
	End case 
Else 
	Case of   //no calc of % from arrays       : ($2=-12)//use to expand to calc percent 
		: ($5->{$2}<0)
			$6->{$2}:=Round:C94(Abs:C99($5->{$2})*$7->{$2}; <>tcDecimalTt)
		: ($1=1)  //Sales Amount
			$6->{$2}:=Round:C94($3->{$2}*$5->{$2}*0.01; <>tcDecimalTt)  //make sure rate is set before this is called
		Else 
			$ComAmt:=($3->{$2}-$4->{$2})
			$6->{$2}:=Round:C94($ComAmt*$5->{$2}*0.01; <>tcDecimalTt)
	End case 
End if 