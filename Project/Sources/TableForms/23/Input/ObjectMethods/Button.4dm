// ### bj ### 20210809_1833
C_COLLECTION:C1488($cTemp)
$cTemp:=New collection:C1472

C_OBJECT:C1216($obCollectionBuild)
$obCollectionBuild:=New object:C1471("tableName"; "PopupChoice"; "queryString"; ""; "queryParameters"; ""; "fieldList"; "")
$obCollectionBuild.tableName:="PopupChoice"
$obCollectionBuild.queryString:="arrayName = :1"
// $obCollectionBuild.queryParameters:=Form.
$obCollectionBuild.queryValue1:=[PopUp:23]arrayName:3
$obCollectionBuild.fieldList:="choice,alternate,id"

$cTemp:=LBData_PopupChoice($obCollectionBuild)