C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Load:K2:1)
	C_TEXT:C284($script; $strID)
	$script:="QUERY([Word];[Word]idNum="+String:C10([Word:99]idNum:1)+")"
	DB_ShowCurrentSelection(->[Word:99]; $script; 2; ""; 2)
	// table; script; setmanager; "title adder"; selectionmanager keep same
	DELAY PROCESS:C323(Current process:C322; 60)
	CANCEL:C270
End if 