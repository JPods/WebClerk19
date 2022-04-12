//%attributes = {"publishedWeb":true}
//(P)   jimpGenImpArray
C_TEXT:C284($v1; $v2)
C_LONGINT:C283($i; cntFields)
C_TEXT:C284($ltr)
cntFields:=0
ARRAY LONGINT:C221(aCntImpFlds; 0)
ARRAY TEXT:C222(aImpFields; 0)
ARRAY TEXT:C222(aBullets; 0)
RECEIVE PACKET:C104(myDoc; $v1; vRecDelim)

$v1:=TxtStripLineFeed($v1)

Case of 
	: (Length:C16($v1)>0)
		For ($i; 1; Length:C16($v1))
			$ltr:=Substring:C12($v1; $i; 1)
			If ($ltr#vFldDelim)
				$v2:=$v2+$ltr
			Else 
				cntFields:=cntFields+1
				INSERT IN ARRAY:C227(aCntImpFlds; cntFields; 1)
				INSERT IN ARRAY:C227(aImpFields; cntFields; 1)
				INSERT IN ARRAY:C227(aBullets; cntFields; 1)
				aCntImpFlds{cntFields}:=cntFields
				aImpFields{cntFields}:=$v2
				aBullets{cntFields}:=""
				$v2:=""
			End if 
		End for 
		cntFields:=cntFields+1
		INSERT IN ARRAY:C227(aCntImpFlds; cntFields; 1)
		INSERT IN ARRAY:C227(aImpFields; cntFields; 1)
		INSERT IN ARRAY:C227(aBullets; cntFields; 1)
		aCntImpFlds{cntFields}:=cntFields
		aImpFields{cntFields}:=$v2
		aBullets{cntFields}:=""
	: (OK#1)
		CLOSE DOCUMENT:C267(myDoc)
		ALERT:C41("No Fields/Records could be imported.")
		ABORT:C156
	: (Length:C16($v1)=0)
		Repeat 
			RECEIVE PACKET:C104(myDoc; $v1; vRecDelim)
		Until ((OK=0) | (Length:C16($v1)>0))
		If (Length:C16($v1)>0)
			For ($i; 1; Length:C16($v1))
				$ltr:=Substring:C12($v1; $i; 1)
				If ($ltr#vFldDelim)
					$v2:=$v2+$ltr
				Else 
					cntFields:=cntFields+1
					INSERT IN ARRAY:C227(aCntImpFlds; cntFields; 1)
					INSERT IN ARRAY:C227(aImpFields; cntFields; 1)
					INSERT IN ARRAY:C227(aBullets; cntFields; 1)
					aCntImpFlds{cntFields}:=cntFields
					aImpFields{cntFields}:=$v2
					aBullets{cntFields}:=""
					$v2:=""
				End if 
			End for 
			cntFields:=cntFields+1
			INSERT IN ARRAY:C227(aCntImpFlds; cntFields; 1)
			INSERT IN ARRAY:C227(aImpFields; cntFields; 1)
			INSERT IN ARRAY:C227(aBullets; cntFields; 1)
			aCntImpFlds{cntFields}:=cntFields
			aImpFields{cntFields}:=$v2
			aBullets{cntFields}:=""
		Else 
			CLOSE DOCUMENT:C267(myDoc)
			ALERT:C41("No Fields/Records could be imported.")
			ABORT:C156
		End if 
End case 
cntFields:=Size of array:C274(aImpFields)
If (cntFields>0)
	If ((vFldSepBeg#"") | (vFldSepEnd#""))
		For ($i; 1; cntFields)
			If (vFldSepBeg#"")
				If (vFldSepBeg=aImpFields{$i}[[1]])
					aImpFields{$i}:=Substring:C12(aImpFields{$i}; 2)
				End if 
			End if 
			If (vFldSepEnd#"")
				$lenIncome:=Length:C16(aImpFields{$i})
				If (vFldSepEnd=aImpFields{$i}[[$lenIncome]])
					aImpFields{$i}:=Substring:C12(aImpFields{$i}; 1; $lenIncome-1)
				End if 
			End if 
		End for 
	End if 
End if 