//%attributes = {"publishedWeb":true}
// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)


//Procedure: Http_SrchForum
//   //
// READ ONLY([Forum])
// C_LONGINT($w;$h;$t;$1;$testCnt;$DTRecord)
// C_TEXT($cat;$ser;$val;$recNum;$dtEntry;$subject;$who;$topic;$submitted)
// C_POINTER($2)
// $recNum:=WCapi_GetParameter("RecordID";"")
// $jitPageList:=WCapi_GetParameter("jitPageList";"")
// $jitPageOne:=WCapi_GetParameter("jitPageOne";"")
// $jitPageError:=WCapi_GetParameter("jitPageError";"")
//   //
// Case of 
// : (lang="fr")
// $suffix:="_fr"
// : (lang="de")
// $suffix:="_de"
// Else 
// lang:="us"
// $suffix:=""
// End case 
// REDUCE SELECTION([Forum];0)
// Case of 
// : ($recNum#"")
// QUERY([Forum];[Forum]Rs2=Num($recNum);*)
// $testCnt:=$testCnt+1
// Else 
// $subject:=WCapi_GetParameter("subject";"")
// $who:=WCapi_GetParameter("who";"")
// $topic:=WCapi_GetParameter("topic";"")
// $keyword:=WCapi_GetParameter("Keyword";"")
// $purpose:=WCapi_GetParameter("purpose";"")
// $dateBegin:=WCapi_GetParameter("dateBegin";"")
// $dateEnd:=WCapi_GetParameter("dateEnd";"")
// $testCnt:=0
// C_LONGINT($testCnt)
// If ($who#"")
// $testCnt:=$testCnt+1
// QUERY([Forum];[Forum]FromID=$who+"@";*)
// End if 
// If ($topic#"")
// If ($testCnt=0)
// QUERY([Forum];[Forum]Topic=$topic+"@";*)
// Else 
// QUERY([Forum]; & [Forum]Topic=$topic+"@";*)
// End if 
// $testCnt:=$testCnt+1
// End if 
// If ($keyword#"")
// If ($testCnt=0)
// QUERY([Forum];=$keyword+"@";*)
// Else 
// QUERY([Forum]; | =$keyword+"@";*)
// End if 
// $testCnt:=$testCnt+1
// End if 
// If ($subject#"")
// If ($testCnt=0)
// QUERY([Forum];[Forum]Subject=$subject+"@";*)
// Else 
// QUERY([Forum]; & [Forum]Subject=$subject+"@";*)
// End if 
// $testCnt:=$testCnt+1
// End if 
// If ($purpose#"")
// If ($testCnt=0)
// QUERY([Forum];[Forum]Purpose=$purpose+"@";*)
// Else 
// QUERY([Forum]; & [Forum]Purpose=$purpose+"@";*)
// End if 
// $testCnt:=$testCnt+1
// End if 
// Case of 
// : (($dateBegin#"") & ($dateEnd#""))
// If ($testCnt=0)
// QUERY([Forum];[Forum]DTSubmitted>=DateTime_Enter (Date($dateBegin);?00:00:00?);*)
// Else 
// QUERY([Forum]; & [Forum]DTSubmitted>=DateTime_Enter (Date($dateBegin);?00:00:00?);*)
// End if 
// QUERY([Forum]; & [Forum]DTSubmitted<=DateTime_Enter (Date($dateEnd);?23:59:59?);*)
// $testCnt:=$testCnt+1
// : (($dateBegin#"") & ($dateEnd=""))
// If ($testCnt=0)
// QUERY([Forum];[Forum]DTSubmitted>=DateTime_Enter (Date($dateBegin);?00:00:00?);*)
// Else 
// QUERY([Forum]; & [Forum]DTSubmitted>=DateTime_Enter (Date($dateBegin);?00:00:00?);*)
// End if 
// $testCnt:=$testCnt+1
// : ($dateEnd#"")  //($dateBegin#"")&
// If ($testCnt=0)
// QUERY([Forum];[Forum]DTSubmitted>=DateTime_Enter ((Date($dateEnd)-1);?23:59:59?);*)
// Else 
// QUERY([Forum]; & [Forum]DTSubmitted>=DateTime_Enter ((Date($dateEnd)-1);?23:59:59?);*)
// End if 
// $testCnt:=$testCnt+1
// End case 
// End case 
// If ($testCnt>0)
// QUERY([Forum]; & [Forum]Publish>0;*)
// QUERY([Forum]; & [Forum]Publish<=viEndUserSecurityLevel)
// End if 
// $num:=Records in selection([Forum])
//   //If (<>viDoHttpLog>10)
//   //http_SendLog ($1;"/Search_Forum/?subject="+$subject+"&who="+$who+"
//   //&submitted="+$submitted+"//"+String($num))
//   //End if 
// If (Records in selection([Forum])><>viMaxShow)
// REDUCE SELECTION([Forum];40)
// $num:=Records in selection([Forum])
// End if 
// If (Records in selection([Forum])>1)
// ORDER BY([Forum];[Forum]DTSubmitted;[Forum]Topic)
// End if 
//   //
// vText8:=""
// Case of 
// : ($num>1)
// $err:=WC_PageSendWithTags ($1;WC_DoPage ("ForumList"+$suffix+".html";jitPageList);0)
// : ($num=1)
// $err:=WC_PageSendWithTags ($1;WC_DoPage ("ForumRec"+$suffix+".html";$jitPageOne);0)
// Else 
//   // Send no records found
// vResponse:="There are no Forum Records matching your request."
// $err:=WC_PageSendWithTags ($1;WC_DoPage ("ForumSrch.html";$jitPageError);0)
// End case 
// READ WRITE([Forum])