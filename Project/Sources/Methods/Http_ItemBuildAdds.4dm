//%attributes = {"publishedWeb":true}
//Method: Http_ItemBuildAdds

C_TEXT:C284($itemNum)
C_LONGINT:C283($linkType)
C_TEXT:C284($1; $2)
C_REAL:C285($3; $pQtyOrd; $pMasterQtyOrd)
C_LONGINT:C283($4)
C_LONGINT:C283($p; $i; $k)
$itemNum:=$1
$p:=Position:C15("#"; $2)
If ($p=0)
	$xRItem:=$2
	$linkType:=0
Else 
	$xRItem:=Substring:C12($2; 1; $p-1)
	$linkType:=Num:C11(Substring:C12($2; $p+1))
End if 
$pMasterQtyOrd:=$3
If (($1=$xRItem) & ($linkType=0))  //force a look to alt discounts
	If ($4>0)
		[Item:4]qtySaleDefault:15:=$pQtyOrd  //do not save item
		//
		QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=$xRItem)
		$k:=Records in selection:C76([ItemXRef:22])
		ARRAY TEXT:C222($aXItemNums; 0)
		ARRAY LONGINT:C221($aXRecNum; 0)
		ARRAY LONGINT:C221($aXLinkType; 0)
		If ($k>0)
			SELECTION TO ARRAY:C260([ItemXRef:22]ItemNumXRef:2; $aXItemNums; [ItemXRef:22]XRefLinked:17; $aXLinkType; [ItemXRef:22]; $aXRecNum)
			
			For ($i; 1; $k)
				If ($aXLinkType{$i}=$linkType)
					viOrdLnCnt:=viOrdLnCnt+1
					QUERY:C277([Item:4]; [Item:4]itemNum:1=$aXItemNums{$i}; *)
					QUERY:C277([Item:4];  & [Item:4]publish:60>0)  //ignors user level
					If (Records in selection:C76([Item:4])=1)
						GOTO RECORD:C242([ItemXRef:22]; $aXRecNum{$i})
						pvItemNum:=[Item:4]itemNum:1
						pDescript:=[Item:4]description:7
						OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; False:C215)
						aoLnComment{aoLineAction}:=String:C10(aoLineAction)+"; "+pvItemNum
						Case of 
							: ($linkType=1)
								aOQtyOrder{aoLineAction}:=$pMasterQtyOrd*[ItemXRef:22]Quantity:12
								If ([ItemXRef:22]TypeSale:18="FFF")
									aOUnitPrice{aoLineAction}:=0
								End if 
							: ($linkType=0)
								aOQtyOrder{aoLineAction}:=$pMasterQtyOrd
								If ([ItemXRef:22]TypeSale:18="FFF")
									aOUnitPrice{aoLineAction}:=0
								End if 
								//check this by authority level
								//aODiscnt{aoLineAction}:=0
								OrdLnExtend(aoLineAction)
						End case 
					End if 
				End if 
			End for 
		End if 
	End if 
Else 
	QUERY:C277([Item:4]; [Item:4]itemNum:1=$xRItem)
	Case of 
		: (Records in selection:C76([Item:4])=1)
			QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=[Item:4]itemNum:1; *)
			QUERY:C277([ItemXRef:22];  & [ItemXRef:22]ItemNumXRef:2=$xRItem; *)
			QUERY:C277([ItemXRef:22];  & [ItemXRef:22]XRefLinked:17=$linkType)
			If ($4>0)
				viOrdLnCnt:=viOrdLnCnt+1
				pvItemNum:=[Item:4]itemNum:1
				pPartNum:=pvItemNum
				pDescript:=[Item:4]description:7
				[Item:4]qtySaleDefault:15:=$3  //do not save item        
				OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; False:C215)
				If (Records in selection:C76([ItemXRef:22])=1)
					aOQtyOrder{aoLineAction}:=$3*[ItemXRef:22]Quantity:12
					Case of 
						: ([ItemXRef:22]TypeSale:18="FFF")
							aOUnitPrice{aoLineAction}:=0
						: ($linkType=11)
							aOUnitPrice{aoLineAction}:=[ItemXRef:22]PriceA:20
						: ($linkType=12)
							aOUnitPrice{aoLineAction}:=[ItemXRef:22]PriceB:21
						: ($linkType=13)
							aOUnitPrice{aoLineAction}:=[ItemXRef:22]PriceC:22
						: ($linkType=14)
							aOUnitPrice{aoLineAction}:=[ItemXRef:22]PriceD:23
					End case 
				Else 
					aOQtyOrder{aoLineAction}:=$3
				End if 
				//check this by authority level
				//aODiscnt{aoLineAction}:=0
				OrdLnExtend(aoLineAction)
			Else 
				If (Records in selection:C76([ItemXRef:22])=1)
					Case of 
						: ([ItemXRef:22]TypeSale:18="FFF")
							//addDiscount:=0   No change
						: ($linkType=11)
							addDiscount:=addDiscount+[ItemXRef:22]PriceA:20
						: ($linkType=12)
							addDiscount:=addDiscount+[ItemXRef:22]PriceB:21
						: ($linkType=13)
							addDiscount:=addDiscount+[ItemXRef:22]PriceC:22
						: ($linkType=14)
							addDiscount:=addDiscount+[ItemXRef:22]PriceD:23
					End case 
				End if 
			End if 
		: (Records in selection:C76([Item:4])=0)
			QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumXRef:2=$xRItem; *)
			QUERY:C277([ItemXRef:22];  & [ItemXRef:22]XRefLinked:17=$linkType)
			If (Records in selection:C76([ItemXRef:22])=1)
				If ($4>0)
					QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemXRef:22]ItemNumMaster:1)
					If (Records in selection:C76([Item:4])=1)
						viOrdLnCnt:=viOrdLnCnt+1
						pvItemNum:=[Item:4]itemNum:1
						pPartNum:=pvItemNum
						pDescript:=[ItemXRef:22]DescriptionXRef:3
						[Item:4]qtySaleDefault:15:=$3  //do not save item
						OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; False:C215)
						aOQtyOrder{aoLineAction}:=$3*[ItemXRef:22]Quantity:12
						Case of 
							: ([ItemXRef:22]TypeSale:18="FFF")
								aOUnitPrice{aoLineAction}:=0
							: ($linkType=11)
								aOUnitPrice{aoLineAction}:=[ItemXRef:22]PriceA:20
							: ($linkType=12)
								aOUnitPrice{aoLineAction}:=[ItemXRef:22]PriceB:21
							: ($linkType=13)
								aOUnitPrice{aoLineAction}:=[ItemXRef:22]PriceC:22
							: ($linkType=14)
								aOUnitPrice{aoLineAction}:=[ItemXRef:22]PriceD:23
						End case 
						//check this by authority level
						//aODiscnt{aoLineAction}:=0
						OrdLnExtend(aoLineAction)
					End if 
				Else 
					Case of 
						: ([ItemXRef:22]TypeSale:18="FFF")
							//addDiscount:=0   No change
						: ($linkType=11)
							addDiscount:=addDiscount+([ItemXRef:22]PriceA:20*[ItemXRef:22]Quantity:12)
						: ($linkType=12)
							addDiscount:=addDiscount+([ItemXRef:22]PriceB:21*[ItemXRef:22]Quantity:12)
						: ($linkType=13)
							addDiscount:=addDiscount+([ItemXRef:22]PriceC:22*[ItemXRef:22]Quantity:12)
						: ($linkType=14)
							addDiscount:=addDiscount+([ItemXRef:22]PriceD:23*[ItemXRef:22]Quantity:12)
					End case 
				End if 
			End if 
		Else 
			//      
	End case 
End if 
UNLOAD RECORD:C212([ItemXRef:22])
UNLOAD RECORD:C212([Item:4])
//