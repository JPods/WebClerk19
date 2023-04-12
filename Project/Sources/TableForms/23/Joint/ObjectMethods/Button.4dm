
CANCEL:C270


C_COLLECTION:C1488($cTemp)
C_OBJECT:C1216($obSel)
$obSel:=New object:C1471
$obSel:=ds:C1482["PopUp"].all()
$obSel.orderBy("listName")
$cTemp:=New collection:C1472
C_COLLECTION:C1488($cFilter)
$cFilter:=Split string:C1554("listName,arrayName;whereUsed,id"; ";")
$cTemp:=$obSel.toCollection($cFilter)

Form:C1466.cPopup:=$cTemp