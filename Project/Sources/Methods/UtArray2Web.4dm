//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtArray2Web
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

C_TEXT:C284($1; $3; $5; $7; $9; $11; $13; $15; $17)
C_LONGINT:C283($2; $4; $6; $8; $10; $12; $14; $16)

C_TEXT:C284($pageOut)

C_LONGINT:C283($cntParameters; $i; $k; $cntAccross; $incAcross)
$cntParameters:=Count parameters:C259
$cntReportOut:=Size of array:C274(aRptAccumOut)
If (Size of array:C274(aRptAccumOut{1}->)=0)
	$0:="No data"
Else 
	$cntAccross:=Size of array:C274(aRptAccumOut)
	ARRAY LONGINT:C221($aTDType; $cntAccross)
	ARRAY TEXT:C222($aTDValue; $cntAccross)
	ARRAY TEXT:C222($aTDNames; $cntAccross)
	$i:=0
	If ($cntParameters>1)
		$aTDNames{1}:=$1
		$aTDType{1}:=$2
		If ($cntParameters>3)
			$aTDNames{2}:=$3
			$aTDType{2}:=$4
			If ($cntParameters>5)
				$aTDNames{3}:=$5
				$aTDType{3}:=$6
				If ($cntParameters>7)
					$aTDNames{4}:=$7
					$aTDType{4}:=$8
					If ($cntParameters>9)
						$aTDNames{5}:=$9
						$aTDType{5}:=$10
						If ($cntParameters>11)
							$aTDNames{6}:=$11
							$aTDType{6}:=$12
							If ($cntParameters>13)
								$aTDNames{7}:=$13
								$aTDType{7}:=$14
								If ($cntParameters>15)
									$aTDNames{8}:=$15
									$aTDType{8}:=$16
								End if 
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
	$i:=0
	
	For ($incAcross; 1; $cntAccross)
		Case of 
			: ($aTDType{$incAcross}=1)
				$aTDValue{$incAcross}:="<TD>"
			: ($aTDType{$incAcross}=2)
				$aTDValue{$incAcross}:="<TD align="+Txt_Quoted("right")+">"
			Else 
				$aTDValue{$incAcross}:="<TD align="+Txt_Quoted("center")+">"
		End case 
	End for 
	C_LONGINT:C283($theType)
	$pageOut:="<Table width="+Txt_Quoted("100%")+"><TR>"+"\r"
	For ($incAcross; 1; $cntAccross)
		$pageOut:=$pageOut+$aTDValue{$incAcross}+$aTDNames{$incAcross}+"</TD>"
	End for 
	$pageOut:=$pageOut+"</TR>"+"\r"
	$k:=Size of array:C274(aRptAccumOut{1}->)
	For ($i; 1; $k)
		$pageOut:=$pageOut+"<TR>"+"\r"
		For ($incAcross; 1; $cntAccross)
			Case of 
				: ($aTDType{$incAcross}=2)
					$pageOut:=$pageOut+$aTDValue{$incAcross}+String:C10(aRptAccumOut{$incAcross}->{$i}; "###,###,##0")+"</TD>"
				: ($aTDType{$incAcross}=3)
					$pageOut:=$pageOut+$aTDValue{$incAcross}+String:C10(aRptAccumOut{$incAcross}->{$i})+"</TD>"
				Else 
					$pageOut:=$pageOut+$aTDValue{$incAcross}+aRptAccumOut{$incAcross}->{$i}+"</TD>"
			End case 
		End for 
		$pageOut:=$pageOut+"</TR>"+"\r"
	End for 
	$0:=$pageOut+"</TABLE>"+"\r"
End if 
