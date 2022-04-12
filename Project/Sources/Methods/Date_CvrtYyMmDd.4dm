//%attributes = {"publishedWeb":true}
//Procedure: Date_CvrtYyMmDd
C_DATE:C307($0)
C_TEXT:C284($1)
If (<>vbDateByDDMMYY)
	$0:=Date:C102(Substring:C12($1; 5; 2)+"/"+Substring:C12($1; 3; 2)+"/"+String:C10(Date_YrCent(Substring:C12($1; 1; 2))))
Else 
	$0:=Date:C102(Substring:C12($1; 3; 2)+"/"+Substring:C12($1; 5; 2)+"/"+String:C10(Date_YrCent(Substring:C12($1; 1; 2))))
End if 