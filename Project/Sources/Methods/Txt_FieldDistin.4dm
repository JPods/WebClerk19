//%attributes = {"publishedWeb":true}
//Procedure: Txt_FieldDistin([Customer];[Customer]Prospect)
C_POINTER:C301($1; $2)
C_LONGINT:C283($3)
//
C_LONGINT:C283($doSearch)
//
$doSearch:=$3
//
curTableNum:=Table:C252($1)
If ($3=0)
	ALL RECORDS:C47($1->)
Else 
	File_dSelection($1)
End if 
HTML_Distinct($2; -3; $1; "SkipSearch"; ->aText1)
If ((vHere>1) & (ptCurTable=(->[PopUp:23])))
	
	C_LONGINT:C283($cntRay; $incRay)
	$cntRay:=Size of array:C274(aText1)
	C_TEXT:C284($uniqueText)
	For ($incRay; 1; $cntRay)
		$uniqueText:=$uniqueText+aText1{$incRay}+"\r"
	End for 
	SET TEXT TO PASTEBOARD:C523($uniqueText)
	ALERT:C41("Unique Values on Clipboard")
End if 
