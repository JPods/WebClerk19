//%attributes = {"publishedWeb":true}
//Method: Http_SrchLibraries
If (False:C215)
	//Date: 02/27/02
	//Who: Bill James, JIT
	//Description:
	VERSION_960
End if 
//
READ ONLY:C145([TallyResult:73])
C_LONGINT:C283($w; $h; $t; $1; $thisLibrary)
C_TEXT:C284($cat; $ser; $val)
C_POINTER:C301($2)
$recNum:=WCapi_GetParameter("RecordID"; "")
If ($recNum="")
	$recNum:=WCapi_GetParameter("RecNum"; "")
End if 
$subject:=WCapi_GetParameter("subject"; "")
$keyword:=WCapi_GetParameter("Keyword"; "")
$who:=WCapi_GetParameter("who"; "")
$topic:=WCapi_GetParameter("topic"; "")
$name:=WCapi_GetParameter("name"; "")
$purpose:=WCapi_GetParameter("purpose"; "")
$dateBegin:=WCapi_GetParameter("dateBegin"; "")
$dateEnd:=WCapi_GetParameter("dateEnd"; "")
vResponse:="No records available"
$doPage:=WC_DoPage("error.html"; "")
//zttp_UserGet 
Case of 
	: ((voState.url="/webClerk1@") | (voState.url="/Library1@"))
		$thisLibrary:=1
	: ((voState.url="/webClerk2@") | (voState.url="/Library2@"))
		$thisLibrary:=2
	Else 
		$thisLibrary:=0
End case 
//lang:=(WCapi_GetParameter("l";""))
//
//
REDUCE SELECTION:C351([TallyResult:73]; 0)
If ($recNum#"")
	QUERY:C277([TallyResult:73]; [TallyResult:73]idNum:35=Num:C11($recNum); *)
	$testCnt:=1
Else 
	$testCnt:=0
	C_LONGINT:C283($testCnt)
	If ($who#"")
		If ($testCnt=0)
			QUERY:C277([TallyResult:73]; [TallyResult:73]profile1:17=$who+"@"; *)
		Else 
			QUERY:C277([TallyResult:73];  | [TallyResult:73]profile1:17=$who+"@"; *)
		End if 
		$testCnt:=$testCnt+1
	End if 
	If ($name#"")
		If ($testCnt=0)
			QUERY:C277([TallyResult:73]; [TallyResult:73]name:1=$name+"@"; *)
		Else 
			QUERY:C277([TallyResult:73];  | [TallyResult:73]name:1=$name+"@"; *)
		End if 
		$testCnt:=$testCnt+1
	End if 
	If ($keyword#"")
		//If ($testCnt=0)
		// QUERY([TallyResult];[TallyResult]Keywords'Keyword=$keyword+"@";*)
		// Else 
		// QUERY([TallyResult];|[TallyResult]Keywords'Keyword=$keyword+"@";*)
		// End if 
		
		//: ($keyWord#"")
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
			If ($cycleCnt=0)
				QUERY:C277([TallyResult:73]; [TallyResult:73]keyTags:54%$testWord+"@"; *)
			End if 
			$cycleCnt:=1
		Until ($p=0)
		$testCnt:=$testCnt+1
		
		
	End if 
	If ($topic#"")
		If ($testCnt=0)
			QUERY:C277([TallyResult:73]; [TallyResult:73]profile2:18=$topic+"@"; *)
		Else 
			QUERY:C277([TallyResult:73];  | [TallyResult:73]profile2:18=$topic+"@"; *)
		End if 
		$testCnt:=$testCnt+1
	End if 
	If ($subject#"")
		If ($testCnt=0)
			QUERY:C277([TallyResult:73]; [TallyResult:73]profile3:19=$subject+"@"; *)
		Else 
			QUERY:C277([TallyResult:73];  | [TallyResult:73]profile3:19=$subject+"@"; *)
		End if 
		$testCnt:=$testCnt+1
	End if 
	
	Case of 
		: (($dateBegin#"") & ($dateEnd#""))
			If ($testCnt=0)
				QUERY:C277([TallyResult:73]; [TallyResult:73]dtCreated:11>=DateTime_Enter(Date:C102($dateBegin); ?00:00:00?); *)
			Else 
				QUERY:C277([TallyResult:73];  & [TallyResult:73]dtCreated:11>=DateTime_Enter(Date:C102($dateBegin); ?00:00:00?); *)
			End if 
			QUERY:C277([TallyResult:73];  & [TallyResult:73]dtCreated:11<=DateTime_Enter(Date:C102($dateEnd); ?23:59:59?); *)
			$testCnt:=$testCnt+1
		: (($dateBegin#"") & ($dateEnd=""))
			If ($testCnt=0)
				QUERY:C277([TallyResult:73]; [TallyResult:73]dtCreated:11>=DateTime_Enter(Date:C102($dateBegin); ?00:00:00?); *)
			Else 
				QUERY:C277([TallyResult:73];  & [TallyResult:73]dtCreated:11>=DateTime_Enter(Date:C102($dateBegin); ?00:00:00?); *)
			End if 
			$testCnt:=$testCnt+1
		: ($dateEnd#"")
			If ($testCnt=0)
				QUERY:C277([TallyResult:73]; [TallyResult:73]dtCreated:11<=DateTime_Enter(Date:C102($dateEnd); ?23:59:59?); *)
			Else 
				QUERY:C277([TallyResult:73];  & [TallyResult:73]dtCreated:11<=DateTime_Enter(Date:C102($dateEnd); ?23:59:59?); *)
			End if 
			$testCnt:=$testCnt+1
	End case 
End if 
If ($testCnt>0)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]publish:36>0; *)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]publish:36<=viEndUserSecurityLevel; *)
	Case of 
		: ($thisLibrary=1)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="webClerk1@"; *)
		: ($thisLibrary=2)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="webClerk2@"; *)
		Else 
			If ($purpose#"")
				QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2=$purpose+"@"; *)
			End if 
	End case 
	QUERY:C277([TallyResult:73])
End if 
$num:=Records in selection:C76([TallyResult:73])
//If (<>viDoHttpLog>10)
//http_SendLog ($1;"/Search_Library?subject="+$subject+"&who="+$who+"
//&submitted="+$submitted+"//"+String($num))
//End if 
If (Records in selection:C76([TallyResult:73])><>viMaxShow)
	REDUCE SELECTION:C351([TallyResult:73]; <>viMaxShow)
	$num:=Records in selection:C76([TallyResult:73])
End if 
If (Records in selection:C76([TallyResult:73])>1)
	ORDER BY:C49([TallyResult:73]; [TallyResult:73]profile2:18)
End if 
//
Case of 
	: ($num>1)
		$jitPageList:=WCapi_GetParameter("jitPageList"; "")
		$doPage:=WC_DoPage("LibraryList.html"; $jitPageList)
	: ($num=1)
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		QUERY:C277([Document:100]; [Document:100]copyrightPath:15=73; *)  //[TallyResult]    
		QUERY:C277([Document:100];  & [Document:100]launchApplication:14=String:C10([TallyResult:73]idNum:35); *)
		QUERY:C277([Document:100];  & [Document:100]pathTN:5>0; *)
		QUERY:C277([Document:100];  & [Document:100]pathTN:5<=viEndUserSecurityLevel)
		
		$pageSuffix:=""
		C_TEXT:C284($pageSuffix)
		$pageSuffix:=String:C10([TallyResult:73]webPage:51)*Num:C11([TallyResult:73]webPage:51#0)
		
		$doPage:=WC_DoPage("LibrayOne.html"; $jitPageOne)
		
	Else 
		$jitPageError:=WCapi_GetParameter("jitPageError"; "")
		$doPage:=WC_DoPage("error.html"; $jitPageError)
End case 
READ WRITE:C146([TallyResult:73])
$err:=WC_PageSendWithTags($1; $doPage; 0)