//%attributes = {"publishedWeb":true}
//Method: WR_ReplaceInSelect
//WR_ReplaceInSelect(->[TechNote]Body_;"theCustomer";"CommerceExpert")
C_LONGINT:C283($i; $k; $w)
C_POINTER:C301($1; $ptPictField; $ptTable)
C_TEXT:C284($findBegin; $2; $findEnd; $3)
C_LONGINT:C283($offArea; $err)
If (Count parameters:C259=3)
	$ptPictField:=$1
	$findBegin:=$2
	$findEnd:=$3
	$ptTable:=(Table:C252(Table:C252($ptPictField)))
	$k:=Records in selection:C76($ptTable->)
	FIRST RECORD:C50($ptTable->)
	For ($i; 1; $k)
		//$offArea:=//**WR New offscreen area 
		//$offArea:=  //**WR O Picture to offscreen area ($ptPictField->)
		//$err:=  //**WR O Replace ($offArea;$findBegin;$findEnd;1;1;1)
		//area; what; change; partial/whole; notcase/case; next/all
		//$ptPictField->:=  //**WR Area to picture ($offArea)
		//**WR DELETE OFFSCREEN AREA ($offArea)
		SAVE RECORD:C53($ptTable->)
		NEXT RECORD:C51($ptTable->)
	End for 
End if 