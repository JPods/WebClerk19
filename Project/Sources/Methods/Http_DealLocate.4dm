//%attributes = {"publishedWeb":true}
////Procedure: Http_DealLocate
////
//C_LONGINT($w; $h; $t; $1)
//C_TEXT($cat; $ser; $val; $jitZip; $jitProduct; $jitCategory; $jitPageList; $jitPageOne)
//C_POINTER($2)
//$recNum:=WCapi_GetParameter("RecordNum"; "")
//$recID:=WCapi_GetParameter("RecordID"; "")
//$jitZip:=WCapi_GetParameter("Zip"; "")
//If ($jitZip="")
//$jitZip:=WCapi_GetParameter("jitZip"; "")
//End if 

//$zipBegin:=WCapi_GetParameter("ZipBegin"; "")
//$zipEnd:=WCapi_GetParameter("ZipEnd"; "")


//C_LONGINT($zipRange; $distance)
//$zipRange:=Num(WCapi_GetParameter("ZipRange"; ""))
//$distance:=Num(WCapi_GetParameter("Distance"; ""))

//$option:=WCapi_GetParameter("LocationBy"; "")


////$jitProduct:=WCapi_GetParameter("jitProduct";"")
////$jitCategory:=WCapi_GetParameter("jitCategory";"")
//$jitPageList:=WCapi_GetParameter("jitPageList"; "")
//$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
////lang:=(WCapi_GetParameter("l";""))
////
////Case of 
////: (lang="fr")
////$suffix:="_fr"
////: (lang="de")
////$suffix:="_de"
////Else 
////lang:="us"
////$suffix:=""
////End case 
////zttp_UserGet 
//C_LONGINT($num)
//$suffix:=""
//$testCnt:=0
//vResponse:="No dealers identified based on the search defined."
//REDUCE SELECTION([Customer]; 0)
//Case of 
//: (RecordID#"")
//$testCnt:=0  // do not query by other means
//QUERY([Customer]; [Customer]customerID=RecordID)
//If (Records in selection([Customer])=1)
//If (([Customer]publish<1) | ([Customer]publish>viEndUserSecurityLevel))
//If ([Customer]prospect#"Deal@")
//REDUCE SELECTION([Customer]; 0)
//vResponse:="Not authorized to view this record."
//$testCnt:=0
//End if 
//End if 
//End if 
//: ($recNum#"")
//$testCnt:=0  // do not query by other means
//$num:=Num($recNum)
//GOTO RECORD([Customer]; $num)
//If (([Customer]publish<1) | ([Customer]publish>viEndUserSecurityLevel))
//If ([Customer]prospect#"Deal@")
//REDUCE SELECTION([Customer]; 0)
//vResponse:="Not authorized to view this record."
//$num:=0
//End if 
//Else 
//$num:=1
//End if 
//Else 
//QUERY([Customer]; [Customer]publish>0; *)
//QUERY([Customer];  & [Customer]prospect="Deal@"; *)
//C_LONGINT($secLevel)
//If (vWccSecurity>0)
//$secLevel:=vWccSecurity
//Else 
//$secLevel:=viEndUserSecurityLevel
//End if 
//QUERY([Customer];  & [Customer]publish<=$secLevel; *)
//Case of 
//: (LocationBy="Distance")
//If ($jitZip#"")
//QUERY([Customer];  & [Customer]zip=$jitZip+"@"; *)
//$testCnt:=1
//End if 
//: (LocationBy="zipRange")

//Else 
//QUERY([Customer];  & [Customer]zip>=$zipBegin; *)
//QUERY([Customer];  & [Customer]zip>=$zipEnd; *)
//End case 
//QUERY([Customer])
//End case 

//$num:=Records in selection([Customer])

//If ($num>1)
//$p:=Position("_jitSort"; $2->)
//If ($p>0)
//$showLast:=0
//$mySort:=Substring($2->; $p; 80)  //clip the sort command, get enough 
//$p:=Position(<>endTag; $mySort)  //find the end
//$mySort:=Substring($mySort; 1; $p+1)
//$showLast:=Http_DoSort($mySort)
//$mySort:="&"+$mySort+"&"
//Else 
//ORDER BY([Customer]; [Customer]zip)
//If (Records in selection([Customer])><>viMaxShow)
//REDUCE SELECTION([Customer]; <>viMaxShow)
//End if 
//End if 
//End if 
//Case of 
//: ($num>1)
//$pageDo:=WC_DoPage("DealersList.html"; $jitPageList)
//$err:=WC_PageSendWithTags($1; $pageDo; 0)
//: ($num=1)
//$pageSuffix:=""
//$pageDo:=WC_DoPage("DealersOne.html"; $jitPageOne)
//$err:=WC_PageSendWithTags($1; $pageDo; 0)
//Else 
//// Send no records found
//$jitPageError:=WCapi_GetParameter("jitPageError"; "")
//$pageDo:=WC_DoPage("Error.html"; $jitPageError)
//$err:=WC_PageSendWithTags($1; $pageDo; 0)
//End case 

//REDUCE SELECTION([Customer]; 0)
//REDUCE SELECTION([TallyResult]; 0)
