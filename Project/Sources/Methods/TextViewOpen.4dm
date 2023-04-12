//%attributes = {}
C_LONGINT:C283(calSupport; $w; <>prcControl)
C_TEXT:C284(vAction)
MESSAGES OFF:C175
C_BOOLEAN:C305($1; $doAnyWay; $doSearch; $doPrcWind)
ControlRecCheck
C_LONGINT:C283($found)
Process_InitLocal
$found:=Prs_CheckRunnin("Processes")
If ($found>0)
	POST OUTSIDE CALL:C329($found)  //Storage.process.processList)
End if 
Open window:C153(Screen width:C187-324; 300; Screen width:C187-2; 850; -724; "TextView"; "Wind_CloseBox")
DIALOG:C40([Base:1]; "TextView")
CLOSE WINDOW:C154


If (False:C215)
	FORM SET INPUT:C55([Base:1]; "TextView")
	ptCurTable:=(->[Base:1])
	jSetMenuNums(1; 5; 6)
	// calSupport:=File([Service])//to be used for mixing calanders between files
	//If (($doAnyWay)|((Records in selection([Customer])>0)|(Records in selection([Lead])>0)|(Records in selection([Service])>0)))
	//If ($doPrcWind)
	WindowOpenTaskOffSets
	//End if 
	MODIFY RECORD:C57([Base:1])
End if 