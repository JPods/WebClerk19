//%attributes = {"publishedWeb":true}
//Procedure: Srl_SrchCustVen
//C_BOOLEAN($viewOnly)
C_BOOLEAN:C305($popCust; $popVend)
C_TEXT:C284(srSrlNum)
C_REAL:C285(vClaim)
$popCust:=False:C215
$popVend:=False:C215
srSrlNum:=""
If (vHere>1)
	If (Record number:C243([Customer:2])>-1)
		PUSH RECORD:C176([Customer:2])
		$popCust:=True:C214
	End if 
	If (Record number:C243([Vendor:38])>-1)
		PUSH RECORD:C176([Vendor:38])
		$popVend:=True:C214
	End if 
Else 
	REDUCE SELECTION:C351([Customer:2]; 0)
	REDUCE SELECTION:C351([Vendor:38]; 0)
End if 
REDUCE SELECTION:C351([ItemSerial:47]; 0)
REDUCE SELECTION:C351([Contact:13]; 0)
UNLOAD RECORD:C212([ItemSerial:47])
initCustArrays(0)
vClaim:=0
ARRAY TEXT:C222(aText1; 0)
jCenterWindow(595; 243; 1)
DIALOG:C40([ItemSerial:47]; "DiaFindCustVend")
CLOSE WINDOW:C154
ARRAY TEXT:C222(aSrlItemSr; 0)
ARRAY LONGINT:C221(aSrlRec; 0)
ARRAY LONGINT:C221(aSrlRecNum; 0)
ARRAY TEXT:C222(aText1; 0)
initCustArrays(0)
srSrlNum:=""
If ($popCust)
	POP RECORD:C177([Customer:2])
End if 
If ($popVend)
	POP RECORD:C177([Vendor:38])
End if 