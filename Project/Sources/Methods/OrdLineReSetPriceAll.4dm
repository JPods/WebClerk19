//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/02/10, 08:58:09
// ----------------------------------------------------
// Method: OrdLineResetPriceAll
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($tempBase; $i)
C_REAL:C285($price)

//DscntSetAll (<>tcbManyType;[Customer]customerID;[Order]TypeSale;[Order]DateNeeded;0)//Size of array(aoLineAction))
DscntSetAll(<>tcbManyType; [Customer:2]customerID:1; [Order:3]typeSale:22; [Order:3]dateOrdered:4; 0)  //Size of array(aoLineAction))   //### jwm ### 20110727

Copy_NewEntry(->[Customer:2]; ->[Order:3]typeSale:22; ->[Customer:2]typeSale:18)
pPricePt:=[Order:3]typeSale:22

//Fill selected Lines array with all lines
vi2:=Size of array:C274(aoLineAction)
ARRAY LONGINT:C221(aRayLines; vi2)

For (vi1; 1; vi2)
	aRayLines{vi1}:=vi1
End for 

OrderLineReSetPrice  //reset line price