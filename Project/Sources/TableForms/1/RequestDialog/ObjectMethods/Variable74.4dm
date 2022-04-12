//Script: bBarCode
C_LONGINT:C283(bBarCode)
//BarC_listItmsFl 

vsBarCdFld:=""
Open window:C153(40; 40; 200; 70; 1)  //(19;165;19;165;1)
DIALOG:C40([DefaultQQQ:15]; "diaBarCode")
CLOSE WINDOW:C154
srItem:=vsBarCdFld
ACCEPT:C269
myOK:=1