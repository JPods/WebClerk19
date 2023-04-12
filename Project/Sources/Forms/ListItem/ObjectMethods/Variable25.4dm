If (False:C215)
	//Date: 03/13/02
	//Who: Dan Bentson, Arkware
	//Description: Added correct rounding
	
	//Date: 03/12/02
	//Who: Dan Bentson, Arkware
	//Description:Using discount base price for price
	
	//Date: 02/26/02
	//Who: Dan Bentson, Arkware
	//Description: replaced $2 with vUseBase
	//   restore row highlighted 3/1/02
	VERSION_960
End if 
//
vUseBase:=SetPricePoint(<>aTypeSale{<>aTypeSale})

C_TEXT:C284($temp)
C_LONGINT:C283($tempBase; $i; $k; $w)
If (<>aTypeSale=0)
	<>aTypeSale:=1
Else 
	QQPricePointReSet
End if 