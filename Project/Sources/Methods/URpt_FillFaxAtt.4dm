//%attributes = {"publishedWeb":true}
//Procedure: FAX_FillFaxAttL
//fill the array that will track fax attachments
MESSAGES OFF:C175
ARRAY LONGINT:C221(<>yURFAUniqID; 0)
ARRAY TEXT:C222(<>yURFAName; 0)
CREATE SET:C116([UserReport:46]; "SaveRecs")
QUERY:C277([UserReport:46]; [UserReport:46]Creator:6="4com"; *)
QUERY:C277([UserReport:46];  & [UserReport:46]Active:1=True:C214)
ORDER BY:C49([UserReport:46]; [UserReport:46]Name:2)
SELECTION TO ARRAY:C260([UserReport:46]idUnique:17; <>yURFAUniqID; [UserReport:46]Name:2; <>yURFAName)
INSERT IN ARRAY:C227(<>yURFAUniqID; 1)
INSERT IN ARRAY:C227(<>yURFAName; 1)
<>yURFAUniqID{1}:=-1
<>yURFAName{1}:="None"
USE SET:C118("SaveRecs")
CLEAR SET:C117("SaveRecs")
MESSAGES ON:C181