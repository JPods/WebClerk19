

C_LONGINT:C283($viCnt; $viInc)
$viCnt:=LISTBOX Get number of columns:C831(*; "LB_Draft")
//for($viInc;$viCnt;0;-1)
// LISTBOX DELETE COLUMN(*; "LB_Draft"; colPosition{; number})
LISTBOX DELETE COLUMN:C830(*; "LB_Draft"; 1; $viCnt)