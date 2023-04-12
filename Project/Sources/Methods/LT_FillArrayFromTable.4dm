//%attributes = {"publishedWeb":true}
//LT_FillArrayFromTable
ARRAY LONGINT:C221($aLtStage; $1)
ARRAY LONGINT:C221($aLtShipOn; $1)
ARRAY LONGINT:C221($aLtCustoms; $1)
ARRAY LONGINT:C221($aLtExpected; $1)
ARRAY DATE:C224(aLtStage; $1)
ARRAY DATE:C224(aLtShipOn; $1)
ARRAY DATE:C224(aLtCustoms; $1)
ARRAY DATE:C224(aLtExpected; $1)
SELECTION TO ARRAY:C260([LoadTag:88]; aLtTagRecordID; [LoadTag:88]idNum:1; aLtLoadTagID; [LoadTag:88]documentID:17; aLtOrderNum; [LoadTag:88]idNumPO:18; aLtPoNum; [LoadTag:88]idNumInvoice:19; aLtinvoiceNum; [LoadTag:88]status:6; aLtTagStatus; [LoadTag:88]trackingid:7; aLttrackID)
SELECTION TO ARRAY:C260([LoadTag:88]weightExtended:2; aLtWeightExt; [LoadTag:88]width:3; aLtTagWidth; [LoadTag:88]height:4; aLtTagHeight; [LoadTag:88]length:5; aLtTagDepth; [LoadTag:88]carrierid:8; aLtCarrier; [LoadTag:88]dtAssembly:9; $aLtStage; [LoadTag:88]dtShipOn:10; $aLtShipOn)
SELECTION TO ARRAY:C260([LoadTag:88]dtCustoms:11; $aLtCustoms; [LoadTag:88]dtReceiveExpected:12; $aLtExpected; [LoadTag:88]insuranceid:16; aLtInsureID; [LoadTag:88]hazardClass:20; aLtHazard)
//
C_LONGINT:C283($i; $k)
For ($i; 1; $k)
	DateTime_DTFrom($aLtStage{$i}; ->aLtStage{$i})
	DateTime_DTFrom($aLtShipOn{$i}; ->aLtShipOn{$i})
	DateTime_DTFrom($aLtCustoms{$i}; ->aLtCustoms{$i})
	DateTime_DTFrom($aLtExpected{$i}; ->aLtExpected{$i})
End for 
ARRAY LONGINT:C221(aLtTagSelect; Num:C11(Size of array:C274(aLtTagRecordID)>0))