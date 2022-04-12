//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k)
C_BOOLEAN:C305($done)
<>prcControl:=0
Open window:C153(4; 40; 635; 475; 8)
Process_InitLocal
KeyModifierCurrent
READ WRITE:C146([Control:1])
jsetDefaultFile(->[Control:1])
jSetAutoReMenus
myOK:=1
ControlRecCheck
DISABLE MENU ITEM:C150(1; 4)
DISABLE MENU ITEM:C150(1; 5)
DISABLE MENU ITEM:C150(1; 6)
DISABLE MENU ITEM:C150(1; 7)
FORM SET INPUT:C55([Control:1]; "ShopFloor")
ptCurTable:=(->[Control:1])
// calSupport:=File([Service])//to be used for mixing calanders between files
ProcessTableOpen(->[Control:1]; "skip")
MESSAGES ON:C181