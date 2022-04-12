C_TEXT:C284($pathCerts; $pathacme; $zerossl)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(ailoText15; 0)
		APPEND TO ARRAY:C911(ailoText15; "  --- Browser based SSL (all platforms) ---    ")
		
		APPEND TO ARRAY:C911(ailoText15; "1. Create acme-challenge folder")
		APPEND TO ARRAY:C911(ailoText15; "2. Create certs folder")
		APPEND TO ARRAY:C911(ailoText15; "3. GoTo ZeroSSL Web Site")
		APPEND TO ARRAY:C911(ailoText15; "4. Load path to Cert")
		APPEND TO ARRAY:C911(ailoText15; "5. Load path to Key")
		APPEND TO ARRAY:C911(ailoText15; "6. Restart WebClerk server")
		APPEND TO ARRAY:C911(ailoText15; "   ---- Utilities ----")
		APPEND TO ARRAY:C911(ailoText15; "Open certs folder")
		APPEND TO ARRAY:C911(ailoText15; "Open acme-challenge folder")
		APPEND TO ARRAY:C911(ailoText15; "Open pki-validation folder")
		APPEND TO ARRAY:C911(ailoText15; "LetsEncrypt: TechNotes")
		
		
		
	: (ailoText15{ailoText15}="Open acme-challenge folder")
		$pathacme:=[WebClerk:78]PathTojitWeb:16+".well-known"+<>foldSep+"acme-challenge"+<>foldSep
		PathLaunchFolder($pathacme)
		
	: (ailoText15{ailoText15}="Open pki-validation folder")
		$pathacme:=[WebClerk:78]PathTojitWeb:16+".well-known"+<>foldSep+"pki-validation"+<>foldSep
		PathLaunchFolder($pathacme)
		
		
	: (ailoText15{ailoText15}="Open certs folder")
		$pathCerts:=<>jitF+"certs"+<>foldSep+[WebClerk:78]Domain:20+<>foldSep
		PathLaunchFolder($pathCerts)
		
	: (ailoText15{ailoText15}="6. Restart WebClerk server")
		iLoText1:="If everything progressed, you can check  \"ForceSSL\", turn Off and On the WebClerk server. "
		
		
	: (ailoText15{ailoText15}="5. Load path to Key")
		iLoText1:="Click on the \"Key Path\" lable to navigate to and select the key."
		
	: (ailoText15{ailoText15}="4. Load path to Cert")
		iLoText1:="Click on the \"Cert Path\" lable to navigate to and select the cert."
		
	: (ailoText15{ailoText15}="1. Create acme-challenge folder")
		If (Test path name:C476([WebClerk:78]PathTojitWeb:16)#0)
			ALERT:C41("Not a valid path for [WebClerk]PathTojitWeb: "+[WebClerk:78]PathTojitWeb:16)
		Else 
			$pathacme:=[WebClerk:78]PathTojitWeb:16+".well-known"+<>foldSep+"acme-challenge"+<>foldSep
			If (Test path name:C476($pathacme)#0)
				CREATE FOLDER:C475($pathacme; *)
			End if 
			PathLaunchFolder($pathacme)
		End if 
		
	: (ailoText15{ailoText15}="2. Create certs folder")
		If (Test path name:C476([WebClerk:78]PathTojitWeb:16)#0)
			ALERT:C41("Not a valid path for [WebClerk]PathTojitWeb: "+[WebClerk:78]PathTojitWeb:16)
		Else 
			$pathCerts:=<>jitF+"certs"+<>foldSep+[WebClerk:78]Domain:20+<>foldSep
			If (Test path name:C476($pathCerts)#0)
				CREATE FOLDER:C475($pathCerts; *)
			End if 
			PathLaunchFolder($pathCerts)
		End if 
		
		
	: (ailoText15{ailoText15}="3. GoTo ZeroSSL Web Site")
		OPEN URL:C673("https://zerossl.com/")
		iLoText1:="a. Enter your email on the left."
		iLoText1:=iLoText1+<>vCR+<>vCR+"b. Enter you domains on the right. Example: "+[WebClerk:78]Domain:20+", "+Replace string:C233([WebClerk:78]Domain:20; "www."; "")
		iLoText1:=iLoText1+<>vCR+<>vCR+"c. Check the two checkboxes that you accept the terms, if you do."
		iLoText1:=iLoText1+<>vCR+<>vCR+"d. Click \"Next\" button the in the upper right."
		iLoText1:=iLoText1+<>vCR+<>vCR+" --  The window will change."
		iLoText1:=iLoText1+<>vCR+<>vCR+"e. Click the download button to download the CSR (request)."
		iLoText1:=iLoText1+<>vCR+<>vCR+"f. Click \"Next\" button the in the upper right."
		iLoText1:=iLoText1+<>vCR+<>vCR+"g. Click the two download buttons to the two acme-challenge tags."
		iLoText1:=iLoText1+<>vCR+<>vCR+"h. Open the acme-challenge folder in your jitWeb folder and your Downloads folder."
		iLoText1:=iLoText1+<>vCR+<>vCR+"i. Copy the two acme-challenge tags into your domain's acme-challenge folder."
		iLoText1:=iLoText1+<>vCR+<>vCR+" --  "+[WebClerk:78]PathTojitWeb:16+".well-known"+<>foldSep+"acme-challenge"+<>foldSep
		iLoText1:=iLoText1+<>vCR+<>vCR+"j. Make sure your WebClerk folder is serving and ForceSSL is unchecked. Restart if necessary."
		iLoText1:=iLoText1+<>vCR+<>vCR+"k. Click \"Next\" button the in the upper right."
		iLoText1:=iLoText1+<>vCR+<>vCR+" --  The acme-challenge will be tested, confirmed/rejected."
		iLoText1:=iLoText1+<>vCR+<>vCR+" --  If rejected unlock and manually create the required path."
		iLoText1:=iLoText1+<>vCR+<>vCR+" --  If rejected check your spelling."
		iLoText1:=iLoText1+<>vCR+<>vCR+" --  When approved you will be taken to the window to download your Private Key and Cert. "
		iLoText1:=iLoText1+<>vCR+<>vCR+"l. Click the download buttons to download your Private Key and Cert. "
		iLoText1:=iLoText1+<>vCR+<>vCR+"m. Move you CSR, Private Key, and Cert into your domain folder. "
		iLoText1:=iLoText1+<>vCR+<>vCR+" --  "+<>jitF+"certs"+<>foldSep+[WebClerk:78]Domain:20+<>foldSep
		iLoText1:=iLoText1+<>vCR+<>vCR+"m. Move you CSR, Private Key, and Cert into your domain folder. "
		
	: (ailoText15{ailoText15}="LetsEncrypt: TechNotes")
		
		<>vTN_OutSide:="LetsEncrypt"
		TN_Dialog
End case 
ailoText15:=1