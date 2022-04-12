//%attributes = {"publishedWeb":true}
//Procedure: Http_SrchFAQ
//
READ ONLY:C145([TallyResult:73])
C_LONGINT:C283($w; $h; $t; $1)
C_TEXT:C284($cat; $ser; $val)
C_POINTER:C301($2)
$recNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
$recID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
$profile3:=WCapi_GetParameter("Profile3"; "")  //subject
$profile1:=WCapi_GetParameter("Profile1"; "")  //who
$keyword:=WCapi_GetParameter("Keyword"; "")
If ($keyword="")
	$keyword:=WCapi_GetParameter("Keywords"; "")
End if 
$profile2:=WCapi_GetParameter("Purpose"; "")
$name:=WCapi_GetParameter("name"; "")
$dateBegin:=WCapi_GetParameter("dateBegin"; "")
$dateEnd:=WCapi_GetParameter("dateEnd"; "")
//lang:=(WCapi_GetParameter("l";""))  //done in the main server loop
//
vResponse:=""
//zttp_UserGet 
TRACE:C157
REDUCE SELECTION:C351([TallyResult:73]; 0)
Case of 
	: ($recNum>0)
		GOTO RECORD:C242([TallyResult:73]; $recNum)
		If (([TallyResult:73]publish:36<1) | ([TallyResult:73]publish:36>viEndUserSecurityLevel))
			REDUCE SELECTION:C351([TallyResult:73]; 0)
		End if 
	: ($recID>0)
		QUERY:C277([TallyResult:73]; [TallyResult:73]idNum:35=$recID; *)
		If (([TallyResult:73]publish:36<1) | ([TallyResult:73]publish:36>viEndUserSecurityLevel))
			REDUCE SELECTION:C351([TallyResult:73]; 0)
		End if 
	Else 
		$testCnt:=0
		C_LONGINT:C283($testCnt)
		QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="FAQ@")
		If ($profile1#"")
			QUERY:C277([TallyResult:73];  & [TallyResult:73]profile1:17=$profile1+"@"; *)
		End if 
		If ($name#"")
			QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1=$name+"@"; *)
		End if 
		If ($keyword#"")
			C_LONGINT:C283($p; $cycleCnt)
			C_TEXT:C284($testWord)
			$cycleCnt:=$testCnt
			Repeat 
				$p:=Position:C15("; "; $keyWord)
				If ($p>0)
					$testWord:=Substring:C12($keyWord; 1; $p-1)
					$keyWord:=Substring:C12($keyWord; $p+2)
				Else 
					$testWord:=$keyWord
				End if 
				QUERY:C277([TallyResult:73];  & [TallyResult:73]keyTags:54%$testWord+"@"; *)
				$cycleCnt:=1
			Until ($p=0)
			$testCnt:=$testCnt+1
		End if 
		If ($profile2#"")
			QUERY:C277([TallyResult:73];  | [TallyResult:73]profile2:18=$profile2+"@"; *)
		End if 
		If ($profile3#"")
			QUERY:C277([TallyResult:73];  | [TallyResult:73]profile3:19=$profile3+"@"; *)
		End if 
		//
		If ($dateBegin#"")
			QUERY:C277([TallyResult:73];  & [TallyResult:73]dtCreated:11>=DateTime_Enter(Date:C102($dateBegin); ?00:00:00?); *)
		End if 
		If ($dateEnd#"")
			QUERY:C277([TallyResult:73];  & [TallyResult:73]dtCreated:11<=DateTime_Enter(Date:C102($dateEnd); ?23:59:59?); *)
		End if 
		QUERY:C277([TallyResult:73];  & [TallyResult:73]publish:36>0; *)
End case 
$num:=Records in selection:C76([TallyResult:73])
If (Records in selection:C76([TallyResult:73])><>viMaxShow)
	REDUCE SELECTION:C351([TallyResult:73]; <>viMaxShow)
	$num:=Records in selection:C76([TallyResult:73])
End if 
If (Records in selection:C76([TallyResult:73])>1)
	ORDER BY:C49([TallyResult:73]; [TallyResult:73]profile2:18)
End if 
//
$suffix:=""
Case of 
	: ($num>1)
		$jitPageList:=WCapi_GetParameter("jitPageList"; "")
		$pageDo:=WC_DoPage("FAQsList.html"; $jitPageList)
	: ($num=1)
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		$pageDo:=WC_DoPage("FAQsOne.html"; $jitPageOne)
	Else 
		$jitPageError:=WCapi_GetParameter("jitPageError"; "")
		// Send no records found
		vResponse:="There are no Forum Records matching your request."
		$pageDo:=WC_DoPage("error.html"; $jitPageError)
End case 
$err:=WC_PageSendWithTags($1; $pageDo; 0)
REDUCE SELECTION:C351([TallyResult:73]; 0)
READ WRITE:C146([TallyResult:73])
