//%attributes = {"publishedWeb":true}
//Procedure: Prs_ReleaseRecs
C_POINTER:C301($1)
C_LONGINT:C283($thePrc; $i; $k)
$thePrc:=Current process:C322
Prs_ListActive
$k:=Size of array:C274(<>aPrsNum)
For ($i; 1; $k)
	BRING TO FRONT:C326(<>aPrsNum{$i})
	REDUCE SELECTION:C351($1->; 0)
End for 
BRING TO FRONT:C326($thePrc)