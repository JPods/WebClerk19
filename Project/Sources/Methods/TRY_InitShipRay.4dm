//%attributes = {"publishedWeb":true}
ARRAY LONGINT:C221(aPOLines; 0)  //arrays used to record adjustments
ARRAY TEXT:C222(aInvParts; 0)
ARRAY REAL:C219(adQtyOnOrd; 0)
ARRAY TEXT:C222(aTexts; 0)
ARRAY LONGINT:C221(aJobLists; 0)
ARRAY REAL:C219(aItemCosts; 0)
ARRAY TEXT:C222(aStr20; 0)
ARRAY BOOLEAN:C223(aPOLnCom; 0)  //arrays used to track completed PO lines
ARRAY LONGINT:C221(aPOChanged; 0)
ARRAY LONGINT:C221(aRecieptID; 0)
//
ARRAY TEXT:C222(aBackOrder; 0)  //arrays used for PO Line info
ARRAY TEXT:C222(aPartNum; 0)
ARRAY REAL:C219(aQtyOnPOLns; 0)
ARRAY REAL:C219(aQtyRecds; 0)
ARRAY LONGINT:C221(aPOLnNo; 0)
ARRAY REAL:C219(aPOLnCosts; 0)
//
ARRAY TEXT:C222(aBullets; 0)
ARRAY TEXT:C222(aCustCodes; 0)  //arrays used for PO info
ARRAY LONGINT:C221(aOpenPOs; 0)
ARRAY LONGINT:C221(aJobs; 0)
//
ARRAY LONGINT:C221(aPOCom; 0)  //arrays used to track completed POs
For ($i; 1; 6)
	$ptSet:=Get pointer:C304("v"+String:C10($i))
	$ptSet->:=""
End for 
vr1:=0
vPOLineCnt:=0
vi3:=0
vi4:=0
vr2:=0