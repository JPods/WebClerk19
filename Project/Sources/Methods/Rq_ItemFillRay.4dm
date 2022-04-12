//%attributes = {"publishedWeb":true}
//Procedure: Rq_ItemFillRay
//Procedure: RqOrdLnFillRays  check this before changing
C_LONGINT:C283($lnTest; $i; $w; $k)  //$1 number of lines
OrdLnRays(0)
TRACE:C157
If (Size of array:C274(<>aItemLines)=0)
	C_BOOLEAN:C305($doRecs)
	$doRecs:=True:C214
	$k:=Records in selection:C76([Item:4])
	FIRST RECORD:C50([Item:4])
Else 
	$doRecs:=False:C215
	$k:=Size of array:C274(<>aItemLines)
End if 
For ($i; 1; $k)
	If (Not:C34($doRecs))
		GOTO RECORD:C242([Item:4]; <>aItemLines{$i})
	End if 
	$w:=Size of array:C274(aOLineNum)+1
	OrdLn_RaySize(1; $w; 1)
	aOPricePt{$w}:="It"
	aOSerialRc{$w}:=0
	aOLineNum{$w}:=0
	aOItemNum{$w}:=[Item:4]itemNum:1
	aODescpt{$w}:=[Item:4]description:7
	aOQtyOrder{$w}:=[Item:4]qtySaleDefault:15
	aODscntUP{$w}:=[Item:4]priceA:2
	aOExtPrice{$w}:=[Item:4]qtySaleDefault:15*[Item:4]priceA:2
	aOExtCost{$w}:=[Item:4]qtySaleDefault:15*[Item:4]costAverage:13
	
	aOUnitMeas{$w}:=[Item:4]unitOfMeasure:11
	aOUnitWt{$w}:=[Item:4]weightAverage:8
	aOExtWt{$w}:=[Item:4]weightAverage:8*[Item:4]qtySaleDefault:15
	aOLocation{$w}:=[Item:4]location:9
	aOSeq{$w}:=$w
	aODateReq{$w}:=Current date:C33+[Item:4]leadTimePo:55
	aoDateShipOn{$w}:=ShipOnDate(aODateReq{$w}; [Item:4]leadTimePo:55)
	aoDateShipOn{$w}:=Current date:C33+[Item:4]leadTimePo:55
	aoDateShipped{$w}:=!00-00-00!
	aoProdBy{$w}:=Current user:C182
	If ($doRecs)
		NEXT RECORD:C51([Item:4])
	End if 
End for 
UNLOAD RECORD:C212([Item:4])