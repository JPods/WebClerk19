//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $2; $3)
C_POINTER:C301($4; $5)
$pT:=Position:C15($2; $1)
$pP:=Position:C15($3; $1)
Case of 
	: (($pT=0) & ($pP=0))
		$4->:=""
		$5->:=0
	: (($pT=0) | ($pP=0))
		$4->:=($2*(Num:C11($pT>0)))+($3*(Num:C11($pP>0)))
		$5->:=$pT+$pP
	: ($pT<$pP)
		$4->:=$2
		$5->:=$pT
	Else 
		$4->:=$3
		$5->:=$pP
End case 