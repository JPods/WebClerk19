// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/18/07, 14:27:11
// ----------------------------------------------------
// Method: Object Method: CalcTally
// Description
// 
//
// Parameters
// ----------------------------------------------------

//=============
//Write Documemt
//=============

Open window:C153(100; 200; 500; 300; Plain window:K34:13; "Message")  // ### jwm ### 20180718_1516
ERASE WINDOW:C160
GOTO XY:C161(6; 3)
MESSAGE:C88("Starting Script Write Forecast")

vTab:=Char:C90(9)
vCR:=Char:C90(13)

myDoc:=Create document:C266("")

//vtHeader1:="aFCItem"+vTab+"aFCDesc"+vTab+"aFCActionDate"+vTab+"aFCBOMCnt"+vTab+"aFCRunQty"+vTab+"aFCBaseQty"+vTab
//vtHeader2:="aFCBomLevel"+vTab+"aFCParent"+vTab+"aFCTypeTran"+vTab+"aFCDocID"+vTab+"aFCRecNum"+vTab+"aFCWho"+vTab+"aFCtypeID"+vTab
//vtHeader3:="aFCTallyLess2Year"+vTab+"aFCTallyLess1Year"+vTab+"aFCTallyYTD"+vCR

vtHeader1:="ItemNum"+vTab+"Description"+vTab+"Date"+vTab+"Qty Change"+vTab+"Forecast Qty OH"+vTab+"Qty OH"+vTab
vtHeader2:="Tally YTD"+vTab+"Tally YTD-1"+vTab+"Tally YTD-2"+vTab+"Level"+vTab+"Doc Item"+vTab+"Type"+vTab+"Doc ID"+vTab
vtHeader3:="Who"+vTab+"typeID"+vCR

//Include empty column yes or no?

SEND PACKET:C103(myDoc; vtHeader1)
SEND PACKET:C103(myDoc; vtHeader2)
SEND PACKET:C103(myDoc; vtHeader3)
//Send Packet(myDoc;vtHeader4)

vi6:=Size of array:C274(aFCItem)

For (vi5; 1; vi6)
	
	ERASE WINDOW:C160
	GOTO XY:C161(6; 3)
	MESSAGE:C88("Writing Record "+String:C10(vi5)+" of "+String:C10(vi6))
	
	SEND PACKET:C103(myDoc; aFCItem{vi5}+vTab)
	SEND PACKET:C103(myDoc; aFCDesc{vi5}+vTab)
	SEND PACKET:C103(myDoc; String:C10(aFCActionDt{vi5})+vTab)
	SEND PACKET:C103(myDoc; String:C10(aFCBOMCnt{vi5}; " ###,###,##0")+vTab)
	SEND PACKET:C103(myDoc; String:C10(aFCRunQty{vi5}; " ###,###,##0")+vTab)
	SEND PACKET:C103(myDoc; String:C10(aFCBaseQty{vi5}; " ###,###,##0")+vTab)
	SEND PACKET:C103(myDoc; String:C10(aFCTallyYTD{vi5}; " ###,###,##0.00")+vTab)
	SEND PACKET:C103(myDoc; String:C10(aFCTallyLess1Year{vi5}; " ###,###,##0.00")+vTab)
	SEND PACKET:C103(myDoc; String:C10(aFCTallyLess2Year{vi5}; " ###,###,##0.00")+vTab)
	SEND PACKET:C103(myDoc; aFCBomLevel{vi5}+vTab)
	SEND PACKET:C103(myDoc; aFCParent{vi5}+vTab)
	SEND PACKET:C103(myDoc; aFCTypeTran{vi5}+vTab)
	SEND PACKET:C103(myDoc; String:C10(aFCDocID{vi5})+vTab)
	//SEND PACKET(myDoc;String(aFCRecNum{vi5})+vTab)
	SEND PACKET:C103(myDoc; aFCWho{vi5}+vTab)
	SEND PACKET:C103(myDoc; aFCtypeID{vi5}+vCR)
	
	
	
	
End for 

CLOSE DOCUMENT:C267(myDoc)

ERASE WINDOW:C160
GOTO XY:C161(10; 3)
MESSAGE:C88("Ending Script Basic Loop")
CLOSE WINDOW:C154
