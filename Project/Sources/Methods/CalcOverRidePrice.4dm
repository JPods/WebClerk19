//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/26/06, 03:55:41
// ----------------------------------------------------
// Method: CalcOverRidePrice
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
Case of 
	: ($1=(->[Order:3]))
		C_LONGINT:C283($findItem)
		$findItem:=Find in array:C230(aOItemNum; "OverRide")
		If ($findItem<1)
			QUERY:C277([Item:4]; [Item:4]itemNum:1="OverRide")
			If (Records in selection:C76([Item:4])=0)
				ItemForceCreate("OverRide"; "OverRide")
			End if 
			pPartNum:=[Item:4]itemNum:1
			pDescript:=[Item:4]description:7
			pUnitCost:=[Item:4]costAverage:13
			$findItem:=Size of array:C274(aoLineAction)+1
			OrdLnAdd($findItem; 1; False:C215)
		End if 
		$deviationOverRide:=[Order:3]amountForceValue:112-[Order:3]amount:24  //-aOUnitPrice{$findItem}
		aOUnitPrice{$findItem}:=$deviationOverRide+aOUnitPrice{$findItem}
		OrdLnExtend($findItem)
		[Order:3]amount:24:=[Order:3]amountForceValue:112
		//vrAmountOverRide:=0
		If (eOrdList>0)
			//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
		End if 
	: ($1=(->[Invoice:26]))
		C_LONGINT:C283($findItem)
		$findItem:=Find in array:C230(aiItemNum; "OverRide")
		If ($findItem<1)
			QUERY:C277([Item:4]; [Item:4]itemNum:1="OverRide")
			If (Records in selection:C76([Item:4])=0)
				ItemForceCreate("OverRide"; "OverRide")
			End if 
			pPartNum:=[Item:4]itemNum:1
			pDescript:=[Item:4]description:7
			pUnitCost:=[Item:4]costAverage:13
			$findItem:=Size of array:C274(aiLineAction)+1
			IvcLnAdd($findItem; 1; False:C215)
		End if 
		$deviationOverRide:=[Invoice:26]amountForceValue:90-[Invoice:26]amount:14  //-aOUnitPrice{$findItem}
		aiUnitPrice{$findItem}:=$deviationOverRide+aiUnitPrice{$findItem}
		IvcLnExtend($findItem)
		[Invoice:26]amount:14:=[Invoice:26]amountForceValue:90
		//vrAmountOverRide:=0
		If (eIvcList>0)
			//  --  CHOPPED  AL_UpdateArrays(eIvcList; -2)
		End if 
	: ($1=(->[Proposal:42]))
		C_LONGINT:C283($findItem)
		$findItem:=Find in array:C230(aPItemNum; "OverRide")
		If ($findItem<1)
			QUERY:C277([Item:4]; [Item:4]itemNum:1="OverRide")
			If (Records in selection:C76([Item:4])=0)
				ItemForceCreate("OverRide"; "OverRide")
			End if 
			pPartNum:=[Item:4]itemNum:1
			pDescript:=[Item:4]description:7
			pUnitCost:=[Item:4]costAverage:13
			$findItem:=Size of array:C274(aPLineAction)+1
			PpLnAdd($findItem; 1; False:C215)
		End if 
		$deviationOverRide:=[Proposal:42]amountForceValue:81-[Proposal:42]amount:26  //-aOUnitPrice{$findItem}
		aPUnitPrice{$findItem}:=$deviationOverRide+aPUnitPrice{$findItem}
		PpLnExtend($findItem)
		[Proposal:42]amount:26:=[Proposal:42]amountForceValue:81
		If (ePropList>0)
			//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
		End if 
End case 