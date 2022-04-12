//%attributes = {"publishedWeb":true}
//C_LONGINT(calSupport;bCust;bLead;bService;$w;<>prcControl)
//C_TEXT(vAction)
//MESSAGES OFF
//C_BOOLEAN($1;$doAnyWay;$doSearch;$doPrcWind)
//$doPrcWind:=False
//If (<>prcControl=1)
//<>prcControl:=0
//$doPrcWind:=True
//Process_InitLocal 
//$w:=Find in array(<>aNameID;Current user)
//If ($w>0)
//<>aNameID:=$w
//End if 
//bCust:=1
//bLead:=1
//bService:=1
//vdDateBeg:=Current date-30
//vdDateEnd:=Current date
//b1:=1
//b2:=1
//vAction:=""
//$doAnyWay:=True
//$doSearch:=True
//myOK:=1
//Else 
//$doAnyWay:=True
//$doSearch:=False
//REDUCE SELECTION([Customer];0)
//REDUCE SELECTION([Lead];0)
//REDUCE SELECTION([Service];0)
//myOK:=1
//End if 
//If (myOK=1)
//If ($doSearch=True)
//CAL_SearchFiles 
//End if 
//ControlRecCheck 
//DISABLE ITEM(1;4)
//INPUT LAYOUT([Control];"Schedule")
//ptCurFile:=([Control])
//jSetMenuNums (1;5;6)
//// calSupport:=File([Service])//to be used for mixing calanders between
// files
//If (($doAnyWay)|((Records in selection([Customer])>0)|(Records in
// selection([Lead])>0)|(Records in selection([Service])>0)))
//If ($doPrcWind)
//OPEN WINDOW(4;40;635;475;8)
//End if 
//ProcessTableOpen ([Control])
//<>aNameID:=1
//<>aActions:=1
//End if 
//MESSAGES ON
//End if 