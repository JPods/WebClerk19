C_TEXT:C284($vText)

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(aTabControl1; 0)
		APPEND TO ARRAY:C911(aTabControl1; "Logistics")
		APPEND TO ARRAY:C911(aTabControl1; "Communications")
		APPEND TO ARRAY:C911(aTabControl1; "Members")
		APPEND TO ARRAY:C911(aTabControl1; "Situtaion")
		APPEND TO ARRAY:C911(aTabControl1; "Alignment")
		APPEND TO ARRAY:C911(aTabControl1; "Culture")
		APPEND TO ARRAY:C911(aTabControl1; "KeyText")
		
		aTabControl1:=1
		
		
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (aTabControl1=1)
				tinyMCE_Content_t:=[Objective:145]logistics:25
				
			: (aTabControl1=2)
				tinyMCE_Content_t:=[Objective:145]communications:26
				
			: (aTabControl1=3)
				//tinyMCE_Content_t:=[Objective]obMembers
				
			: (aTabControl1=4)
				tinyMCE_Content_t:=[Objective:145]situation:12
				
			: (aTabControl1=5)
				tinyMCE_Content_t:=[Objective:145]alignment:10
				
			: (aTabControl1=6)
				tinyMCE_Content_t:=[Objective:145]culture:11
				
			: (aTabControl1=7)
				tinyMCE_Content_t:=[Objective:145]keyText:14
		End case 
		
		$techPath:=<>pathServer+"Objectives"+<>FOLDERSEPARATOR
		tinyMCE_Content_t:=Tx_ReplaceURLstrings(tinyMCE_Content_t; "src=\""; "\""; $techPath; "/,./,../")
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(myWebArea; "setContent"; *; tinyMCE_cleanCR(tinyMCE_Content_t))
End case 