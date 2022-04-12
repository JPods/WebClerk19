//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/01/20, 19:07:48
// ----------------------------------------------------
// Method: ORDALearning
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($objEntity)
$objEntity:=ds:C1482.Customer.query("company = :1"; "a@").first()
// create an entity for customers and return the first record or null if selection is empty

C_OBJECT:C1216($objSelection)
$objSelection:=ds:C1482.Customer.all()
For each ($entity; $objSelection)
	do_Capitalize($entity)
	$entity.save()
End for each 

// two entities pointing to the same record
// Entities are references to specific records
C_OBJECT:C1216($objOrders1; $objOrders2)
$objOrders1:=ds:C1482.Order.getKey(101)
// get Order object where OrderNum = 1
$objOrders2:=ds:C1482.Order.getKey(101)


C_OBJECT:C1216($entCustomers; $ent2Customers)
$entCustomers:=ds:C1482.Customer.all()
ORDALearningCalls($entCustomers)
$ent2Customers:=$entCustomers.orderBy("FirstName")
C_LONGINT:C283($cntEntCustomers)
$cntEntCustomers:=$entCustomers.length

// refer to fields as attributes
C_OBJECT:C1216($entSel)
$entSel:=ds:C1482.Employee.query("manager.manager.salary > :1"; 80000)
// collection of managers whose managers make more than 80000 

// Current selection to Create Entity Selection
C_OBJECT:C1216($employees)
ALL RECORDS:C47([Employee:19])
$employees:=Create entity selection:C1512([Employee:19])
//  https://doc.4d.com/4Dv17/4D/17.4/Create-entity-selection.301-4883407.en.html
C_OBJECT:C1216($entSel)
$entSel:=API_SelectionToObject("Employees")

// Entity Selection to Use Entity Selection
// https://doc.4d.com/4Dv17/4D/17.4/USE-ENTITY-SELECTION.301-4883406.en.html
C_OBJECT:C1216($entitySel)
$entitySel:=ds:C1482.Employee.all()  //$entitySel is related to the Employee dataclass
REDUCE SELECTION:C351([Employee:19]; 0)
USE ENTITY SELECTION:C1513($entitySel)  //The current selection of the Employee table is updated



