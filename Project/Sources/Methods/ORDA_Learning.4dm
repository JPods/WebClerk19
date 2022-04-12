//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/01/20, 22:01:26
// ----------------------------------------------------
// Method: ORDA_Learning
// Description
// 
//
// Parameters
// ----------------------------------------------------
// number of contacts first company with "S" Bill Tos

TRACE:C157
//   https://www.youtube.com/watch?v=xm8eK-P0aaY
// https://doc.4d.com/4Dv17/4D/17.4/entitySelectionlength.303-4883394.en.html

C_OBJECT:C1216($n; $params; $sel)
$n:=ds:C1482.Invoice.query("company = 'S@'").first().BillToContact.length

// All the same

$sel:=ds:C1482.Aircraft.query("(NbOfSeats >= 400) AND ((Manufacturer = 'Airbus@') OR (Manufacturer = 'Boeing'))")

// or
$QueryFormula:="(NbOfSeats >= 400) AND ((Manufacturer = 'Airbus@') OR (Manufacturer = 'Boeing'))"
$sel:=ds:C1482.Carrier.query($QueryFormula)

//or
$nbMin:=400
$sel:=ds:C1482.Carrier.query("(NbOfSeats >= :1) AND ((Manufacturer = 'Airbus@') OR (Manufacturer = 'Boeing'))"; $nbMin)

// or 
$nbMin:=400
$sel:=ds:C1482.Carrier.query("(NbOfSeats >= :1) AND (Manufacturer in :2)"; $nbMin; New collection:C1472("Airbus@"; "Boeing"))

// or
$params:=New object:C1471
$params.parameters:=New collection:C1472(400; "Airbus@"; "Boeing")
$sel:=ds:C1482.Carrier.query("(NbOfSeats >= :1) AND ((Manufacturer = :2) OR (Manufacturer = :3))"; $params)

// relations between tables
C_TEXT:C284($search)
$search:="@Chicago@"
QUERY:C277([Customer:2]; [Order:3]city:18=$search; *)
QUERY:C277([Customer:2];  | [Invoice:26]city:10=$search; *)
QUERY:C277([Customer:2];  | [Proposal:42]city:14=$search)

$search:="@Chicago@"
$sel:=ds:C1482.Customer.query("ordersRelation.CIty:=1 OR invoicesRelation.CIty:=1 OR proposalRelation.City=:1"; $search)

//  2:35 there needs to be some checking covers the debugger breaking down 
C_TEXT:C284($collegues2)
$collegues2:=ds:C1482.Employee.get(122).manager.manager.directReports.directReports.lastname.join(", ")
// text of last names separated by ", "
// ds.Employee.get(122) is an entity
// ds.Employee.get(122).manager is an entity (many to one)
// ds.Employee.get(122).manager.manager is an entity (many to one)
// $collegues2:=ds.Employee.get(122).manager.manager.directReports is an entity selection (one to many)
// $collegues2:=ds.Employee.get(122).manager.manager.directReports.directReports is an entity selection (one to many)
// $collegues2:=ds.Employee.get(122).manager.manager.directReports.directReports.lastname is a collection of last names
// .join(", ") combines them in a text file delimited by comman space

// 2:50 Export Structure in XML change and reimport them after naming the relations
// https://doc.4d.com/4Dv17/4D/17.4/Exporting-and-importing-structure-definitions.300-4880619.en.html
C_TEXT:C284($vTStruc)
EXPORT STRUCTURE:C1311($vTStruc)
TEXT TO DOCUMENT:C1237("myStructure.xml"; $vTStruc)

// failed  page 18
C_OBJECT:C1216($obItems)
C_OBJECT:C1216($obFieldList)
$obItems:=ds:C1482.Item.all()[0]
$vtFieldList:=$obItems.keys()  // failed

C_TEXT:C284($vtFieldList)
$obItems:=ds:C1482.Item.all()[0]
$vtFieldList:=$obItems.keys()  // failed





