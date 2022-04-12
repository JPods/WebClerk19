//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/20/02
	//Who: Peter Fleming, Arkware
	//Description: Spawns zipcode import process
	VERSION_960
End if 

C_TEXT:C284($theName)
$theName:=String:C10(Count user processes:C343)+Table name:C256(->[QQQZipCode:96])
<>processAlt:=New process:C317("Zip_Import"; <>tcPrsMemory; $theName)
Prs_ListActive