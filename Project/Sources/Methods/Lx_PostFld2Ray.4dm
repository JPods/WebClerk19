//%attributes = {"publishedWeb":true}
//Procedure: Lx_PostFld2Ray
aaaStdRays
$k:=Size of array:C274(aRayNames)
$cntSplit:=0
$cntCycle:=1
$rayList:=""
$rayName:=""
$i:=0
$quote:=Char:C90(34)
$cntTlt:=0
C_LONGINT:C283($i; $k; $cnt1; $inc1; $cnt2; $inc2; $cnt3; $inc3)
C_POINTER:C301($ptMainFile; $ptMidFile; $ptLastFile; $ptRay)
$k:=Size of array:C274(aFldNames)
$ptMainFile:=Table:C252(vR1)
$ptMidFile:=Table:C252(vR2)
$ptLastFile:=Table:C252(vR3)
C_LONGINT:C283($incRay; $rayCnt)
$rayCnt:=Size of array:C274(aRayPointer)
$cnt1:=Records in selection:C76($ptMainFile->)
FIRST RECORD:C50($ptMainFile->)
If (b50=1)
	For ($inc1; 1; $cnt1)
		ExecuteText(0; vText2)
		$cnt2:=Records in selection:C76($ptMidFile->)
		If ($cnt2=0)
			$cnt2:=1
		End if 
		FIRST RECORD:C50($ptMidFile->)
		For ($inc2; 1; $cnt2)
			If (Records in selection:C76($ptMidFile->)>0)
				ExecuteText(0; vText3)
				$cnt3:=Records in selection:C76($ptLastFile->)
			Else 
				REDUCE SELECTION:C351($ptLastFile->; 0)
				$cnt3:=0
			End if 
			If ($cnt3=0)
				$cnt3:=1
			End if 
			FIRST RECORD:C50($ptLastFile->)
			For ($inc3; 1; $cnt3)
				$newSize:=Size of array:C274(aLongint1)+1
				INSERT IN ARRAY:C227(aRayPointer{1}->; $newSize)  //aLongInt1
				aLongInt1{$newSize}:=Record number:C243(Table:C252(vR1)->)
				INSERT IN ARRAY:C227(aRayPointer{2}->; $newSize)  //aLongInt2
				aLongInt2{$newSize}:=Record number:C243(Table:C252(vR2)->)
				INSERT IN ARRAY:C227(aRayPointer{3}->; $newSize)  //aLongInt3
				aLongInt3{$newSize}:=Record number:C243(Table:C252(vR3)->)
				For ($incRay; 4; $rayCnt)
					INSERT IN ARRAY:C227(aRayPointer{$incRay}->; $newSize)
					aRayPointer{$incRay}->{$newSize}:=aFieldPoint{$incRay}->
				End for 
				NEXT RECORD:C51($ptLastFile->)
			End for 
			NEXT RECORD:C51($ptMidFile->)
		End for 
		NEXT RECORD:C51($ptMainFile->)
	End for 
Else 
	For ($inc1; 1; $cnt1)
		ExecuteText(0; vText2)
		$cnt2:=Records in selection:C76($ptMidFile->)
		If ($cnt2=0)
			$cnt2:=1
		End if 
		FIRST RECORD:C50($ptMidFile->)
		For ($inc2; 1; $cnt2)
			$newSize:=Size of array:C274(aLongint1)+1
			INSERT IN ARRAY:C227(aRayPointer{1}->; $newSize)  //aLongInt1
			aLongInt1{$newSize}:=Record number:C243(Table:C252(vR1)->)
			INSERT IN ARRAY:C227(aRayPointer{2}->; $newSize)  //aLongInt2
			aLongInt2{$newSize}:=Record number:C243(Table:C252(vR2)->)
			INSERT IN ARRAY:C227(aRayPointer{3}->; $newSize)  //aLongInt3
			aLongInt3{$newSize}:=-1
			For ($incRay; 4; $rayCnt)
				INSERT IN ARRAY:C227(aRayPointer{$incRay}->; $newSize)
				aRayPointer{$incRay}->{$newSize}:=aFieldPoint{$incRay}->
			End for 
			NEXT RECORD:C51($ptMidFile->)
		End for 
		NEXT RECORD:C51($ptMainFile->)
	End for 
End if 
If (eLinxList>0)
	//  --  CHOPPED  AL_UpdateArrays(eLinxList; -2)
End if 