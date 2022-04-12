//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14)
C_LONGINT:C283(bSum; $i; $k)
C_REAL:C285($temp1; $temp2; $temp3; $temp4; $temp5; $temp6; $temp7)


If (Count parameters:C259>1)
	$2->:=Round:C94(Sum:C1($1->); <>tcDecimalTt)
End if 
If (Count parameters:C259>3)
	$4->:=Round:C94(Sum:C1($3->); <>tcDecimalTt)
End if 
If (Count parameters:C259>5)
	$6->:=Round:C94(Sum:C1($5->); <>tcDecimalTt)
End if 
If (Count parameters:C259>7)
	$8->:=Round:C94(Sum:C1($7->); <>tcDecimalTt)
End if 
If (Count parameters:C259>9)
	$10->:=Round:C94(Sum:C1($9->); <>tcDecimalTt)
End if 
If (Count parameters:C259>11)
	$12->:=Round:C94(Sum:C1($11->); <>tcDecimalTt)
End if 
If (Count parameters:C259>13)
	$14->:=Round:C94(Sum:C1($13->); <>tcDecimalTt)
End if 



If (False:C215)
	
	$k:=0
	ARRAY REAL:C219($aReal1; $k)
	ARRAY REAL:C219($aReal2; $k)
	ARRAY REAL:C219($aReal3; $k)
	ARRAY REAL:C219($aReal4; $k)
	ARRAY REAL:C219($aReal5; $k)
	ARRAY REAL:C219($aReal6; $k)
	ARRAY REAL:C219($aReal7; $k)
	Case of 
		: (Count parameters:C259=2)
			SELECTION TO ARRAY:C260($1->; $aReal1)
		: (Count parameters:C259=4)
			SELECTION TO ARRAY:C260($1->; $aReal1; $3->; $aReal2)
		: (Count parameters:C259=6)
			SELECTION TO ARRAY:C260($1->; $aReal1; $3->; $aReal2; $5->; $aReal3)
		: (Count parameters:C259=8)
			SELECTION TO ARRAY:C260($1->; $aReal1; $3->; $aReal2; $5->; $aReal3; $7->; $aReal4)
		: (Count parameters:C259=10)
			SELECTION TO ARRAY:C260($1->; $aReal1; $3->; $aReal2; $5->; $aReal3; $7->; $aReal4; $9->; $aReal5)
		: (Count parameters:C259=12)
			SELECTION TO ARRAY:C260($1->; $aReal1; $3->; $aReal2; $5->; $aReal3; $7->; $aReal4; $9->; $aReal5; $11->; $aReal6)
		: (Count parameters:C259=14)
			SELECTION TO ARRAY:C260($1->; $aReal1; $3->; $aReal2; $5->; $aReal3; $7->; $aReal4; $9->; $aReal5; $11->; $aReal6; $13->; $aReal7)
	End case 
	$k:=Size of array:C274($aReal1)
	ARRAY REAL:C219($aReal2; $k)
	ARRAY REAL:C219($aReal3; $k)
	ARRAY REAL:C219($aReal4; $k)
	ARRAY REAL:C219($aReal5; $k)
	ARRAY REAL:C219($aReal6; $k)
	ARRAY REAL:C219($aReal7; $k)
	For ($i; 1; $k)
		$temp1:=$temp1+$aReal1{$i}
		$temp2:=$temp2+$aReal2{$i}
		$temp3:=$temp3+$aReal3{$i}
		$temp4:=$temp4+$aReal4{$i}
		$temp5:=$temp5+$aReal5{$i}
		$temp6:=$temp6+$aReal6{$i}
		$temp7:=$temp7+$aReal7{$i}
	End for 
	If (Count parameters:C259>1)
		$2->:=Round:C94($temp1; <>tcDecimalTt)
	End if 
	If (Count parameters:C259>3)
		$4->:=Round:C94($temp2; <>tcDecimalTt)
	End if 
	If (Count parameters:C259>5)
		$6->:=Round:C94($temp3; <>tcDecimalTt)
	End if 
	If (Count parameters:C259>7)
		$8->:=Round:C94($temp4; <>tcDecimalTt)
	End if 
	If (Count parameters:C259>9)
		$10->:=Round:C94($temp5; <>tcDecimalTt)
	End if 
	If (Count parameters:C259>11)
		$12->:=Round:C94($temp6; <>tcDecimalTt)
	End if 
	If (Count parameters:C259>13)
		$14->:=Round:C94($temp7; <>tcDecimalTt)
	End if 
	
End if 