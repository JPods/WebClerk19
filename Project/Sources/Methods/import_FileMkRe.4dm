//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $w; $parsLen; $endLoop)
C_TEXT:C284($theKey)
C_POINTER:C301($ptRay; $4)
C_TEXT:C284($1; $2; $3)
C_PICTURE:C286($thePict)
C_BLOB:C604($loadBlob)
READ WRITE:C146($4->)
TRACE:C157
$parsLen:=Length:C16($2)
$k:=Size of array:C274(aImpFields)
If (($k>1) & ($k<41))
	$cntflds:=Size of array:C274(aImpFields)-1
	ARRAY POINTER:C280($aPtRay; $k)
	For ($i; 1; $k)
		$aPtRay{$i}:=Get pointer:C304("<>aText"+String:C10($i))
		ARRAY TEXT:C222($aPtRay{$i}->; 0)
	End for 
	Repeat 
		For ($i; 1; $k)
			If ($i>1)
				ARRAY TEXT:C222($aPtRay{$i}->; 0)
				$endLoop:=1
				Repeat 
					$pos:=Position:C15($2; aImpFields{$i})
					$w:=Size of array:C274($aPtRay{$i}->)+1
					INSERT IN ARRAY:C227($aPtRay{$i}->; $w; 1)
					If ($pos>0)
						$aPtRay{$i}->{$w}:=Substring:C12(aImpFields{$i}; 1; $pos-1)
						aImpFields{$i}:=Substring:C12(aImpFields{$i}; $pos+$parsLen)
					Else 
						$aPtRay{$i}->{$w}:=aImpFields{$i}
						$endLoop:=2
					End if 
				Until ($endLoop=2)
			Else 
				$theKey:=aImpFields{1}  //key field gets repeated
			End if 
		End for 
		ARRAY TEXT:C222(<>aText1; $w)
		$endLoop:=1
		C_LONGINT:C283($ptRayCnt; $ptRayIncr)
		$ptRayCnt:=Size of array:C274($aPtRay)
		For ($incRay; 1; $w)
			$doRecord:=False:C215
			$ptRayIncr:=1  //skip the first array
			Repeat 
				$ptRayIncr:=$ptRayIncr+1
				If (Length:C16($aPtRay{$ptRayIncr}->{$incRay})>0)
					$doRecord:=True:C214
					$ptRayIncr:=$ptRayCnt
				End if 
			Until ($ptRayCnt=$ptRayIncr)
			If ($doRecord)
				<>aText1{$incRay}:=$theKey
				CREATE RECORD:C68($4->)
				For ($i; 1; $k)
					$ptTheRay:=Get pointer:C304("<>aText"+String:C10($i))
					Case of 
							//  : ($Match=-2)
							//
						: ((aMatchType{$i}="A") | (aMatchType{$i}="T"))
							Field:C253(curTableNum; aMatchNum{$i})->:=$ptTheRay->{$incRay}
						: ((aMatchType{$i}="R") | (aMatchType{$i}="I") | (aMatchType{$i}="L"))
							Field:C253(curTableNum; aMatchNum{$i})->:=Num:C11($ptTheRay->{$incRay})
						: (aMatchType{$i}="H")
							Field:C253(curTableNum; aMatchNum{$i})->:=Time:C179($ptTheRay->{$incRay})
						: (aMatchType{$i}="D")
							Field:C253(curTableNum; aMatchNum{$i})->:=Date:C102($ptTheRay->{$incRay})
						: (aMatchType{$i}="B")
							Field:C253(curTableNum; aMatchNum{$i})->:=(($ptTheRay->{$incRay}="1") | ($ptTheRay->{$incRay}="true") | ($ptTheRay->{$incRay}="Yes") | ($ptTheRay->{$incRay}="Y"))
						: (aMatchType{$i}="P")
							If (HFS_Exists($ptTheRay->{$incRay})=1)
								DOCUMENT TO BLOB:C525($ptTheRay->{$incRay}; $loadBlob)
								BLOB TO PICTURE:C682($loadBlob; $thePict)
								If ($err=0)
									Field:C253(curTableNum; aMatchNum{$i})->:=$thePict
								End if 
							End if 
					End case 
				End for 
				SAVE RECORD:C53($4->)
			End if 
		End for 
		If ($endLoop=1)
			For ($i; 1; $cntflds)
				aImpFields{$i}:=""
				RECEIVE PACKET:C104(myDoc; aImpFields{$i}; $1)
			End for 
			RECEIVE PACKET:C104(myDoc; aImpFields{cntFields}; $3)
			$endLoop:=OK
		Else 
			$endLoop:=0
		End if 
	Until ($endLoop=0)
	For ($i; 1; $k)
		ARRAY TEXT:C222($aPtRay{$i}->; 0)
	End for 
End if 

REDRAW WINDOW:C456