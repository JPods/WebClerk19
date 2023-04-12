//%attributes = {"publishedWeb":true}
//
//If (False)
////
////Date: 03/11/03
////Who: Bill
////Description: 
//End if 
//If (False)
////Method: http_POStatusGet
////Date: 03/11/03
////Who: Bill
////Description: 
//End if 
//C_LONGINT($viProcess)
//$viProcess:=Current process
//MENU BAR(1;$viProcess;*)
//Process_InitLocal 
//C_POINTER($ptOrgFile)
//myOK:=0
//$ptOrgFile:=<>ptCurFile
//ptCurTable:=<>ptCurFile
////
//myOK:=1
//<>prcControl:=0
//
//
//QUERY([SyncRequirement];[SyncRequirement]UniqueID=11)
//Case of 
//: (Records in selection([SyncRequirement])=0)
//ALERT("No Sync Record Exists")
//: (Records in selection([SyncRequirement])>1)
//ALERT("Too Many Sync Records with ID = 11")
//Else 
//LOAD RECORD([SyncRequirement])
//If (Locked([SyncRequirement]))
//ALERT("[SyncRequirement] record is locked"
//Else 
//$dateTime:=[SyncRequirement]DTLastUpdate
//[SyncRequirement]DTLastUpdate:=DateTime_DTTo 
//SAVE RECORD([SyncRequirement])
//QUERY([Customer];[Customer]salesNameID=Current user;*)
//QUERY([Customer];|[Customer]RepID=Current user;*)
//QUERY([Customer];&[Customer]DTSync>=$dateTime)
////
//$theDomain:=[SyncRequirement]URL
//$theDomain:=Replace string($theDomain;"http://";"")
//$w:=Position("/";$theDomain)
//If ($w>0)
//$theDomain:=Substring($theDomain;1;$w-1)
//End if 
////      
//$k:=Records in selection([Customer])
//FIRST RECORD([Customer])
//For ($i;1;$k)
//
//$vRequest:="/WCC_SyncIn&customerID="+[Customer]customerID+"
//&Domain="+[Customer]Domain+"&Email="+[Customer]Email+"&UserName="+
//[SyncRequirement]RemoteUserName+"&Password="+[SyncRequirements
//]RemoteUserPassword
//$vRequest:=Http_BrowerRequestHead ($vRequest;$theDomain)
////          
//C_TEXT($1;$doc;$crlf;$machine;$m;$temp;$theText)
//C_LONGINT($c;$s;$err)
//ON ERR CALL("jOECNoAction")
//ARRAY TEXT(aText1;0)
////
//MESSAGES OFF
//// open stream with the HTTP server
//$c:=ITK_TCPOpen ($theDomain;80)
//If ($c#0)
//$debut:=Current time
//// wait connection for 30s
//Repeat 
//$s:=ITK_TCPStatus ($c)
//IDLE
//Until (($s>=8)|($s<0)|(Current time>($debut+00:00:30)))
//If ($s#8)
//TRACE
//Else 
//$err:=ITK_TCPSend ($c;$vRequest)
////$err:=ITK_TCPClose ($c)  //cannot close until activity is
// finished
//$theText:=""
//$fin:=False
//$debut:=Current time
//$cntElements:=1
//ARRAY TEXT($arrayText;$cntElements)
//C_LONGINT($cntElements;$cntEscape)
//$cntEscape:=0
//Repeat 
//IDLE
//DELAY PROCESS(Current process;<>vTicDelay)//10
//$err:=ITK_TCPRcv ($c;$temp)
//If ($temp="")
//$cntEscape:=$cntEscape+1
//Else 
//$cntEscape:=0
//End if 
//$temp:=Replace string($temp;Char(13);"")
//If (Length($temp)>0)
//$debut:=Current time
//End if 
//If (Length($arrayText{$cntElements})>10000)
//$cntElements:=$cntElements+1
//INSERT ELEMENT($arrayText;$cntElements)
//End if 
//$arrayText{$cntElements}:=$arrayText{$cntElements}+$temp
//If (Position(Char(10)+Char(10);$theText)#0)// check the
// content type
//If ((Position("Content-type:";$theText)#0)&(Position
//(" text/";$theText)=0))
//$fin:=True
//End if 
//End if 
////KeyModifierCurrent 
////If (OptKey=1)
////TRACE
////End if 
//Until ((ITK_TCPStatus ($c)=14)|($cntEscape>360)|($fin
//=True))
////
//$kArray:=Size of array($arrayText)
//vText11:=""
//For ($iArray;1;$kArray)
//vText11:=vText11+$arrayText{$iArray}
//End for 
////
//TRACE
//If (vText11#"")
//$syncStatus:=WCapi_GetParameter(->vText11;"SyncStatus";"")
//End if 
//SAVE RECORD([Customer])
//End if 
//End if 
//$err:=ITK_TCPRelease ($c)
//End case 
//End if 
//NEXT RECORD([PO])
//
//
//