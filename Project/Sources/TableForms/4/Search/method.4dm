C_LONGINT:C283($formEvent; $curRecNum)
$formEvent:=Form event code:C388

Case of 
	: (Before:C29)
		doSearch:=0
		KeyModifierCurrent
		If (OptKey=0)
			ItemSrVarsClear
		End if 
	Else 
		If (doSearch>0)
			Case of 
				: ((bMultiSr=1) & (bSearch=0))
					doSearch:=0
				: ((srItem="") & (srItemMfgID="") & (srItemVendorID="") & (srItemSpecID="") & (srItemKeyWords="") & (srItemDscrp="") & (srItemType="") & (srItemsProfile1="") & (srItemsProfile2="") & (srItemsProfile3="") & (srItemsProfile4=""))
					doSearch:=0
				: (bMultiSr=1)
					doSearch:=2000
			End case 
			If (doSearch>0)
				doSearch:=ItemSr(doSearch)
				doSearch:=-1  //avoid a loop between seach button and field entry
				viRecordsInSelection:=Records in selection:C76([Item:4])
				If (Records in selection:C76([Item:4])>0)
					CANCEL:C270
				End if 
			End if 
			//doSearch:=0  do not do this to avoid a double loop
		End if 
End case 