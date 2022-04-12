KeyModifierCurrent
If (OptKey=1)
	ListItemsLrScrn(->[Invoice:26]; pPartNum)
Else 
	HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
End if 