//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-27T00:00:00, 01:20:53
// ----------------------------------------------------
// Method: jsonParseToArray
// Description
// Modified: 08/27/17
// 
// 
//
// Parameters
// ----------------------------------------------------
// testing
C_OBJECT:C1216($obCatalog)
$obCatalog:=New object:C1471
$obCatalog.id:=99222
$obCatalog.name:="Duravent"

C_OBJECT:C1216($obPage)
ARRAY OBJECT:C1221($aObPageChildern; 0)
ARRAY OBJECT:C1221($aObCategoryChildern; 0)

$obPage:=New object:C1471
$viArraySize:=Size of array:C274($aObPageChildern)+1
INSERT IN ARRAY:C227($aObPageChildern; $viArraySize; 1)



OB SET:C1220($aObPageChildern{$viArraySize}; "name"; "Travis")

$viChildSize:=1
INSERT IN ARRAY:C227($aObCategoryChildern; $viChildSize; 1)
OB SET:C1220($aObCategoryChildern{$viChildSize}; "name"; "gas")
$viChildSize:=2
INSERT IN ARRAY:C227($aObCategoryChildern; $viChildSize; 1)
OB SET:C1220($aObCategoryChildern{$viChildSize}; "name"; "wood")
$viChildSize:=3
INSERT IN ARRAY:C227($aObCategoryChildern; $viChildSize; 1)
OB SET:C1220($aObCategoryChildern{$viChildSize}; "name"; "pellet")


OB SET ARRAY:C1227($aObPageChildern{$viArraySize}; "children"; $aObCategoryChildern)


C_OBJECT:C1216($obChildren)
$obChildren:=New object:C1471
OB SET ARRAY:C1227($obChildren; "children"; $aObCategoryChildern)


OB SET:C1220($aObPageChildern{1}; "name"; $obChildren)

ARRAY OBJECT:C1221($aObSubCatChildern; 0)
C_OBJECT:C1216($obSubCat)
$obSubCat:=New object:C1471
//OB SET($obSubCat