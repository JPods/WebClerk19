//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/06/10, 21:18:38
// ----------------------------------------------------
// Method: showOpenOrders
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (<>prcControl=1)
	<>prcControl:=0
	Open window:C153(4; 40; 635; 475; 8)
	Process_InitLocal
	ptCurTable:=(->[Control:1])
End if 
QUERY:C277([Order:3]; [Order:3]complete:83<2)
DB_ShowCurrentSelection(->[Order:3])