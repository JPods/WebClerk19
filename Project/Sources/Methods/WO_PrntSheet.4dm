//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $w; $e)
ARRAY LONGINT:C221(aPOs; 0)
ARRAY TEXT:C222(a1Str35; 0)
ARRAY TEXT:C222(a2Str35; 0)
ARRAY TEXT:C222(a3Str35; 0)
_O_PAGE SETUP:C299([WorkOrder:66]; "RptWkOrd")
PRINT SETTINGS:C106
If (OK=1)
	If (vHere>=2)
		WO_PrntOne
	Else 
		FIRST RECORD:C50([WorkOrder:66])
		For ($e; 1; Records in selection:C76([WorkOrder:66]))
			WO_PrntOne
			NEXT RECORD:C51([WorkOrder:66])
		End for 
	End if 
	ARRAY LONGINT:C221(aPOs; 0)
	ARRAY TEXT:C222(a1Str35; 0)
	ARRAY TEXT:C222(a2Str35; 0)
	ARRAY TEXT:C222(a3Str35; 0)
End if 