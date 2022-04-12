C_TEXT:C284($wa_htmlEditor_path_t; vtTNPathSystem; $theChapterFolder)

Case of 
	: (Form event code:C388=On Load:K2:1)  // This event is generated at the start of loading a 
		// problems with paths
		
		//Execute_TallyMaster(Current machine; "Current Machine")
		C_TEXT:C284($WASalesURL; <>WASalesURL)
		If (<>WASalesURL#"")
			
		Else 
			$WASalesURL:="http://www.webclerk.com"
		End if 
		WA OPEN URL:C1020(WASales; $WASalesURL)
		//WA SET PREFERENCE(*; "WebSales"; WA enable contextual menu; True)
		//WA SET PREFERENCE(*; "WebSales"; WA enable Web inspector; True)
		//WA OPEN URL(*; "WebSales"; "http://www.google.com")
		//WA OPEN URL(WebSales; "http://www.google.com")
		
	: (Form event code:C388=On End URL Loading:K2:47)  //: This event is generated when all the 
		// load tinyMCE_Content_t in TNToWebAreaBody
		
		//WA EXECUTE JAVASCRIPT FUNCTION(WebSales; "setContent"; *; )
		
		
	: (Form event code:C388=On Begin URL Loading:K2:45)  // This event is generated at the start of loading a 
		//new URL in the Web area. The "URL" variable associated with the Web area can 
		//be used to find out the URL being loaded. 
		// Note: The URL being loaded is different from the current URL 
		//(refer to the description of the WA Get current URL command).
		
		// WA STOP LOADING URL 
		
		C_TEXT:C284($url)
		$url:=WASales_url
		
		Case of 
			: ($url="#@")
				
			: ($url="Keyword@")
				
			: ($url="http://www.jpods.com/WASales@")
				WA STOP LOADING URL:C1024(*; "WASales")
				<>vTN_OutSide:="Customer"
				POST OUTSIDE CALL:C329(Current process:C322)
		End case 
		
		
	: (Form event code:C388=On URL Resource Loading:K2:46)  //: This event is generated each time a new 
		//resource (picture, frame, etc.) is loaded on the current Web page. 
		// The "Progression" variable associated with the area lets you find out the current state of the loading.
		
		C_TEXT:C284($myURL)
		$myURL:=WA Get current URL:C1025(WASales)
		
		
		
	: (Form event code:C388=On URL Loading Error:K2:48)  // This event is generated when an error is detected 
		//during the loading of a URL. 
		
		C_TEXT:C284($myURL)
		$myURL:=WA Get current URL:C1025(WASales)
		
		$url:=WASales_url
		//You can call the WA GET LAST URL ERROR command in order to get information about the error.
	: (Form event code:C388=On URL Filtering:K2:49)  //: This event is generated when the loading of a URL 
		//is blocked by the Web area because of a filter set up using the WA SET URL FILTERS command. 
		//You can find out the blocked URL using the WA Get last filtered URL command.
		
		C_TEXT:C284($myURL)
		$myURL:=WA Get current URL:C1025(WASales)
		
		
	: (Form event code:C388=On Open External Link:K2:50)  //: This event is generated when the loading of a URL was 
		//blocked by the Web area and the URL was opened with the current system browser, 
		//because of a filter set up via the WA SET EXTERNAL LINKS FILTERS command. 
		//You can find out the blocked URL using the WA Get last filtered URL command.
		
		C_TEXT:C284($myURL)
		$myURL:=WA Get current URL:C1025(WASales)
	: (Form event code:C388=On Window Opening Denied:K2:51)  // This event is generated when the opening of a 
		//pop-up window is blocked by the Web area. 4D Web areas do not allow the opening of pop-up windows. 
		//You can find out the blocked URL using the WA Get last filtered URL command.
		C_TEXT:C284($myURL)
		$myURL:=WA Get current URL:C1025(WASales)
		
End case 