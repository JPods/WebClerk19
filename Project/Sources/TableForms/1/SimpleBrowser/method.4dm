Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(myWebArea_progress; False:C215)
		//Browser_Favorites("init")
		
		CurrentURL:=""
		SET TIMER:C645(60)
		
	: (Form event code:C388=On Timer:K2:25)
		If ((myWebArea_progress>98) | (myWebArea_progress<2))
			OBJECT SET VISIBLE:C603(myWebArea_progress; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(myWebArea_progress; True:C214)
		End if 
		
	: (Form event code:C388=On Menu Selected:K2:14)
		$menu:=(Menu selected:C152 & 0xFFFF0000) >> 16
		$line:=Menu selected:C152 & 0xFFFF
		Case of 
			: ($menu=3)
				Case of 
					: ($line=1)
						//Browser_Favorites("add")
						
					Else 
						$indice:=$line-2
						//GOTO RECORD([Favorite];tabFavorites_ID{$indice})
						WA OPEN URL:C1020(myBrowser; "http://google.com")
						GOTO OBJECT:C206(vSearchCriteria2)  // leave the URL object, to show the progress animation
				End case 
				
		End case 
End case 
