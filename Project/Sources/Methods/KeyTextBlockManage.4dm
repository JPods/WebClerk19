//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/24/07, 12:43:46
// ----------------------------------------------------
// Method: KeyTextBlockManage
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1)  //add =1 or subtract = -1
C_POINTER:C301($2)  //text field
C_TEXT:C284($3; $3)
C_LONGINT:C283($incRay; $cntRay; $wFindKey)
Case of 
	: ($1=1)  //adding keyword
		If ($2->="")
			$2->:=$3
		Else 
			//: (Position($3;$2->)<1)
			TextToArray($2->; ->aText8; ", ")
			$wFindKey:=Find in array:C230(aText8; $3)
			If ($wFindKey<1)
				INSERT IN ARRAY:C227(aText8; 1; 1)
				aText8{1}:=$3
				SORT ARRAY:C229(aText8)
				$cntRay:=Size of array:C274(aText8)
				$2->:=""
				If ($cntRay>0)
					$2->:=aText8{1}
					For ($incRay; 2; $cntRay)
						$2->:=$2->+", "+aText8{$incRay}
					End for 
				End if 
			End if 
		End if 
	: ($1=-1)
		If ($2->#"")
			TextToArray($2->; ->aText8; ", ")
			$cntRay:=Size of array:C274(aText8)
			For ($incRay; $cntRay; 1; -1)
				If (aText8{$incRay}=$3)
					DELETE FROM ARRAY:C228(aText8; $incRay; 1)
				End if 
			End for 
			//
			$cntRay:=Size of array:C274(aText8)
			$cntRay:=Size of array:C274(aText8)
			$2->:=""
			If ($cntRay>0)
				$2->:=aText8{1}
				For ($incRay; 2; $cntRay)
					$2->:=$2->+", "+aText8{$incRay}
				End for 
			End if 
		End if 
End case 