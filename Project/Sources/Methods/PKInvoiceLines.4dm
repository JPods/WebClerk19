//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-15T00:00:00, 11:59:08
// ----------------------------------------------------
// Method: PKInvoiceLines
// Description
// Modified: 08/15/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


//
$dtNow:=DateTime_DTTo
C_LONGINT:C283($1; $ordLnUnique; $doLine; $findOrderLine; $dtNow)
C_REAL:C285($0)
C_BOOLEAN:C305($doEnd)
C_TEXT:C284($2)
$doLine:=0
$doEnd:=False:C215
$ordLnUnique:=$1
$0:=0
Repeat 
	
	//  aPKOrderLineID size is zero when there should be a
	
	$findOrderLine:=Find in array:C230(aPKOrderLineID; $ordLnUnique)  //);$incElement)
	If ($findOrderLine>0)
		//QUERY([LoadItem];[LoadItem]UniqueID=aPKLoadItemID{$findOrderLine})
		GOTO RECORD:C242([LoadItem:87]; aPKLoadItemRecNum{$findOrderLine})
		DELETE FROM ARRAY:C228(aPKOrderLineID; $findOrderLine; 1)
		DELETE FROM ARRAY:C228(aPKLoadItemID; $findOrderLine; 1)
		DELETE FROM ARRAY:C228(aPKLoadItemRecNum; $findOrderLine; 1)
		If ([LoadTag:88]idNum:1#[LoadItem:87]idNumLoadTag:8)
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=[LoadItem:87]idNumLoadTag:8)
		End if 
		If ([LoadTag:88]idNumInvoice:19#[Invoice:26]idNum:2)
			[LoadTag:88]idNumInvoice:19:=[Invoice:26]idNum:2
			[LoadTag:88]status:6:="Shipped"
			//ShippingCost (->[Order]ShipVia;->[Order]Zone;->[LoadTag]WeightExtended;->[LoadTag]CostEstimate;->[LoadTag]CostOther;->[LoadTag]CostInsurance;->[Order]Terms;->[LoadTag]Value;->vR1)
			PKShippingCost  //### jwm ### 20110309 custom shipping Cost Is Invoice already selected?
			
			//[LoadTag]CostEstimate:=
			[LoadTag:88]customerID:23:=[Invoice:26]customerID:3
			[LoadTag:88]customerPO:37:=[Invoice:26]customerPO:29
			[LoadTag:88]dtShipOn:10:=$dtNow
			SAVE RECORD:C53([LoadTag:88])
			If (False:C215)
				CREATE RECORD:C68([GenericParent:89])
				
				[GenericParent:89]name:2:="Ship"
				[GenericParent:89]purpose:3:="LoadTag"
				[GenericParent:89]lI01:5:=[LoadItem:87]idNumLoadTag:8
				[GenericParent:89]lI02:6:=[LoadTag:88]idNumInvoice:19
				[GenericParent:89]lI03:7:=DateTime_DTTo
				SAVE RECORD:C53([GenericParent:89])
			End if 
		End if 
		[LoadItem:87]invoiceNum:14:=[Invoice:26]idNum:2
		SAVE RECORD:C53([LoadItem:87])
		If (False:C215)
			CREATE RECORD:C68([GenericChild1:90])
			
			[GenericChild1:90]ideParent:2:=[GenericParent:89]idNum:1
			[GenericChild1:90]lI01:6:=[LoadItem:87]idNum:16
			[GenericChild1:90]name:3:="Ship"
			[GenericChild1:90]purpose:4:="LoadItems"
			[GenericChild1:90]lI02:7:=[Invoice:26]idNum:2
			SAVE RECORD:C53([GenericChild1:90])
		End if 
		$0:=$0+[LoadItem:87]quantity:7
		If ([Item:4]itemNum:1#[LoadItem:87]itemNum:3)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[LoadItem:87]itemNum:3)
		End if 
	Else 
		$doEnd:=True:C214
	End if 
Until ($doEnd)
UNLOAD RECORD:C212([LoadItem:87])
UNLOAD RECORD:C212([LoadTag:88])
