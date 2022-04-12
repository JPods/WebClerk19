//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/06/08, 10:05:20
// ----------------------------------------------------
// Method: ItemSr
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $0; bMultiSr; $secItem)
C_TEXT:C284($wildCard)
KeyModifierCurrent
//TRACE
ARRAY LONGINT:C221(aItemLines; 0)  // clear the current selected line, used iLo and QuickQuote

$clearVars:=True:C214
$wildCard:="@"*Num:C11(CmdKey=0)  //wild search if 
Case of 
	: ($1=2103)
		doQuickQuote:=1
		
		// Srch_FullDia (->[Item])
		// ### bj ### 20190113_1904
		QueryEditorModal(->[Item:4])
		
		doQuickQuote:=0
		$1:=myOK
		myOK:=0
		HIGHLIGHT TEXT:C210(srItem; 1; 80)
	: (bMultiSr=1)
		$clearVars:=False:C215
		$secItem:=0
		Case of 
			: ($1=2000)  //do multiple search
				If (srItemKeyWords#"")
					KeyWordByAlpha(Table:C252(->[Item:4]); srItemKeyWords; True:C214)
				Else 
					If (ShftKey=0)
						QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
						$secItem:=1
					End if 
					If (srItem#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]itemNum:1=srItem+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]itemNum:1=srItem+$wildCard; *)
						End if 
					End if 
					If (srItemDscrp#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]description:7=srItemDscrp+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]description:7=srItemDscrp+$wildCard; *)
						End if 
					End if 
					If (srItemMfgItemNum#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=srItemMfgItemNum+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]mfrItemNum:39=srItemMfgItemNum+$wildCard; *)
						End if 
					End if 
					If (srItemType#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]type:26=srItemType+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]type:26=srItemType+$wildCard; *)
						End if 
					End if 
					If (srItemsProfile1#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]profile1:35=srItemsProfile1+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]profile1:35=srItemsProfile1+$wildCard; *)
						End if 
					End if 
					If (srItemsProfile2#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]profile2:36=srItemsProfile2+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]profile2:36=srItemsProfile2+$wildCard; *)
						End if 
					End if 
					If (srItemsProfile3#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]profile3:37=srItemsProfile3+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]profile3:37=srItemsProfile3+$wildCard; *)
						End if 
					End if 
					If (srItemsProfile4#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]profile4:38=srItemsProfile4+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]profile4:38=srItemsProfile4+$wildCard; *)
						End if 
					End if 
					If (srItemMfgID#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]mfrID:53=srItemMfgID+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]mfrID:53=srItemMfgID+$wildCard; *)
						End if 
					End if 
					If (srItemVendorID#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]vendorID:45=srItemVendorID+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]vendorID:45=srItemVendorID+$wildCard; *)
						End if 
					End if 
					If (srItemSpecID#"")
						If ($secItem=0)
							QUERY:C277([Item:4]; [Item:4]specid:62=srItemSpecID+$wildCard; *)
							$secItem:=1
						Else 
							QUERY:C277([Item:4];  & [Item:4]specid:62=srItemSpecID+$wildCard; *)
						End if 
					End if 
					QUERY:C277([Item:4])
				End if 
			: ($1=1)
				// SEARCH([Item])
				doQuickQuote:=1
				Srch_FullDia(->[Item:4])
				doQuickQuote:=0
			Else 
				$1:=0  //do not do any thing else
		End case 
	: ($1=1000)
		$1:=0
	: ($1=1)
		doQuickQuote:=1
		// Srch_FullDia (->[Item])
		// ### bj ### 20190113_1904
		QueryEditorModal(->[Item:4])
		
		
		doQuickQuote:=0
		$1:=myOK
		myOK:=0
		HIGHLIGHT TEXT:C210(srItem; 1; 80)
	: (($1=2) & (srItem#""))
		
		C_BOOLEAN:C305($vbSearch)
		$vbSearch:=True:C214
		
		// check if item is retired and ItemXRef replacement exists
		QUERY BY FORMULA:C48([ItemXRef:22]; (\
			([Item:4]itemNum:1=[ItemXRef:22]itemNumMaster:1)\
			 & ([ItemXRef:22]itemNumMaster:1=srItem)\
			 & ([ItemXRef:22]relationship:27="Replacement")\
			 & ([Item:4]retired:64=True:C214)))
		
		If (Records in selection:C76([ItemXRef:22])>0)
			ARRAY TEXT:C222($atItemNums; 0)
			
			DISTINCT VALUES:C339([ItemXRef:22]itemNumXRef:2; $atItemNums)
			QUERY WITH ARRAY:C644([Item:4]itemNum:1; $atItemNums)
			
			If (Records in selection:C76([Item:4])>0)
				$vbSearch:=False:C215  // skip standard search replacement Xref found
				C_TEXT:C284($vtReplacements)
				$vtReplacements:=""
				FIRST RECORD:C50([Item:4])
				$vi2:=Records in selection:C76([Item:4])
				For ($vi1; 1; $vi2)
					$vtReplacements:=$vtReplacements+"\r"+[Item:4]itemNum:1+" - "+Substring:C12([Item:4]description:7; 1; 32)+"..."
					If ($vi1<$vi2)
						NEXT RECORD:C51([Item:4])
					End if 
				End for 
				ALERT:C41("ERROR: "+srItem+" IS RETIRED. \r\rRecomended Replacement(s):"+$vtReplacements)
			Else 
				ALERT:C41(srItem+" is Retired, No Recomennded Replacement")
			End if 
		End if 
		
		If ($vbSearch=True:C214)
			
			If (ShftKey=0)
				//QUERY([Item];[Item]Retired=False;*)
				//QUERY([Item]; & [Item]ItemNum=srItem+$wildCard)
				QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=srItem+$wildCard)
				If (Records in selection:C76([Item:4])=0)
					QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
					QUERY:C277([Item:4]; [Item:4]barCode:34=srItem+$wildCard)
					If (Records in selection:C76([Item:4])=0)
						QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
						QUERY:C277([Item:4]; [Item:4]ean:82=srItem+$wildCard)
						If (Records in selection:C76([Item:4])=0)
							QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
							QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=srItem+$wildCard)
							If (Records in selection:C76([Item:4])=0)
								QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
								QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=srItem+$wildCard)
								If (Records in selection:C76([Item:4])=0)
									QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumXRef:2=srItem+$wildCard)
									If (Records in selection:C76([ItemXRef:22])>0)
										
										QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemXRef:22]itemNumMaster:1)
									End if 
								Else 
									ALERT:C41("ItemNum, Barcode, MfgItemNum not found")
								End if 
							End if 
						End if 
					End if 
				End if 
			Else 
				//QUERY([Item];[Item]ItemNum=srItem+$wildCard)   ###jwm### 20081001
				QUERY:C277([Item:4]; [Item:4]itemNum:1=srItem+$wildCard)
				If (Records in selection:C76([Item:4])=0)
					QUERY:C277([Item:4]; [Item:4]barCode:34=srItem+$wildCard)
					If (Records in selection:C76([Item:4])=0)
						QUERY:C277([Item:4]; [Item:4]ean:82=srItem+$wildCard)
						If (Records in selection:C76([Item:4])=0)
							QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=srItem+$wildCard)
							If (Records in selection:C76([Item:4])=0)
								QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=srItem+$wildCard)
								If (Records in selection:C76([Item:4])=0)
									QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumXRef:2=srItem+$wildCard)
									If (Records in selection:C76([ItemXRef:22])>0)
										
										QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemXRef:22]itemNumMaster:1)
									End if 
								Else 
									ALERT:C41("ItemNum, Barcode, MfgItemNum not found")
								End if 
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
		
		HIGHLIGHT TEXT:C210(srItem; 1; 80)
	: (($1=3) & (srItemDscrp#""))
		If (ShftKey=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]description:7=srItemDscrp+$wildCard)
		Else 
			QUERY:C277([Item:4]; [Item:4]description:7=srItemDscrp+$wildCard)
		End if 
		HIGHLIGHT TEXT:C210(srItemDscrp; 1; 80)
	: (($1=4) & (srItemType#""))
		If (ShftKey=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]type:26=srItemType+$wildCard)
		Else 
			QUERY:C277([Item:4]; [Item:4]type:26=srItemType+$wildCard)
		End if 
		HIGHLIGHT TEXT:C210(srItemType; 1; 80)
	: (($1=5) & (srItemsProfile1#""))
		If (ShftKey=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]profile1:35=srItemsProfile1+$wildCard)
		Else 
			QUERY:C277([Item:4]; [Item:4]profile1:35=srItemsProfile1+$wildCard)
		End if 
		HIGHLIGHT TEXT:C210(srItemsProfile1; 1; 80)
	: (($1=6) & (srItemsProfile2#""))
		If (ShftKey=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]profile2:36=srItemsProfile2+$wildCard)
		Else 
			QUERY:C277([Item:4]; [Item:4]profile2:36=srItemsProfile2+$wildCard)
		End if 
		HIGHLIGHT TEXT:C210(srItemsProfile2; 1; 80)
	: (($1=7) & (srItemsProfile3#""))
		If (ShftKey=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]profile3:37=srItemsProfile3+$wildCard)
		Else 
			QUERY:C277([Item:4]; [Item:4]profile3:37=srItemsProfile3+$wildCard)
		End if 
		HIGHLIGHT TEXT:C210(srItemsProfile3; 1; 80)
	: (($1=8) & (srItemsProfile4#""))
		If (ShftKey=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]profile4:38=srItemsProfile4+$wildCard)
		Else 
			QUERY:C277([Item:4]; [Item:4]profile4:38=srItemsProfile4+$wildCard)
		End if 
		HIGHLIGHT TEXT:C210(srItemsProfile4; 1; 80)
	: (($1=9) & (srItemMfgItemNum#""))
		If (ShftKey=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]mfrItemNum:39=srItemMfgItemNum+$wildCard)
		Else 
			QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=srItemMfgItemNum+$wildCard)
		End if 
	: (($1=10) & (srItemKeyWords#""))
		KeyWordByAlpha(Table:C252(->[Item:4]); srItemKeyWords; True:C214)
	: (($1=11) & (srItemMfgID#""))
		If (ShftKey=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]mfrID:53=srItemMfgID+$wildCard)
		Else 
			QUERY:C277([Item:4]; [Item:4]mfrID:53=srItemMfgID+$wildCard)
		End if 
		
	: (($1=12) & (srItemVendorID#""))
		If (ShftKey=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]vendorID:45=srItemVendorID+$wildCard)
		Else 
			QUERY:C277([Item:4]; [Item:4]vendorID:45=srItemVendorID+$wildCard)
		End if 
		
	: (($1=13) & (srItemSpecID#""))
		If (ShftKey=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]specid:62=srItemSpecID+$wildCard)
		Else 
			QUERY:C277([Item:4]; [Item:4]specid:62=srItemSpecID+$wildCard)
		End if 
		
	: ($1=14)
		If (ShftKey=0)
			//QUERY([Item];[Item]Retired=False;*)
			//QUERY([Item]; & [Item]ItemNum=srItem)
			QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=srItem)
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
				QUERY:C277([Item:4]; [Item:4]barCode:34=srItem)
				If (Records in selection:C76([Item:4])=0)
					QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
					QUERY:C277([Item:4]; [Item:4]ean:82=srItem)
					If (Records in selection:C76([Item:4])=0)
						QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
						QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=srItem)
						If (Records in selection:C76([Item:4])=0)
							QUERY:C277([Item:4]; [Item:4]retired:64=False:C215; *)
							QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=srItem)
							If (Records in selection:C76([Item:4])=0)
								QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumXRef:2=srItem)
								If (Records in selection:C76([ItemXRef:22])>0)
									
									QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemXRef:22]itemNumMaster:1)
								End if 
							Else 
								ALERT:C41("ItemNum, Barcode, MfgItemNum not found")
							End if 
						End if 
					End if 
				End if 
			End if 
		Else 
			//QUERY([Item];[Item]ItemNum=srItem)   ###jwm### 20081001
			QUERY:C277([Item:4]; [Item:4]itemNum:1=srItem)
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]barCode:34=srItem)
				If (Records in selection:C76([Item:4])=0)
					QUERY:C277([Item:4]; [Item:4]ean:82=srItem)
					If (Records in selection:C76([Item:4])=0)
						QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=srItem)
						If (Records in selection:C76([Item:4])=0)
							QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=srItem)
							If (Records in selection:C76([Item:4])=0)
								QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumXRef:2=srItem)
								If (Records in selection:C76([ItemXRef:22])>0)
									
									QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemXRef:22]itemNumMaster:1)
								End if 
							Else 
								ALERT:C41("ItemNum, Barcode, MfgItemNum not found")
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
		HIGHLIGHT TEXT:C210(srItem; 1; 80)
		
	: ($1=15)
		
		KeyWordByAlpha(Table:C252(->[Item:4]); srKeyword; True:C214)
		$vLen:=Length:C16(srKeyword)+1
		HIGHLIGHT TEXT:C210(srKeyword; $vLen; $vLen)
		
End case 
If ((OptKey=1) & (vHere>0))
	Case of 
		: (doSearch=1000)  //skip this      
		: (Records in selection:C76([Item:4])>1)
			//TRACE
		: (Records in selection:C76([Item:4])=1)
			//MODIFY RECORD([Item])
			ProcessTableOpen(Table:C252(->[Item:4])*-1)
		Else 
			REDUCE SELECTION:C351([Item:4]; 0)
			vPartNum:=srItem
			//ADD RECORD([Item])
			Process_AddRecord("Item")
	End case 
End if 
$0:=$1
//
If (False:C215)  //($clearVars) 
	srItem:=""
	srItemDscrp:=""
	srItemType:=""
	srItemsProfile1:=""
	srItemsProfile2:=""
	srItemsProfile3:=""
	srItemsProfile4:=""
	srItemMfgItemNum:=""
	srItemKeyWords:=""
	srItemMfgID:=""
	srItemVendorID:=""
	srItemSpecID:=""
End if 

