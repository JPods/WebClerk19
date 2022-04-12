//%attributes = {"publishedWeb":true}
//Procedure: Ivt_VndsLowItms
TRACE:C157
If (<>prcControl=1)
	//If (Records in SET("<>curSelSet")>0)
	<>prcControl:=0
	Process_InitLocal
	myOK:=11
	USE SET:C118("<>curSelSet")
	CLEAR SET:C117("<>curSelSet")
	Open window:C153(4; 40; 635; 475; 8)
End if 
TRACE:C157
ptCurTable:=(->[Item:4])
Itm_FillLowVend(0; 0; 0; 0; 0)
ControlRecCheck
doQuickQuote:=1
FORM SET INPUT:C55([Control:1]; "VendorLowItem")
doQuickQuote:=0
ProcessTableOpen(->[Control:1])
ARRAY LONGINT:C221(aLwVndLines; 0)
Vnd_FillLwItms(0)
ARRAY LONGINT:C221(aLwItmLines; 0)
Itm_FillLowVend(0; 0; 0; 0; 0)  //action; element; num elements