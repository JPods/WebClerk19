//%attributes = {"publishedWeb":true}
If (False:C215)
	If (False:C215)
		//Method: TXT_PositionLast
		//Date: 01/05/05
		//Who: Bill
		//Description: 
	End if 
	TCMod_606_67_03_04_Trans
	// SuffixGet
End if 
C_TEXT:C284($1; $working; $2; $findLast)
C_LONGINT:C283($i; $k; $w; $0; $lenFind)
$k:=Length:C16($1)
$lenFind:=Length:C16($2)
$0:=-1
For ($i; $k; 1; -1)
	If ($1[[$i]]=$2)
		$0:=$i
		$i:=0
	End if 
End for 