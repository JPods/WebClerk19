//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $i; $k)
C_REAL:C285($0; $theSum)
ARRAY REAL:C219($aSumReal; 0)
ARRAY DATE:C224($aSumDate; 0)
ARRAY LONGINT:C221($aSumInt; 0)
ARRAY LONGINT:C221($aSumLong; 0)
If (Count parameters:C259=2)
	Case of 
		: (Type:C295(Field:C253($1; $2)->)=1)
			SELECTION TO ARRAY:C260(Field:C253($1; $2)->; $aSumReal)
			$k:=Size of array:C274($aSumReal)
			For ($i; 1; $k)
				$theSum:=$theSum+$aSumReal{$i}
			End for 
			$0:=$theSum
		: (Type:C295(Field:C253($1; $2)->)=4)
			SELECTION TO ARRAY:C260(Field:C253($1; $2)->; $aSumDate)
			$k:=Size of array:C274($aSumDate)
			For ($i; 1; $k)
				$theSum:=$theSum+(Current date:C33-$aSumDate{$i})
			End for 
			$0:=$theSum
		: (Type:C295(Field:C253($1; $2)->)=8)
			SELECTION TO ARRAY:C260(Field:C253($1; $2)->; $aSumInt)
			$k:=Size of array:C274($aSumInt)
			For ($i; 1; $k)
				$theSum:=$theSum+$aSumInt{$i}
			End for 
			$0:=$theSum
		: ((Type:C295(Field:C253($1; $2)->)=9) | (Type:C295(Field:C253($1; $2)->)=11))
			SELECTION TO ARRAY:C260(Field:C253($1; $2)->; $aSumLong)
			$k:=Size of array:C274($aSumLong)
			For ($i; 1; $k)
				$theSum:=$theSum+$aSumLong{$i}
			End for 
			$0:=$theSum
	End case 
End if 