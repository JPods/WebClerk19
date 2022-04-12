//%attributes = {"publishedWeb":true}
//Procedure: jimport_FillRay
C_LONGINT:C283($0)
//
C_LONGINT:C283($i; $k; $cntFields)
$cntFields:=Size of array:C274(aImpFields)
$k:=$cntFields-1
For ($i; 1; $k)
	aImpFields{$i}:=""
	RECEIVE PACKET:C104(myDoc; aImpFields{$i}; vFldDelim)
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
RECEIVE PACKET:C104(myDoc; aImpFields{$cntFields}; vRecDelim)
$0:=OK
If (vFldSepBeg#"")
	If (vFldSepBeg=aImpFields{$cntFields}[[1]])
		aImpFields{$cntFields}:=Substring:C12(aImpFields{$cntFields}; 2)
	End if 
End if 
If (vFldSepEnd#"")
	$lenIncome:=Length:C16(aImpFields{$cntFields})
	If (vFldSepEnd=aImpFields{$cntFields}[[$lenIncome]])
		aImpFields{$cntFields}:=Substring:C12(aImpFields{$cntFields}; 1; $lenIncome-1)
	End if 
End if 
If (Character code:C91(aImpFields{1})=10)
	aImpFields{1}:=Substring:C12(aImpFields{1}; 2)
	If (vFldSepBeg#"")
		If (vFldSepBeg=aImpFields{1}[[1]])
			aImpFields{1}:=Substring:C12(aImpFields{1}; 2)
		End if 
	End if 
End if 