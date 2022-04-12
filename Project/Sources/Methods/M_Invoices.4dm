//%attributes = {}



// 4D_25Invoice - 2022-01-15
  //Method called by the Menu
$params:=New object:C1471
$params.useSelection:=False:C215
CALL WORKER:C1389(1;"W_Generic";"Invoices";$params)