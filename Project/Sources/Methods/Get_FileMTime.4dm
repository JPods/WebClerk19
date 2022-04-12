//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
End if 

C_TEXT:C284($1; $document)
$document:=$1
C_BOOLEAN:C305($locked; $invisible)
C_DATE:C307($createdOn; $modifiedOn)
C_TIME:C306($createdAt; $modifiedAt)
C_LONGINT:C283($0)

GET DOCUMENT PROPERTIES:C477($document; $locked; $invisible; $createdOn; $createdAt; $modifiedOn; $modifiedAt)

$Hours:=Num:C11(Substring:C12(String:C10($modifiedAt); 1; 2))
$Mins:=Num:C11(Substring:C12(String:C10($modifiedAt); 4; 2))
$Secs:=Num:C11(Substring:C12(String:C10($modifiedAt); 7; 2))

$0:=($Hours*3600)+($Mins*60)+$Secs