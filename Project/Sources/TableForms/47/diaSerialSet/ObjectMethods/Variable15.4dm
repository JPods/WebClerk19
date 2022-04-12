//Script: bBarCode
C_LONGINT:C283(bBarCode)
C_LONGINT:C283(bBarCodeSt)
Open window:C153(19; 165; 19; 165; 1)
DIALOG:C40([DefaultQQQ:15]; "diaBarCode")
CLOSE WINDOW:C154
//vsBarCdFld  is filled out in window
vsnSrNum:=vsBarCdFld
vi1:=1
POST KEY:C465(Character code:C91("}"); 256)