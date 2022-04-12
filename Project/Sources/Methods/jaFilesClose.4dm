//%attributes = {"publishedWeb":true}
//Procedure: jaFilesClose
//October 25, 1995
BEEP:C151
vSearchBy:=""
vCount:=0
vStr255:=""
ARRAY LONGINT:C221(aCntMatFlds; 0)
ARRAY LONGINT:C221(aCntImpFlds; 0)
ARRAY TEXT:C222(aMatchField; 0)
ARRAY TEXT:C222(aMatchType; 0)
ARRAY LONGINT:C221(aMatchNum; 0)
ARRAY TEXT:C222(theFields; 0)
ARRAY TEXT:C222(aImpFields; 0)
ARRAY TEXT:C222(aBullets; 0)
ARRAY TEXT:C222(theTypes; 0)
ARRAY TEXT:C222(theUniques; 0)
ON ERR CALL:C155("jOECNoAction")
CLOSE DOCUMENT:C267(myDoc)
If (itemMakeDoc>?00:00:00?)
	SEND PACKET:C103(itemMakeDoc; document)
	CLOSE DOCUMENT:C267(itemMakeDoc)
End if 
ON ERR CALL:C155("")
vDocType:="TEXT"
CLEAR VARIABLE:C89(vi1)
CLEAR VARIABLE:C89(vi2)