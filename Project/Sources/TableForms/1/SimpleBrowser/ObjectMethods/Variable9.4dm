C_LONGINT:C283(<>StrLang)

$event:=Form event code:C388

//identify object names (dont forget that when duplicate objects !)
$FocusRing:="FocusRing2"  //focus ring (visible or dont depending on the focus
$SearchCriteria:="SearchCriteria2"  //search criteria grey (help)
$UseRessources:=False:C215

Case of 
	: ($event=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; $FocusRing; False:C215)
		vSearchValue2:=""
		If ($UseRessources)
			vSearchCriteria2:=Get indexed string:C510(<>StrLang; 5)
		Else 
			vSearchCriteria2:="Google"
		End if 
		
	: ($event=On After Keystroke:K2:26)
		
		$CurrentText:=Get edited text:C655
		If ($CurrentText#"")
			OBJECT SET VISIBLE:C603(*; $SearchCriteria; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; $SearchCriteria; True:C214)
		End if 
		
	: ($event=On Getting Focus:K2:7)
		OBJECT SET VISIBLE:C603(*; $FocusRing; True:C214)
		
	: ($event=On Losing Focus:K2:8)
		OBJECT SET VISIBLE:C603(*; $FocusRing; False:C215)
		
		$CurrentText:=Get edited text:C655
		If ($CurrentText#"")
			OBJECT SET VISIBLE:C603(*; $SearchCriteria; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; $SearchCriteria; True:C214)
		End if 
		
	: ($event=On Data Change:K2:15)
		//$text:=Tool_URLEncoder (Self->)
		$url:="http://www.google.com/search?q="+$text
		$url:="http://www.google.com/"
		
		WA OPEN URL:C1020(myBrowser; $url)
End case 
