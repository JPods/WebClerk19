//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/23/19, 22:08:06
// ----------------------------------------------------
// Method: RP_OrderLinesfromPOLines
// Description
// 
//
// Parameters
// ----------------------------------------------------


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/20/19, 13:00:05
// ----------------------------------------------------
// Method: jsonArrayToSelection
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($error)
C_TEXT:C284($1; $tableName)
C_POINTER:C301($2; $ptaData)
$ptaData:=$2

$tableName:=$1
C_OBJECT:C1216($obData)
C_LONGINT:C283($tableNum; $incRay; $cntRay; $fia)
$cntRay:=Size of array:C274($ptaData->)

C_TEXT:C284($ItemNum; $Description; $UnitOfMeasure; $itemNumVendor)
C_REAL:C285($QtyOrdered; $UnitCost; $Discount; $ExtendedCost)
C_REAL:C285($CostExtended; $CostUnit; $CostDiscount)


For ($incRay; 1; $cntRay)
	$obData:=$ptaData->{$incRay}
	
	// should use mapping, but hacking this for convience
	$ItemNum:=OB Get:C1224($obData; "ItemNum")
	
	$itemNumVendor:=OB Get:C1224($obData; "AltItemNum")
	
	
	$Description:=OB Get:C1224($obData; "Description")
	$UnitOfMeasure:=OB Get:C1224($obData; "UnitOfMeasure")
	$QtyOrdered:=OB Get:C1224($obData; "QtyOrdered")
	$CostUnit:=OB Get:C1224($obData; "UnitCost")
	// convert to vendor unitprice on SO
	$Discount:=OB Get:C1224($obData; "Discount")
	$CostDiscount:=OB Get:C1224($obData; "DiscountedCost")
	
	$CostExtended:=OB Get:C1224($obData; "ExtendedCost")
	If ($itemNumVendor="")
		REDUCE SELECTION:C351([Item:4]; 0)
	Else 
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNumVendor)
	End if 
	If (Records in selection:C76([Item:4])=0)
		If (<>viDebugMode>410)
			ConsoleMessage("No Item for: "+$itemNumVendor)
		End if 
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$ItemNum)
		If (Records in selection:C76([Item:4])=0)
			If (<>viDebugMode>410)
				ConsoleMessage("No Item for 2nd attempt: "+$ItemNum)
			End if 
		End if 
	End if 
	If (Records in selection:C76([Item:4])=1)
		pPartNum:=[Item:4]itemNum:1
		pDescript:=[Item:4]description:7
		pUnitCost:=[Item:4]costAverage:13
	Else 
		
		If (<>viDebugMode>410)
			ConsoleMessage($vtCommentAdd)
		End if 
		If ($itemNumVendor="")
			pPartNum:=$itemNum
		Else 
			pPartNum:=$itemNumVendor
		End if 
		pDescript:=$Description
		pUnitPrice:=$CostDiscount
	End if 
	
	
	
	
	pQtyShip:=$QtyOrdered
	// (Size of array(aPOLineAction)+1)
	
	// converting customer POLines data into vendor SalesOrder data
	OrdLnAdd($incRay; 1; False:C215)
	
	aOAltItem{$incRay}:=$ItemNum
	pQtyOrd:=$QtyOrdered
	aOQtyOrder{$incRay}:=$QtyOrdered
	
	
	If (Records in selection:C76([Item:4])=0)
		$vtCommentAdd:=String:C10($incRay)+": No ItemsNum "+$itemNumVendor+" or "+$itemNum+" using Customer data: Description"+$Description+": "+String:C10($incRay)+": Inbound: "+String:C10($CostDiscount)
		pUnitPrice:=$CostDiscount
		aOUnitPrice{$incRay}:=$CostDiscount
		aODiscnt{$incRay}:=0
		aoLnComment{$incRay}:=$vtCommentAdd+"\r"+aoLnComment{$incRay}
		[Order:3]commentProcess:12:=[Order:3]commentProcess:12+"\r"+String:C10($incRay)+$vtCommentAdd
		If (<>viDebugMode>410)
			ConsoleMessage($vtCommentAdd)
		End if 
	Else 
		$vtCommentAdd:=""
		If ($CostDiscount#aOUnitPrice{$incRay})
			aoProfile2{$incRay}:="MisMatchCost"
			C_TEXT:C284($vtCommentAdd)
			$vtCommentAdd:="MisMatchCost: "+$itemNum+": "+String:C10($incRay)+": Inbound: "+String:C10($CostDiscount)+": internal: "+String:C10(aOUnitPrice{$incRay})
			If (<>viDebugMode>410)
				ConsoleMessage($vtCommentAdd)
			End if 
			[Order:3]commentProcess:12:=[Order:3]commentProcess:12+"\r"+String:C10($incRay)+$vtCommentAdd
			aoLnComment{$incRay}:=$vtCommentAdd+"\r"+aoLnComment{$incRay}
		End if 
		
		If ($Discount#aODiscnt{$incRay})
			aoProfile3{$incRay}:="MisMatchDiscount"
			$vtCommentAdd:="MisMatchDiscount: "+$itemNum+": Inbound: "+String:C10($Discount)+": internal: "+String:C10(aODiscnt{$incRay})
			If (<>viDebugMode>410)
				ConsoleMessage($vtCommentAdd)
			End if 
			[Order:3]commentProcess:12:=[Order:3]commentProcess:12+"\r"+String:C10($incRay)+": "+$vtCommentAdd
			aoLnComment{$incRay}:=$vtCommentAdd+"\r"+aoLnComment{$incRay}
		End if 
	End if 
	
	aoLineAction:=$incRay
	OrdLnExtend($incRay)
	
End for 


