//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/05/10, 15:02:35
// ----------------------------------------------------
// Method: Disc_AddItems
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k)
C_TEXT:C284($curItemNum)
C_TEXT:C284($curItemDesc)
$k:=Size of array:C274(<>aItemLines)
If ($k>0)
	ARRAY LONGINT:C221($aSdSelectLn; 0)
	For ($i; 1; $k)
		GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{$i}})
		$w:=Find in array:C230(aSdItemNum; [Item:4]itemNum:1)
		If ($w=-1)
			$existing:=Size of array:C274(aSdItemNum)+1
			Disc_ArraysDo(-3; $existing; 1)
			INSERT IN ARRAY:C227($aSdSelectLn; 1; 1)
			$aSdSelectLn{1}:=$existing  //set selection
			//
			aSdItemNum{$existing}:=[Item:4]itemNum:1
			aSdDescript{$existing}:=[Item:4]description:7
			aSdDiscPC{$existing}:=[SpecialDiscount:44]PerCentDiscount:6
			aSdCost{$existing}:=[Item:4]costAverage:13
			Case of 
				: ([SpecialDiscount:44]PriceBase:8=2)
					aSdBase{$existing}:=[Item:4]priceB:3
					aSdTypeSalesBase{$existing}:=<>tcPriceLvlB
				: ([SpecialDiscount:44]PriceBase:8=3)
					aSdBase{$existing}:=[Item:4]priceC:4
					aSdTypeSalesBase{$existing}:=<>tcPriceLvlC
				: ([SpecialDiscount:44]PriceBase:8=4)
					aSdBase{$existing}:=[Item:4]priceD:5
					aSdTypeSalesBase{$existing}:=<>tcPriceLvlD
				: ([SpecialDiscount:44]PriceBase:8=5)
					aSdBase{$existing}:=[Item:4]priceMSR:109
					aSdTypeSalesBase{$existing}:="MSR"
				Else 
					aSdBase{$existing}:=[Item:4]priceA:2
					aSdTypeSalesBase{$existing}:=<>tcPriceLvlA
			End case 
			
			
			aSdDisPrice{$existing}:=DiscountApply(aSdBase{$existing}; aSdDiscPC{$existing}; <>tcDecimalUP)
			aSdDiscPC{$existing}:=Round:C94(1-(aSdDisPrice{$existing}/aSdBase{$existing}); 8)*100
			vi1:=$existing
			MarginCalc(->aSdDisPrice{vi1}; ->aSdCost{vi1}; ->pGrossMar; ->aSdMargin{vi1})
		End if 
	End for 
	COPY ARRAY:C226($aSdSelectLn; aSdSelectLn)
End if 