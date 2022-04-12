

C_LONGINT:C283($viCnt; $viInc)
$viCnt:=LISTBOX Get number of columns:C831(*; "LBDraftTable")
//for($viInc;$viCnt;0;-1)
// LISTBOX DELETE COLUMN(*; "LBDraftTable"; colPosition{; number})
LISTBOX DELETE COLUMN:C830(*; "LBDraftTable"; 1; $viCnt)