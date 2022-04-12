Case of 
	: ([Invoice:26]jrnlComplete:48=True:C214)  //  : ((aiLineNum{aiLineAction}=-3)|([Invoice]OrderKey=1))//sj should be locked
		jAlertMessage(9206)
	Else 
		ListItemsLrScrn(->[Invoice:26]; pPartNum)  //;aiLineAction)
		vLineMod:=True:C214
End case 