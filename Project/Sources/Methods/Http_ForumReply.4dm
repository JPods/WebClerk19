//%attributes = {"publishedWeb":true}
//Procedure: Http_ForumReply
C_LONGINT:C283($1; $spaceCnter; $splitLen; $pOld; $p)
C_TEXT:C284($suffix; $uniqueID; $remainder; $testStr)
C_POINTER:C301($2)
$splitLen:=77
vResponse:="You are not registered or you have not signed in yet."
//TRACE
If ([EventLog:75]remoteUserRec:10>-1)
	If (voState.url="/Forum_Add@")  //Forum    
		//zttp_UserGet 
		If (Record number:C243([RemoteUser:57])>-1)
			Http_PostGen($1; $2; ->[Forum:80]; "Forum")
		Else 
			vResponse:="You are not registered or you have not signed in yet."
			$err:=WC_PageSendWithTags($1; WC_DoPage("Error"+$suffix+".html"; ""); 0)
		End if 
	Else 
		$recNum:=WCapi_GetParameter("RecordID"; "")
		QUERY:C277([Forum:80]; [Forum:80]idNum:8=Num:C11($recNum))
		vTextAsIs1:=Char:C90(10)+Char:C90(10)
		//$tempText:=[Forum]Body
		//$tempText:=Replace string([Forum]Body;">";".>")
		$tempText:=Replace string:C233([Forum:80]body:5; "\r"; Char:C90(28))
		Repeat 
			$buildStr:=""
			$p:=Position:C15(Char:C90(10); $tempText)
			Case of 
				: (($p#0) & ($p<$splitLen))
					vTextAsIs1:=vTextAsIs1+Char:C90(10)+">"+Substring:C12($tempText; 1; $p-1)
					$tempText:=Substring:C12($tempText; $p+1)
				Else 
					$testStr:=Substring:C12($tempText; 1; $splitLen)
					$spaceCnter:=Length:C16($testStr)
					$foundSpace:=0
					While (($spaceCnter>47) & ($foundSpace=0))
						If (($testStr[[$spaceCnter]]<"0") | (Character code:C91($testStr[[$spaceCnter]])>122) | (($testStr[[$spaceCnter]]>"9") & ($testStr[[$spaceCnter]]<"@")))
							$foundSpace:=$spaceCnter
						End if 
						$spaceCnter:=$spaceCnter-1
					End while 
					If ($foundSpace=0)
						$foundSpace:=$splitLen
						$spaceCnter:=$splitLen+1
					Else 
						$spaceCnter:=$foundSpace+1
					End if 
					vTextAsIs1:=vTextAsIs1+Char:C90(10)+">"+Substring:C12($tempText; 1; $foundSpace)
					$tempText:=Substring:C12($tempText; $spaceCnter)
			End case 
		Until (Length:C16($tempText)=0)
		vTextAsIs1:=Replace string:C233(vTextAsIs1; Char:C90(28); "\r")
		$err:=WC_PageSendWithTags($1; WC_DoPage("ForumReply"+$suffix+".html"; ""); 0)
	End if 
Else 
	$err:=WC_PageSendWithTags($1; WC_DoPage("Error"+$suffix+".html"; ""); 0)
End if 
