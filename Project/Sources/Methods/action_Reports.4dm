//%attributes = {}



// 4D_25Invoice - 2022-01-15
USE ENTITY SELECTION:C1513(Form:C1466.displayedSelection)
$dataClassPtr:=Table:C252(Form:C1466.dataClass.getInfo().tableNumber)
QR REPORT:C197($dataClassPtr->;Char:C90(1))
