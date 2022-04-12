//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/27/11, 21:27:39
// ----------------------------------------------------
// Method: OrdSetPrice
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(strCurrency)  // ### bj ### 20200524_1203  SimplfyQQQ
C_POINTER:C301($1; $2; $4)
C_REAL:C285($3; $0; vSpclDscn)
C_LONGINT:C283(vCommable; <>viMatrixPricing)
$1->:=0
$2->:=0
$4->:=0
//$5->:=""  must be commented to allow standard taxes to process
If ((vUseBase<2) | (vUseBase>6))
	vUseBase:=2
End if 
//// Modified by: williamjames (120226)

//If (pPartNum#[Item]ItemNum)
//READ ONLY([Item])
//QUERY([Item];[Item]ItemNum=pPartNum)
//End if 
//must have the [Item] record
If (Record number:C243([Item:4])<0)
	If (allowAlerts_boo)
		ALERT:C41("No Item record in selection to set price.")
	End if 
Else 
	Case of 
		: ([Order:3]typeSale:22="Matrix@")  //This is a very special publishing activity depending on the Type of  Customer how the product is used.
			//normal PriceMatrix is used below.
			QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]howUsed:2=[Order:3]typeSale:22; *)
			QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]itemNum:11=[Item:4]itemNum:1; *)
			QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMin:4<=$3; *)  //finding a record where Min is less than qty
			QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMax:5>=$3)  //finding a record where Max is greater than qty
			If (Records in selection:C76([PriceMatrix:105])=1)
				$1->:=[PriceMatrix:105]price:6
				$2->:=0
				$4->:=[PriceMatrix:105]commissionFactor:7
				$5->:=[PriceMatrix:105]taxID:8
			Else 
				If (allowAlerts_boo)
					ALERT:C41("Warning: "+String:C10(Records in selection:C76([PriceMatrix:105]))+" PriceMatrix records meet parameters"+"\r"+"[Order]TypeSale: "+[Order:3]typeSale:22)  //+"\r"+"[Customer]TypeSale: "+[Customer]TypeSale
				End if 
				$1->:=[Item:4]priceA:2
				$2->:=OrdSetDiscount($3)
				$4->:=[Item:4]commissionA:29
			End if 
		: (([Order:3]typeSale:22="LastPrice") & (ptCurTable=(->[Order:3])) & (allowAlerts_boo))
			List_InvLines(eItemOrd; ->aOItemNum{aoLineAction})  //Last 5 buys of this item
			If (Size of array:C274(aLsItemNum)>0)
				aOQtyOrder{aoLineAction}:=aLsQtyOH{1}
				$1->:=aLsQtySO{1}
				$2->:=aLsQtyPO{1}
				$4->:=[Item:4]commissionA:29
				//$5->:=[Item]taxID//[PriceMatrix]taxID
				
			Else 
				$1->:=[Item:4]priceA:2
				$2->:=OrdSetDiscount($3)
				$4->:=[Item:4]commissionA:29
			End if 
		: ([Item:4]factor:44#0)
			$1->:=Round:C94([Item:4]costLastInShip:47*(1+([Item:4]factor:44/100)); <>tcDecimalUC)
			$2->:=0
			$4->:=Field:C253(Table:C252(->[Item:4]); (vUseBase+27))->
		: (<>tcbManyType)
			Case of 
				: (<>viMatrixPricing>0)  // Modified by: williamjames (110327)
					
					// Modified by: William James (2014-08-13T00:00:00 Subrecord eliminated)
					// FixThis: change Method so there is only one pricing procedure ::  Http_PostOrd2 and OrdSetPrice should have one procedure
					$w:=Find in array:C230(aDsctItem; [Item:4]itemNum:1)
					If ($w>0)
						$1->:=aBasePrice{$w}
						$2->:=aDscnPC{$w}
						$4->:=vCommable
					Else 
						QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]typeSale:3=[Order:3]typeSale:22; *)
						QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]itemNum:11=[Item:4]itemNum:1; *)
						QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMin:4<=$3; *)  //finding a record where Min is less than qty
						QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMax:5>=$3)  //finding a record where Max is greater than qty
						
						If (Records in selection:C76([PriceMatrix:105])>0)
							If (allowAlerts_boo)
								ALERT:C41("Multiple PriceMatrix Records.")
								DB_ShowCurrentSelection(->[PriceMatrix:105])
							End if 
							REDUCE SELECTION:C351([PriceMatrix:105]; 1)
							If (Records in selection:C76([PriceMatrix:105])=1)
								$1->:=[PriceMatrix:105]price:6
								$2->:=0
								$4->:=[PriceMatrix:105]commissionFactor:7
								If (Count parameters:C259>4)  //Dow Jones feature
									$5->:=[PriceMatrix:105]taxID:8  //various uses of published materials have different tax codes
								End if 
							End if 
						Else 
							$1->:=Field:C253(Table:C252(->[Item:4]); vUseBase)->
							$2->:=OrdSetDiscount($3)
							$4->:=Field:C253(Table:C252(->[Item:4]); (vUseBase+27))->
						End if 
					End if 
					
				: (vSpclDscn#0)  //universal discount
					$1->:=Field:C253(Table:C252(->[Item:4]); vUseBase)->
					$2->:=vSpclDscn
					$4->:=vCommable
				Else 
					$w:=Find in array:C230(aDsctItem; [Item:4]itemNum:1)
					If ($w>0)
						$1->:=aBasePrice{$w}
						$2->:=aDscnPC{$w}
						$4->:=vCommable
					Else 
						$1->:=Field:C253(Table:C252(->[Item:4]); vUseBase)->
						$2->:=OrdSetDiscount($3)
						$4->:=Field:C253(Table:C252(->[Item:4]); (vUseBase+27))->
					End if 
			End case 
		Else 
			$1->:=Field:C253(Table:C252(->[Item:4]); vUseBase)->
			$2->:=OrdSetDiscount($3)
			$4->:=Field:C253(Table:C252(->[Item:4]); (vUseBase+27))->
	End case 
End if 
UNLOAD RECORD:C212([PriceMatrix:105])