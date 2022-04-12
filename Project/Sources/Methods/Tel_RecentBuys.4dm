//%attributes = {"publishedWeb":true}
//Procedure: Tel_RecentBuys
READ ONLY:C145([Customer:2])
QUERY:C277([Customer:2]; [Customer:2]customerID:1=<>CustAcct)
Process_InitLocal
ControlRecCheck
DISABLE MENU ITEM:C150(1; 4)
QUERY:C277([Customer:2]; [Customer:2]customerID:1=<>CustAcct)
FORM SET INPUT:C55([Control:1]; "RecentBuys")
Open window:C153(Screen width:C187-720; 48; Screen width:C187-14; 500; 5; "Last Sales"; "Wind_CloseBox")
DIALOG:C40([Control:1]; "RecentBuys")
CLOSE WINDOW:C154
//ptCurFile:=([Control])
// calSupport:=File([Service])//to be used for mixing calanders between files
//ProcessTableOpen ([Control])

UNLOAD RECORD:C212([Customer:2])
READ WRITE:C146([Customer:2])