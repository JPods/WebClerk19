//%attributes = {}

// Modified by: Bill James (2022-07-16T05:00:00Z)
// Method: 00_Learning_KirkCollections
// Description 
// Parameters
// ----------------------------------------------------

TRACE:C157  // study SideORDA to get fundamentals.

var $rec : Object
var $id : Text
$rec:=ds:C1482.DInventory.all().first()
$rec.save(dk auto merge:K85:24)  // to save changes regardless of other changes.
$id:=$rec.id

$rec:=New object:C1471
$rec:=ds:C1482.DInventory.get($id)

// $status:=$rec.lock()  // use as is in the current selection
$status:=$rec.lock(dk reload if stamp changed:K85:15)  // reload if the time stamp changed
//  --  processing  --
Case of 
	: ($status.success)
		ConsoleLog("You have locked "+$rec.$id)
	: ($status.status=dk status entity does not exist anymore:K85:23)
		ConsoleLog($status.statusText)
End case 

// --------------------------------------------------------
//  entity.unlock () -> Result 
// --------------------------------------------------------


$status:=$rec.unlock()

If ($status.success)
	ConsoleLog("The entity is now unlocked")
End if 


// camelCase for varible and non_field attributes
// _t for text, _i for integer _b for boolean _o for object, _c for collection


$params:=New object:C1471
$params.parameters:=New collection:C1472()
$entitySelection:=ds:C1482.Customer.query(\
"(nameFirst = :1 or nameFirst = :2) and (nameLast = :3 or nameLast = :4)"; \
"D@"; "R@"; "S@"; "K@"; \
New object:C1471("queryPlan"; True:C214; "queryPath"; True:C214))

//you can then get these properties in the resulting entity selection
C_OBJECT:C1216($queryPlan; $queryPath)
$queryPlan:=$entitySelection.queryPlan
$queryPath:=$entitySelection.queryPath

$entitySelection:=New object:C1471

$params:=New object:C1471
$params.parameters:=New collection:C1472("D@"; "R@"; "S@"; "K@"; New object:C1471("queryPlan"; True:C214; "queryPath"; True:C214))
$entitySelection:=ds:C1482.Customer.query("(nameFirst = :1 or nameFirst = :2) and (nameLast = :3 or nameLast = :4)"; $params)

//you can then get these properties in the resulting entity selection
C_OBJECT:C1216($queryPlan; $queryPath)
$queryPlan:=$entitySelection.queryPlan
$queryPath:=$entitySelection.queryPath