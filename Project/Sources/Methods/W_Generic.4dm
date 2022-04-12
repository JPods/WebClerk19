//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($2)
C_TEXT:C284($1)

$dialog:=$1  //Name of the table AND the dialog
$params:=$2

$table:=cs:C1710.TableShow.new($dialog)
$table.showIt($params)


