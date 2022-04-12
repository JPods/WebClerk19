
Case of 
	: (Form event code:C388=On Load:K2:1)  // This event is generated at the start of loading a 
		WA SET PREFERENCE:C1041(*; "WebTech"; WA enable contextual menu:K62:6; True:C214)
		WA SET PREFERENCE:C1041(*; "WebTech"; WA enable Web inspector:K62:7; True:C214)
		
		vtTNPathSystem:=""
		// redundant to iLo procedure for Web Area
		
		If (False:C215)  // do not load tinyMCE in this layout
			C_TEXT:C284($wa_htmlEditor_path_t)
			$wa_htmlEditor_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"tinymce"+Folder separator:K24:12+"htmleditor.html"
			$wa_htmlEditor_path_t:=Convert path system to POSIX:C1106($wa_htmlEditor_path_t)
			WA OPEN URL:C1020(WebTech; "file:///"+$wa_htmlEditor_path_t)
		End if 
		
	: (Form event code:C388=On End URL Loading:K2:47)  //: This event is generated when all the 
		
		// load tinyMCE_Content_t in TNToWebAreaBody
		
		
		
	: (Form event code:C388=On Begin URL Loading:K2:45)  // This event is generated at the start of loading a 
		//new URL in the Web area. The "URL" variable associated with the Web area can 
		//be used to find out the URL being loaded. 
		// Note: The URL being loaded is different from the current URL 
		//(refer to the description of the WA Get current URL command).
		
		// WA STOP LOADING URL 
		
		C_TEXT:C284($url)
		$url:=WebTech_url
		
		Case of   // tinkering
			: ($url="#@")
				
			: ($url="Keyword@")
				
			: ($url="http://www.jpods.com/webtech@")
				WA STOP LOADING URL:C1024(*; "WebTech")
				<>vTN_OutSide:="Customer"
				POST OUTSIDE CALL:C329(Current process:C322)
		End case 
		
		
	: (Form event code:C388=On URL Resource Loading:K2:46)  //: This event is generated each time a new 
		//resource (picture, frame, etc.) is loaded on the current Web page. 
		// The "Progression" variable associated with the area lets you find out the current state of the loading.
		
		C_TEXT:C284($myURL)
		$myURL:=WA Get current URL:C1025(WebTech)
		
		
		
	: (Form event code:C388=On URL Loading Error:K2:48)  // This event is generated when an error is detected 
		//during the loading of a URL. 
		
		C_TEXT:C284($myURL)
		$myURL:=WA Get current URL:C1025(WebTech)
		
		$url:=WebTech_url
		//You can call the WA GET LAST URL ERROR command in order to get information about the error.
	: (Form event code:C388=On URL Filtering:K2:49)  //: This event is generated when the loading of a URL 
		//is blocked by the Web area because of a filter set up using the WA SET URL FILTERS command. 
		//You can find out the blocked URL using the WA Get last filtered URL command.
		
		C_TEXT:C284($myURL)
		$myURL:=WA Get current URL:C1025(WebTech)
		
		
	: (Form event code:C388=On Open External Link:K2:50)  //: This event is generated when the loading of a URL was 
		//blocked by the Web area and the URL was opened with the current system browser, 
		//because of a filter set up via the WA SET EXTERNAL LINKS FILTERS command. 
		//You can find out the blocked URL using the WA Get last filtered URL command.
		
		C_TEXT:C284($myURL)
		$myURL:=WA Get current URL:C1025(WebTech)
	: (Form event code:C388=On Window Opening Denied:K2:51)  // This event is generated when the opening of a 
		//pop-up window is blocked by the Web area. 4D Web areas do not allow the opening of pop-up windows. 
		//You can find out the blocked URL using the WA Get last filtered URL command.
		C_TEXT:C284($myURL)
		$myURL:=WA Get current URL:C1025(WebTech)
		
End case 