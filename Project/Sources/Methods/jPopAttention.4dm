//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
INSERT IN ARRAY:C227(aContact; 1; 1)
aContact{1}:="Contact"
// zzzqqq PopUpWildCard($1; ->aContact; ->[Contact:13])
// zzzqqq jCapitalize1st($1)
DELETE FROM ARRAY:C228(aContact; 1; 1)
If (Substring:C12($1->; 1; 2)=" ")
	$1->:=Substring:C12($1->; 3; 80)
End if 