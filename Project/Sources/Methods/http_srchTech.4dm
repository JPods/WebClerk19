//%attributes = {"publishedWeb":true}
//(P) Procedure: http_srchTech
//
READ ONLY:C145([TechNote:58])
C_LONGINT:C283($w; $h; $t; $1; $chapter; $section)
C_TEXT:C284($cat; $ser; $val)
C_POINTER:C301($2)
$techNoteID:=WCapi_GetParameter("techNoteID"; "")
If ($techNoteID="")
	$techNoteID:=WCapi_GetParameter("RecordID"; "")
End if 
$subject:=WCapi_GetParameter("subject"; "")
$author:=WCapi_GetParameter("author"; "")
$chapter:=Num:C11(WCapi_GetParameter("chapter"; ""))
$tableName:=WCapi_GetParameter("TableName"; "")
$form:=WCapi_GetParameter("Form"; "")
$pageName:=WCapi_GetParameter("pagename"; "")
$section:=Num:C11(WCapi_GetParameter("section"; ""))
$title:=WCapi_GetParameter("Title"; "")
$keywords:=WCapi_GetParameter("keyword"; "")
$dateBegin:=WCapi_GetParameter("dateBegin"; "")
$dateEnd:=WCapi_GetParameter("dateEnd"; "")
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
$jitPageError:=WCapi_GetParameter("jitPageError"; "")
//lang:=(WCapi_GetParameter("l";""))
vResponse:=""
If ($keywords="")
	$keyWords:=WCapi_GetParameter("keyWords"; "")
End if 
pvKeyWords:=$keyWords
C_TEXT:C284($keyPairs)
$p:=Position:C15("KeyPairs"; $2->)
If ($p>0)
	//TRACE
	$keyPairs:=HttpKeyPairs($2)
	$keyWords:=$keyWords+("; "*Num:C11($keyWords#""))+$keyPairs
End if 
Case of 
	: (lang="fr")
		$suffix:="_fr"
	: (lang="de")
		$suffix:="_de"
	Else 
		lang:="us"
		$suffix:=""
End case 
REDUCE SELECTION:C351([TechNote:58]; 0)
Case of 
	: ($techNoteID#"")
		QUERY:C277([TechNote:58]; [TechNote:58]idNum:1=$techNoteID; *)
		$testCnt:=1
	: (($chapter#0) | ($section#0))
		$testCnt:=0
		If ($chapter#0)
			QUERY:C277([TechNote:58]; [TechNote:58]chapter:14=$chapter; *)
			$testCnt:=1
		End if 
		If ($section#0)
			If ($testCnt=0)
				QUERY:C277([TechNote:58]; [TechNote:58]section:15=$section; *)
			Else 
				QUERY:C277([TechNote:58];  & [TechNote:58]section:15=$section; *)
			End if 
		End if 
		$testCnt:=1
	Else 
		$testCnt:=0
		C_LONGINT:C283($testCnt)
		If ($author#"")
			If ($testCnt=0)
				QUERY:C277([TechNote:58]; [TechNote:58]author:10=$author+"@"; *)
			Else 
				QUERY:C277([TechNote:58];  | [TechNote:58]author:10=$author+"@"; *)
			End if 
			$testCnt:=$testCnt+1
		End if 
		If ($title#"")
			If ($testCnt=0)
				QUERY:C277([TechNote:58]; [TechNote:58]name:2=$title+"@"; *)
			Else 
				QUERY:C277([TechNote:58];  | [TechNote:58]name:2=$title+"@"; *)
			End if 
			$testCnt:=$testCnt+1
		End if 
		If ($subject#"")
			If ($testCnt=0)
				QUERY:C277([TechNote:58]; [TechNote:58]subject:6=$subject+"@"; *)
			Else 
				QUERY:C277([TechNote:58];  | [TechNote:58]subject:6=$subject+"@"; *)
			End if 
			$testCnt:=$testCnt+1
		End if 
		If ($tableName#"")
			C_LONGINT:C283($tableNum)
			$tableNum:=STR_GetTableNumber($tableName)
			If ($tableNum>0)
				If ($testCnt=0)
					QUERY:C277([TechNote:58]; [TechNote:58]tableNum:12=$tableNum; *)
				Else 
					QUERY:C277([TechNote:58];  | [TechNote:58]tableNum:12=$tableNum; *)
				End if 
				$testCnt:=$testCnt+1
			End if 
		End if 
		
		If ($subject#"")
			If ($testCnt=0)
				QUERY:C277([TechNote:58]; [TechNote:58]subject:6=$subject+"@"; *)
			Else 
				QUERY:C277([TechNote:58];  | [TechNote:58]subject:6=$subject+"@"; *)
			End if 
			$testCnt:=$testCnt+1
		End if 
		
		If ($keyWords#"")
			KeyWordByAlpha(Table:C252(->[TechNote:58]); $keyWords; True:C214)
			$testCnt:=$testCnt+1
		End if 
		
		//
		If ($dateBegin#"")
			If ($testCnt=0)
				QUERY:C277([TechNote:58]; [TechNote:58]datePublished:5>=$dateBegin; *)
			Else 
				QUERY:C277([TechNote:58];  | [TechNote:58]datePublished:5>=$dateBegin; *)
			End if 
			$testCnt:=$testCnt+1
		End if 
		If ($dateEnd#"")
			If ($testCnt=0)
				QUERY:C277([TechNote:58]; [TechNote:58]datePublished:5<=$dateEnd; *)
			Else 
				QUERY:C277([TechNote:58];  & [TechNote:58]datePublished:5<=$dateEnd; *)
			End if 
			$testCnt:=$testCnt+1
		End if 
		Case of 
			: (($dateBegin#"") & ($dateEnd#""))
				If ($testCnt=0)
					QUERY:C277([TechNote:58]; [TechNote:58]datePublished:5>=Date:C102($dateBegin); *)
				Else 
					QUERY:C277([TechNote:58];  & [TechNote:58]datePublished:5>=Date:C102($dateBegin); *)
				End if 
				QUERY:C277([TechNote:58];  & [TechNote:58]datePublished:5<=Date:C102($dateEnd); *)
				$testCnt:=$testCnt+1
			: (($dateBegin#"") & ($dateEnd=""))
				If ($testCnt=0)
					QUERY:C277([TechNote:58]; [TechNote:58]datePublished:5>=Date:C102($dateEnd); *)
				Else 
					QUERY:C277([TechNote:58];  & [TechNote:58]datePublished:5>=Date:C102($dateEnd); *)
				End if 
				$testCnt:=$testCnt+1
			: ($dateEnd#"")  //($dateBegin#"")&
				If ($testCnt=0)
					QUERY:C277([TechNote:58]; [TechNote:58]datePublished:5<=Date:C102($dateEnd); *)
				Else 
					QUERY:C277([TechNote:58];  & [TechNote:58]datePublished:5<=Date:C102($dateEnd); *)
				End if 
				$testCnt:=$testCnt+1
		End case 
End case 
If ($testCnt>0)
	QUERY:C277([TechNote:58];  & [TechNote:58]publish:11>0; *)
	QUERY:C277([TechNote:58];  & [TechNote:58]publish:11<=viEndUserSecurityLevel)
End if 
//
//If (<>viDoHttpLog>10)
//http_SendLog ($1;"/Search_Tech/?subject="+$subject+"&author="+$author+"
//&submitted="+$submitted)
//End if 
//
$num:=Records in selection:C76([TechNote:58])
If (Records in selection:C76([TechNote:58])><>viMaxShow)
	REDUCE SELECTION:C351([TechNote:58]; <>viMaxShow)
	$num:=Records in selection:C76([TechNote:58])
End if 
If (Records in selection:C76([TechNote:58])>1)
	ORDER BY:C49([TechNote:58]; [TechNote:58]name:2)
End if 
Case of 
	: ($num>1)
		$err:=WC_PageSendWithTags($1; WC_DoPage("TechNotesList"+$suffix+".html"; $jitPageList); 0)
		
	: ($num=1)
		C_LONGINT:C283($theArea)
		//**WR PICTURE TO AREA ($theArea;[TechNote]Body_)
		//vText1:=  //**WR Get text ($theArea;0;2000000000)
		$p:=Position:C15("jitWebImage<--"; vText1)
		If ($p>0)
			C_TEXT:C284($buildText; $workText; $imageText)
			$workText:=vText1
			$buildText:=""
			Repeat 
				C_LONGINT:C283($p; $pEnd)
				$p:=Position:C15("jitWebImage<--"; $workText)
				If ($p=0)
					$buildText:=$buildText+$workText
				Else 
					$buildText:=$buildText+Substring:C12($workText; 1; $p-1)
					$workText:=Substring:C12($workText; $p+14)
					$pEnd:=Position:C15("-->"; $workText)
					If ($pEnd=0)
						$buildText:=$buildText+$workText
					Else 
						$imageText:=Substring:C12($workText; 1; $pEnd-1)  //<>WebFolder+"/"+
						$imageText:=Replace string:C233($imageText; "\\"; "/")
						$imageText:=Replace string:C233($imageText; ":"; "/")
						$imageText:=Replace string:C233($imageText; "//"; "/")
						$imageText:="<P><IMG SRC="+Char:C90(34)+$imageText+Char:C90(34)+"><P>"
						$workText:=Substring:C12($workText; $pEnd+3)
						$buildText:=$buildText+$imageText
					End if 
				End if 
			Until (($p=0) | ($pEnd=0))
			vText1:=$buildText
		End if 
		//
		//**WR DELETE OFFSCREEN AREA ($theArea)
		$err:=WC_PageSendWithTags($1; WC_DoPage("TechNotesOne"+$suffix+".html"; $jitPageOne); 0)
		vText1:=""
	Else 
		// Send no records found
		$err:=WC_PageSendWithTags($1; WC_DoPage("Error"+$suffix+".html"; $jitPageError); 0)
End case 
