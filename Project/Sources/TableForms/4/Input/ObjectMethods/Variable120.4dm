// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/16/12, 13:35:18
// ----------------------------------------------------
// Method: Object Method: [Item].iItems_9.bItemXRefs
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(bItemXRefs)
QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumMaster:1=[Item:4]itemNum:1; *)
QUERY:C277([ItemXRef:22];  | ; [ItemXRef:22]itemNumXRef:2=[Item:4]itemNum:1; *)  //### jwm ### 20121016_1242
QUERY:C277([ItemXRef:22])  //### jwm ### 20121016_1242


DB_ShowCurrentSelection(->[ItemXRef:22]; ""; 1; "For "+[Item:4]itemNum:1; 1)
// table pointer; no script; use current selection; header add; leave current selection in this process 