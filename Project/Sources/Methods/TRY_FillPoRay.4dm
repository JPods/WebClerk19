//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([PO:39])
ARRAY TEXT:C222(aBullets; $k)
ARRAY TEXT:C222(aCustCodes; $k)  //arrays used for PO info
ARRAY LONGINT:C221(aOpenPOs; $k)
ARRAY LONGINT:C221(aJobs; $k)
FIRST RECORD:C50([PO:39])
For ($i; 1; $k)
	Case of 
		: ([PO:39]completeId:65=0)
			aBullets{$i}:=""
		: ([PO:39]completeId:65=1)
			aBullets{$i}:="p"
		Else 
			aBullets{$i}:="x"
	End case 
	aCustCodes{$i}:=[PO:39]vendorId:1
	aJobs{$i}:=[PO:39]projectNum:6
	aOpenPOs{$i}:=[PO:39]poNum:5
	NEXT RECORD:C51([PO:39])
End for 
UNLOAD RECORD:C212([PO:39])
aJobs:=0
$k:=0
ARRAY TEXT:C222(aBackOrder; $k)
ARRAY TEXT:C222(aPartNum; $k)
ARRAY REAL:C219(aQtyOnPOLns; $k)
ARRAY REAL:C219(aQtyRecds; $k)
ARRAY LONGINT:C221(aPOLnNo; $k)
ARRAY REAL:C219(aPOLnCosts; $k)