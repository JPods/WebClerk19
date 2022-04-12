//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-18T00:00:00, 11:48:05
// ----------------------------------------------------
// Method: WC_MfgArrays
// Description
// Modified: 12/18/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

ARRAY TEXT:C222(<>aMfrCompany; 0)
ARRAY TEXT:C222(<>amfrID; 0)
ARRAY TEXT:C222(<>aMfrDivision; 0)
ARRAY REAL:C219(<>aMfrOpenAmount; 0)
ARRAY REAL:C219(<>aMfrReorderAmount; 0)
ARRAY TEXT:C222(<>aMfrTerms; 0)
ARRAY LONGINT:C221(<>aMfrRecordNum; 0)
QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]active:3=True:C214)
SELECTION TO ARRAY:C260([ManufacturerTerm:111]; <>aMfrRecordNum; [ManufacturerTerm:111]terms:7; <>aMfrTerms; [ManufacturerTerm:111]reOrderAmount:6; <>aMfrReorderAmount; [ManufacturerTerm:111]openingOrderAmount:5; <>aMfrOpenAmount; [ManufacturerTerm:111]division:8; <>aMfrDivision; [ManufacturerTerm:111]customerID:1; <>amfrID; [ManufacturerTerm:111]company:9; <>aMfrCompany)
UNLOAD RECORD:C212([ManufacturerTerm:111])
C_BOOLEAN:C305(<>doMfr)
<>doMfr:=(Size of array:C274(<>aMfrRecordNum)>0)
