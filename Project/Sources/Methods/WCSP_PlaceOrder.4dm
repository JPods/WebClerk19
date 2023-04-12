//%attributes = {}
// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 06/23/20, 13:37:35
// ----------------------------------------------------
// Method: WCSP_PlaceOrder
// Description
// 
//
// Parameters
// ----------------------------------------------------


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($0; $voSaveStatus)
$voSaveStatus:=New object:C1471("success"; False:C215)



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voOrder; $voOrderLine; $voItem; $voUser; $voCustomer; $voCart; $voShipToAddress; $voBillToAddress; $vodInventory)
C_LONGINT:C283($viLineCounter; $viQtySum)

// compiler required because I do not have the 72 items in this structure
C_OBJECT:C1216(voState; $voCartLine)

// ******************************************************************************************** //
// ** LOAD OR CREATE THE CART LINE RECORD ***************************************************** //
// ******************************************************************************************** //

// ASSEMBLE DATA
$voUser:=voState.user.record
$voCart:=voState.user.shoppingCarts.default
$voCustomer:=$voUser.ParentContact.ParentCustomer
$voShipToAddress:=WCSP_GetSelectedAddress("default"; "ShipTo")
$voBillToAddress:=WCSP_GetSelectedAddress("default"; "BillTo")

// CREATE ORDER RECORD

$voOrder:=ds:C1482.Order.new()

// ADD BASIC DEFAULTS

$voOrder.OrderNum:=CounterNew(->[Order:3])
$voOrder.LabelCount:=1
$voOrder.TakenBy:="Kepler"
$voOrder.ProducedBy:="Kepler"
$voOrder.AdSource:="Kepler"
$voOrder.DateNeeded:=Current date:C33+<>tcNeedDelay
$voOrder.DateShipOn:=Current date:C33+<>tcNeedDelay
$voOrder.DateOrdered:=Current date:C33
$voOrder.DateReceived:=Current date:C33
$voOrder.TimeOrdered:=Current time:C178
$voOrder.DTSync:=DateTime_DTTo
$voOrder.AutoFreight:=(<>tcAutoFrght=1)
$voOrder.FOB:=Storage:C1525.default.fob
$voOrder.siteID:=DSGetMachineSiteID

// ADD DETAILS FROM REMOTEUSER

$voOrder.OrderedBy:=$voUser.UserName

// ADD DETAILS FROM CART

$voOrder.Amount:=$voCart.Amount
$voOrder.AmountBackLog:=$voCart.Amount
$voOrder.BalanceDueEstimated:=$voCart.Amount
$voOrder.customerID:=$voCart.customerID
$voOrder.CustPONum:=$voCart.CustPONum
$voOrder.ShipInstruct:=$voCart.ShipInstruct
$voOrder.ShipPartial:=$voCart.ShipPartial
$voOrder.ShipVia:=$voCart.ShipVia

// ADD DETAILS FROM CUSTOMER

$voOrder.BillToEmail:=$voCustomer.eMail
$voOrder.BillToFAX:=$voCustomer.FAX
$voOrder.BillToPhone:=$voCustomer.Phone
$voOrder.AddressBillTo:=$voCustomer.AddrAltBillTo
$voOrder.eMail:=$voCustomer.eMail
$voOrder.eMailVerified:=$voCustomer.eMailVerified
$voOrder.FAX:=$voCustomer.FAX
$voOrder.Phone:=$voCustomer.Phone
$voOrder.Profile2:=$voCustomer.Profile1
$voOrder.SalesName:=$voCustomer.SalesName
$voOrder.TaxJuris:=$voCustomer.TaxJuris
$voOrder.Terms:=$voCustomer.Terms
$voOrder.TypeSale:=$voCustomer.TypeSale
$voOrder.UPSBillingOption:=$voCustomer.UPSBillingOption
$voOrder.UPSInsureShipping:=$voCustomer.UPSInsureShipping
$voOrder.UPSReceiverAcct:=$voCustomer.UPSReceiverAcct
$voOrder.UPSResidential:=$voCustomer.UPSResidential
$voOrder.Zone:=$voCustomer.Zone
$voOrder.TaxExemptID:=$voCustomer.TaxExemptID

// ADD DETAILS FROM BILLING CONTACT METHOD

$voOrder.BillToAddress1:=$voBillToAddress.Address1
$voOrder.BillToAddress2:=$voBillToAddress.Address2
$voOrder.BillToCity:=$voBillToAddress.City
$voOrder.BillToState:=$voBillToAddress.State
$voOrder.BillToZip:=$voBillToAddress.Zip
$voOrder.BillToCountry:=$voBillToAddress.Country
$voOrder.BillToCompany:=$voBillToAddress.Company
$voOrder.BillToAttention:=$voBillToAddress.FirstName+" "+$voBillToAddress.LastName

// ADD DETAILS FROM SHIPPING CONTACT METHOD

$voOrder.Address1:=$voShipToAddress.Address1
$voOrder.Address2:=$voShipToAddress.Address2
$voOrder.City:=$voShipToAddress.City
$voOrder.State:=$voShipToAddress.State
$voOrder.Zip:=$voShipToAddress.Zip
$voOrder.Country:=$voShipToAddress.Country
$voOrder.Company:=$voShipToAddress.Company
$voOrder.Attention:=$voShipToAddress.FirstName+" "+$voShipToAddress.LastName

// CONFIRM SHIPPING ZONE

$voOrder.Zone:=FindShipZone($voOrder.Zip; $voCustomer.Zone; $voOrder.ShipVia; $voOrder.Country; $voOrder.siteID)

$voOrder.save()

// LOOP THROUGH CART LINES AND CREATE ORDER LINES

$viLineCounter:=1

For each ($voCartLine; $voCart.ChildCartLines)
	
	// ASSEMBLE DATA
	
	$voItem:=$voCartLine.ParentItem
	
	// CREATE ORDER RECORD
	
	$voOrderLine:=ds:C1482.OrderLine.new()
	
	// ADD HARDCODED DATA
	
	$voOrderLine.LineNum:=$viLineCounter
	$voOrderLine.Sequence:=$viLineCounter
	
	// ADD DETAILS FROM ORDER
	
	$voOrderLine.OrderNum:=$voOrder.OrderNum
	$voOrderLine.DateOrdered:=$voOrder.DateOrdered
	$voOrderLine.DateReceived:=$voOrder.DateOrdered
	$voOrderLine.DateRequired:=$voOrder.DateNeeded
	$voOrderLine.DateShipOn:=$voOrder.DateNeeded
	$voOrderLine.TypeSale:=$voOrder.TypeSale
	$voOrderLine.SalesName:=$voOrder.SalesName
	
	// ADD DETAILS FROM CART LINE
	
	$voOrderLine.QtyOrdered:=$voCartLine.ItemQty
	$voOrderLine.ItemNum:=$voCartLine.ItemNum
	$voOrderLine.Comment:=$voCartLine.Comment
	
	// ADD DETAILS FROM CUSTOMER
	
	$voOrderLine.customerID:=$voCustomer.customerID
	$voOrderLine.CustReference:=$voCustomer.Company
	
	// ADD DETAILS FROM THE ITEM
	
	$voOrderLine.Profile1:=$voItem.Profile1
	$voOrderLine.Profile2:=$voItem.Profile2
	$voOrderLine.Profile3:=$voItem.Profile3
	$voOrderLine.Profile4:=$voItem.Profile4
	$voOrderLine.Class:=$voItem.Class
	$voOrderLine.TypeItem:=$voItem.typeID
	$voOrderLine.Description:=$voItem.Description
	$voOrderLine.PrintNot:=$voItem.PrintNot
	$voOrderLine.AltItem:=$voItem.MfrItemNum
	$voOrderLine.UnitofMeasure:=$voItem.UnitOfMeasure
	$voOrderLine.Location:=$voItem.Location
	$voOrderLine.LocationBin:=$voItem.LocationBin
	$voOrderLine.UnitWt:=$voItem.WeightAverage
	$voOrderLine.UnitCost:=$voItem.CostAverage
	
	$voOrderLine.DiscountedPrice:=Get_Price($voOrderLine.ItemNum; $voOrderLine.TypeSale)
	$voOrderLine.ExtendedWt:=$voOrderLine.UnitWt*$voOrderLine.QtyOrdered
	$voOrderLine.ExtendedCost:=$voOrderLine.UnitCost*$voOrderLine.QtyOrdered
	$voOrderLine.ExtendedPrice:=$voOrderLine.DiscountedPrice*$voOrderLine.QtyOrdered
	$voOrderLine.BackOrdAmount:=$voOrderLine.ExtendedPrice
	$voOrderLine.QtyBackLogged:=$voOrderLine.QtyOrdered
	
	$voOrderLine.save()
	
	// CREATE RELATED dINVENTORY RECORD
	// QQQQQQQQQQ
	$vodInventory:=ds:C1482.dInventory.new()
	
	$vodInventory.QtyOnHand:=0
	$vodInventory.QtyOnSO:=$voOrderLine.QtyOrdered
	$vodInventory.QtyOnPO:=0
	$vodInventory.QtyOnWO:=0
	$vodInventory.QtyOnAdj:=0
	$vodInventory.ItemNum:=$voOrderLine.ItemNum
	$vodInventory.UnitCost:=$voOrderLine.UnitCost
	$vodInventory.idNumProject:=$voOrder.idNumProject
	$vodInventory.DocID:=$voOrder.OrderNum
	$vodInventory.UniqueIDLine:=$voOrderLine.UniqueID
	$vodInventory.ReceiptID:=0
	$vodInventory.customerID:=$voOrder.customerID
	$vodInventory.Reason:="oi new line"
	$vodInventory.typeID:="SO"
	$vodInventory.DTCreated:=DateTime_DTTo
	$vodInventory.DateCreated:=Current date:C33
	$vodInventory.TimeCreated:=Current time:C178
	$vodInventory.Note:=""
	$vodInventory.TakeAction:=1
	$vodInventory.siteID:=$voOrder.siteID
	$vodInventory.UnitPrice:=DiscountApply($voOrderLine.UnitPrice; $voOrderLine.Discount; <>tcDecimalUP)
	$vodInventory.ChangedBy:=Current user:C182
	$vodInventory.Division:=""
	$vodInventory.TableNum:=Table:C252(->[Order:3])
	
	$vodInventory.save()
	
	// UPDATE LINE NUM COUNTER
	
	$viLineCounter:=$viLineCounter+1
	
End for each 

// ADD SUMMED INFO TO ORDER, CALCULATED FROM NOW COMPLETE ORDER LINES

$voOrder.TotalCost:=Round:C94($voOrder.ChildOrderLines.sum("ExtendedCost"); <>tcDecimalTt)
If ($voOrder.Amount>0)
	$voOrder.GrossMargin:=Trunc:C95(($voOrder.Amount-$voOrder.TotalCost)/$voOrder.Amount*100; 1)
End if 
$voOrder.WeightEstimate:=$voOrder.ChildOrderLines.sum("ExtendedWt")
$voOrder.Total:=Round:C94($voOrder.Amount+$voOrder.SalesTax+$voOrder.TaxOnCost+$voOrder.ShipTotal; <>tcDecimalTt)
$voOrder.CountItems:=$voOrder.ChildOrderLines.sum("QtyOrdered")
$voOrder.CountItemsBL:=$voOrder.CountItems

$voOrder.save()

// UPDATE RELATED CUSTOMER

$voCustomer.LastSaleDate:=Current date:C33
$voCustomer.LastSaleAmount:=$voOrder.Amount
$voCustomer.BalanceOpenOrders:=Round:C94($voCustomer.BalanceOpenOrders+$voOrder.Amount; <>tcDecimalTt)
$voCustomer.DTSync:=DateTime_DTTo
$voCustomer.save()


// ******************************************************************************************** //
// ** RETURN THE VALUE ************************************************************************ //
// ******************************************************************************************** //

TallyInventory

