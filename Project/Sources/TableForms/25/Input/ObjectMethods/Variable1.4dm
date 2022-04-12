// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/17/11, 18:29:09
// ----------------------------------------------------
// Method: Object Method: b1
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(bItemXRefs)
QUERY:C277([Customer:2]; [Customer:2]zip:8>=[Territory:25]beginningZip:4; *)
QUERY:C277([Customer:2];  & [Customer:2]zip:8<=[Territory:25]endingZip:5)
DB_ShowCurrentSelection(->[Customer:2]; ""; 1; "Territory Range: "+[Territory:25]beginningZip:4+"->"+[Territory:25]endingZip:5)

QUERY:C277([Lead:48]; [Lead:48]zip:10>=[Territory:25]beginningZip:4; *)
QUERY:C277([Lead:48];  & [Lead:48]zip:10<=[Territory:25]endingZip:5)
DB_ShowCurrentSelection(->[Lead:48]; ""; 1; "Territory Range: "+[Territory:25]beginningZip:4+"->"+[Territory:25]endingZip:5)