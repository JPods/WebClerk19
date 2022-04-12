Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(ailoText16; 0)
		APPEND TO ARRAY:C911(ailoText16; "  --- Terminal Tools for SSL (Mac/Linux) ---  ")
		APPEND TO ARRAY:C911(ailoText16; "1. Start WebClerk server")
		APPEND TO ARRAY:C911(ailoText16; "2. Install certbot")
		APPEND TO ARRAY:C911(ailoText16; "3. Register command")
		APPEND TO ARRAY:C911(ailoText16; "4. Load paths into WebClerk")
		APPEND TO ARRAY:C911(ailoText16; "5. Renew command, every 90 days")
		APPEND TO ARRAY:C911(ailoText16; "6. Open folder, optional")
		APPEND TO ARRAY:C911(ailoText16; "   ---- Utilities ----")
		APPEND TO ARRAY:C911(ailoText16; "Show Hidden Folders")
		APPEND TO ARRAY:C911(ailoText16; "Hide Hidden Folders")
		APPEND TO ARRAY:C911(ailoText16; "   ---- Documentation ----")
		APPEND TO ARRAY:C911(ailoText16; "TechNotes")
		
	: (ailoText16{ailoText16}="1. Start WebClerk server")
		iLoText1:="a. Put your domain in the domain fieldClick the On button on this layout."
		iLoText1:=iLoText1+<>vCR+<>vCR+"b. Click on \"PathTojitWeb\" lable to set the path to the jitWeb folder."
		iLoText1:=iLoText1+<>vCR+<>vCR+"c. Uncheck  \"ForceSSL\" "
		iLoText1:=iLoText1+<>vCR+<>vCR+"d. Click the \"On\" button to lauch WebClerk"
		
	: (ailoText16{ailoText16}="2. Install certbot")
		iLoText1:="brew install certbot"+<>vCR+<>vCR+"Copy and paste into Terminal at the $ prompt"
		iLoText1:=iLoText1+<>vCR+<>vCR+"You many have to luck folders to create the required path."
		iLoText1:=iLoText1+<>vCR+<>vCR+"You will be provided with questions and errors."
		
	: (ailoText16{ailoText16}="3. Register command")
		
		iLoText1:="sudo certbot certonly --webroot -w "+Convert path system to POSIX:C1106([WebClerk:78]PathTojitWeb:16)+" -d "+[WebClerk:78]Domain:20
		iLoText1:=iLoText1+<>vCR+<>vCR+"Copy and paste into Terminal at the $ prompt"
		
	: (ailoText16{ailoText16}="4. Load paths into WebClerk")
		C_TEXT:C284($aliasPath; $targetPath)
		$aliasPath:=PathSystemVolumn+"private"+<>FOLDSEP+"etc"+<>FOLDSEP+"letsencrypt"+<>FOLDSEP+"live"+<>FOLDSEP+[WebClerk:78]Domain:20+<>FOLDSEP+"fullchain.pem"
		RESOLVE ALIAS:C695($aliasPath; $targetPath)
		[WebClerk:78]PathToCert:21:=$targetPath
		iLoText1:="The path to the cert alias is: "+$aliasPath
		iLoText1:=iLoText1+<>vCR+<>vCR+"This was resolved to: "+$targetPath
		iLoText1:=iLoText1+<>vCR+<>vCR+"If everything progressed, you can check  \"ForceSSL\", turn Off and On the WebClerk server. "
		
		$aliasPath:=PathSystemVolumn+"private"+<>FOLDSEP+"etc"+<>FOLDSEP+"letsencrypt"+<>FOLDSEP+"live"+<>FOLDSEP+[WebClerk:78]Domain:20+<>FOLDSEP+"privkey.pem"
		RESOLVE ALIAS:C695($aliasPath; $targetPath)
		[WebClerk:78]PathToKey:22:=$targetPath
		iLoText1:=iLoText1+<>vCR+<>vCR+"The path to the key alias is: "+$aliasPath
		iLoText1:=iLoText1+<>vCR+<>vCR+"This was resolved to: "+$targetPath
		
	: (ailoText16{ailoText16}="6. Open folder, optional")
		
		C_TEXT:C284($thePath; $folderName)
		$folderName:=PathSystemVolumn
		$thePath:=$folderName+"private"+<>foldSep+"etc"+<>foldSep+"letsencrypt"+<>foldSep
		iLoText1:="The path to your \"letsencrypt\" folder is:  "+$thePath
		If (Test path name:C476($thePath)#0)
			iLoText1:=iLoText1+<>vCR+<>vCR+"There was an error in opening that folder."
			$thePath:=$folderName+<>foldSep+"private"+<>foldSep+"etc"+<>foldSep
			iLoText1:=iLoText1+<>vCR+<>vCR+"Trying "+$thePath
			iLoText1:=iLoText1+<>vCR+<>vCR+"If you have difficulties you may need to manually unlock and create the path."
		End if 
		PathLaunchFolder($thePath)
		
	: (ailoText16{ailoText16}="5. Renew command, every 90 days")
		
		iLoText1:="sudo certbot renew"
		iLoText1:=iLoText1+<>vCR+<>vCR+"Copy and paste into Terminal at the $ prompt"
		iLoText1:=iLoText1+<>vCR+<>vCR+"Click on the CertExpire label to set a reminder of the expire date"
		iLoText1:=iLoText1+<>vCR+<>vCR+"It is possible to set this command as a CronJob to run automatically"
		
	: (ailoText16{ailoText16}="Hide Hidden Folders")
		iLoText1:="defaults write com.apple.finder AppleShowAllFiles false; killall Finder"
		iLoText1:=iLoText1+<>vCR+<>vCR+"Copy and paste into Terminal at the $ prompt"
		
	: (ailoText16{ailoText16}="Show Hidden Folders")
		iLoText1:="defaults write com.apple.finder AppleShowAllFiles true; killall Finder"
		iLoText1:=iLoText1+<>vCR+<>vCR+"Copy and paste into Terminal at the $ prompt"
		
	: (ailoText16{ailoText16}="LetsEncrypt TechNotes")
		
		<>vTN_OutSide:="LetsEncrypt"
		TN_Dialog
End case 
ailoText16:=1