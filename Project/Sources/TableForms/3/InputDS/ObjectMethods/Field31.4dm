// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/10/11, 18:56:37
// ----------------------------------------------------
// Method: Object Method: TypeSale
// Description
// 
//
// Parameters
// ----------------------------------------------------

// zzzqqq PopUpWildCard(->[Order:3]typeSale:22; -><>aTypeSale; ->[PopUp:23])
DscntSetAll(<>tcbManyType; [Customer:2]customerID:1; [Order:3]typeSale:22; [Order:3]dateOrdered:4; 0)


// ### bj ### 20191004_1518  Test what this does make sure it does not affect existing orders
// ### jwm ### 20190724_0802 update eItemOrd
QUERY WITH ARRAY:C644([Item:4]itemNum:1; aLsItemNum)  //                 get items in area list
viRecordsInSelection:=Records in selection:C76([Item:4])  //         set the number of records
List_FillOpts(viRecordsInSelection; vUseBase; $typeSaleSel)  //  fill area list

//Size of array(aoLineAction))
//June 23, 1993    3:26 PM
Copy_NewEntry(->[Customer:2]; ->[Order:3]typeSale:22; ->[Customer:2]typeSale:18)
// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; Self:C308)
pPricePt:=[Order:3]typeSale:22
CONFIRM:C162("Update selected lines TypeSale and Item Pricing")
If (OK=1)
	If ([Order:3]timesPrinted:39#0)
		CONFIRM:C162("Account for existing printed copies of this transaction.")
		If (OK=1)
			OrderLineReSetPrice
		End if 
	Else 
		OrderLineReSetPrice
	End if 
End if 