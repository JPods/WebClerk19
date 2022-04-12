//%attributes = {}
TRACE:C157


C_OBJECT:C1216($obSel; $obRec; $obClass; $obStore)
$obStore:=ds:C1482
$obClass:=ds:C1482.Item
C_TEXT:C284($vtProperty)
C_OBJECT:C1216($obProperty)
For each ($vtProperty; $obClass)
	$obProperty:=$obClass[$vtProperty]
End for each 

$obSelection:=ds:C1482.Item.all()
$obRecord:=$obSelection.first()
$obClass:=$obRecord.getDataClass()
vi2:=$obClass.getInfo().tableNumber
$obStore:=$obClass.getDataStore()
vi2:=$obRecord.getDataClass().action.fieldNumber
vi2:=$obRecord.getDataClass().getDataStore().Item.action.fieldNumber
// vi2:=ds.Item.action.fieldNumber   // does not work



C_OBJECT:C1216($obSelOrd; $obRecOrd)
C_OBJECT:C1216($obSel; $obRec)
$obSel:=ds:C1482.Customer.query("eval(This.ChildOrders.length=0)")
$obSelOrd:=ds:C1482.Order.query("eval(This.ChildOrders))")
$obSel:=ds:C1482.Customer.query("eval(This.ChildOrders.length<5)")
$obSelOrd:=ds:C1482.Order.query("eval(This.ChildOrders))")

$obSel:=ds:C1482.Customer.query("eval(This.ChildOrders.length>0) AND eval(This.ChildOrders.length<2)")
$obSel:=ds:C1482.Customer.query("eval(This.ChildOrders.length>5) AND eval(This.ChildOrders.length<10)")
$obSelOrd:=ds:C1482.Order.query("eval(This.ChildOrderLines))")
$obSel:=ds:C1482.Customer.query("eval(This.ChildOrders.length>5) AND eval(This.ChildOrders.length<10)")
$obSel:=ds:C1482.Customer.query("eval(This.ChildOrders.length>5)")
$obSel:=ds:C1482.Customer.query("eval(This.ChildOrders.length>10)")
$obSelOrd:=ds:C1482.Order.query("eval(This.ChildOrderLines))")




C_TEXT:C284($pk)
C_OBJECT:C1216($obInfo)
C_OBJECT:C1216($obFields)
C_OBJECT:C1216($dataStore; $obEmpty; $obGet)
C_LONGINT:C283($viTableNum; $vifieldNumber)
//  https://doc.4d.com/4Dv18R5/4D/18-R5/dataClassattributeName.303-5128215.en.html

$obEmpty:=ds:C1482.Employee.getDataStore()

C_TEXT:C284($vtUUIDKey)
$vtUUIDKey:="0E0DCFA31ABA40AFA8E2FE803B7F6567"
$obRec:=ds:C1482.Employee.get($vtUUIDKey)

$obInfo:=ds:C1482.Employee.getInfo()
$viTableNum:=ds:C1482.Employee.getInfo().tableNumber
$obInfo:=ds:C1482.Employee.getInfo()
$obRec:=ds:C1482.Employee.all().first()
// get the definition of the attributes of the class, field names
$obFields:=$obSel.getDataClass()
$vifieldNumber:=$obFields.action.fieldNumber

$vtUUIDKey:=""
$pk:=ds:C1482.Employee.getInfo().primaryKey
$vtUUIDKey:=""
$vtUUIDKey:=$obRec[$pk]  // If needed the attribute matching the primary key is accessible
$vtUUIDKey:=""
$vtUUIDKey:=$obRec.id  // If needed the attribute matching the primary key is accessible


// get the DataStore that the DataClass is an class of
$dataStore:=$obSel.getDataClass().getDataStore()






// Search Duplicates in a dataclass
C_OBJECT:C1216($obSel; $obDups; $obDup2)
$obSel:=ds:C1482.Customer.all().first()  //get an entity
$obDups:=Duplicates_Find($obSel; "Customer"; "Phone")
$obDup2:=OB Copy:C1225($obSel)
