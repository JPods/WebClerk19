//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: http_NC_GetArticle
End if 
C_TEXT:C284($1; $doc; $crlf; $machine; $m; $theText; $temp; $theText)
C_TEXT:C284(WC_SiteInsert)
C_BOOLEAN:C305($doParameters)
C_LONGINT:C283($stream; $s; $err)
C_POINTER:C301($2; $ptMainURL)
$doParameters:=(Count parameters:C259=2)

NTK_SetURL($1)  //this is a good procedure for parsing a complete URL.  Set each variable here.

//HTTP_TimeOut:=10//seconds
//HTTP_Protocol:="https"//process as SSL
//HTTP_Path:=<>tcCCVerURL//Server command
//HTTP_Host:=<>tcCCVerHost//Server manchine
//HTTP_Port:=<>tcCCVerPort//the Port

C_BLOB:C604(HTTP_IncomingBlob)
$error:=WC_Request("POST")

C_LONGINT:C283($vOffSet)
ARRAY TEXT:C222($arrayText; 0)
$vOffSet:=0
If (BLOB size:C605(HTTP_IncomingBlob)>0)
	Repeat 
		$clipText:=BLOB to text:C555(HTTP_IncomingBlob; $vOffSet; 32000)  //$vOffSet automatically increments
		APPEND TO ARRAY:C911($arrayText; $clipText)
	Until ($vOffSet>=$bytesReceived)
End if 
$vOffSet:=0
iLoText1:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)

SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)

If (Size of array:C274($arrayText)>0)
	
	$ncEndClipMore:=0
	$ncBegin:=WCapi_GetParameter("nc_DisplayBegin"; "")  //should $2 be changed to ->iLoText1
	$ncEnd:=WCapi_GetParameter("nc_DisplayEnd"; "")
	$mfgID:=WCapi_GetParameter("nc_Publisher"; "")
	$jitPageOne:=WCapi_GetParameter("nc_PageOne"; "")
	If (($ncBegin#"") & ($ncEnd#""))
		//no action      
	Else 
		QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="NC_Publisher"; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1=$mfgID)
		If (Records in selection:C76([TallyResult:73])=1)
			//$ncBegin:="<!-- TMC1.ZZZ END -->"
			//$ncEnd:="<!-- TMC2.ZZZ BEGIN -->"
			$ncBegin:=[TallyResult:73]textBlk1:5
			$ncEnd:=[TallyResult:73]textBlk2:6
			C_LONGINT:C283($ncEndClipMore)
			$ncEndClipMore:=[TallyResult:73]longint1:7
		Else 
			$ncBegin:="<Body"
			$ncEnd:="</Body>"
		End if 
		
	End if 
	TRACE:C157
	$theText:=""
	
	C_BOOLEAN:C305($doBegin; $doEnd)
	$doBegin:=True:C214
	$doEnd:=True:C214
	C_LONGINT:C283($p; $failSafe)
	$failSafe:=0
	$theText:=$theText+$arrayText{1}
	DELETE FROM ARRAY:C228($arrayText; 1; 1)
	$cntElements:=$cntElements-1
	Repeat 
		$failSafe:=$failSafe+1
		If ($doBegin)
			$p:=Position:C15($ncBegin; $theText)
			If ($p>0)
				$doBegin:=False:C215
				$theText:=Substring:C12($theText; $p+Length:C16($ncBegin))
				If ($ncBegin="<Body")
					$p:=Position:C15(">"; $theText)
					If ($p>0)
						$theText:=Substring:C12($theText; $p+1)
					End if 
				End if 
			Else 
				If (Length:C16($theText)>6000)
					$theText:=Substring:C12($theText; 2000)
				End if 
			End if 
		End if 
		If ((Length:C16($theText)<21000) & ($cntElements>0))
			$theText:=$theText+$arrayText{1}
			DELETE FROM ARRAY:C228($arrayText; 1; 1)
			$cntElements:=$cntElements-1
		Else 
			C_LONGINT:C283($w; $clipped)
			$w:=Size of array:C274(aText1)+1
			INSERT IN ARRAY:C227(aText1; $w)
			$clipped:=Length:C16($theText)-30
			aText1{$w}:=Substring:C12($theText; 1; $clipped)
			$theText:=Substring:C12($theText; $clipped-1)
		End if 
		$p:=Position:C15($ncEnd; $theText)
		If ($p>0)
			$myTest:=""
			$theText:=Substring:C12($theText; 1; $p-1-$ncEndClipMore)
		End if 
	Until (($cntElements=0) | ($failSafe>30))
	vText1:=""
	If (Size of array:C274(aText1)>0)
		$w:=Size of array:C274(aText1)
		For ($i; 1; $w)
			vText1:=vText1+aText1{$i}
		End for 
		vText1:=vText1+$theText
	Else 
		vText1:=$theText  //Substring($theText;1;400)      
	End if 
	//
	WC_SiteInsert:=vText1
	//
	C_TEXT:C284($theDocName)
	C_TEXT:C284(theDocumentURL)
	If ($mfgID="")
		$mfgID:="UKNPub"
	End if 
	$theFullPath:=<>WebFolder+"jitArticles"+Folder separator:K24:12+$mfgID+Folder separator:K24:12
	If (HFS_Exists($theFullPath)=0)
		$error:=New_Folder($theFullPath)
	End if 
	$theFullPath:=$theFullPath+String:C10(Year of:C25(Current date:C33))+"_"+String:C10(Month of:C24(Current date:C33))+Folder separator:K24:12
	If (HFS_Exists($theFullPath)=0)
		$error:=New_Folder($theFullPath)
	End if 
	theDocumentURL:="jitArticles"+Folder separator:K24:12+$mfgID+Folder separator:K24:12+String:C10(Year of:C25(Current date:C33))+"_"+String:C10(Month of:C24(Current date:C33))+Folder separator:K24:12+[Item:4]itemNum:1+".html"
	$theFullPathDoc:=$theFullPath+[Item:4]itemNum:1+".html"
	If (HFS_Exists($theFullPathDoc)=0)
		Txt_4D2Doc(<>WebFolder+"jitArticles"+Folder separator:K24:12+"NC_Template.html"; ""; False:C215)
		$theDocName:=HFS_ShortName(document)
		$err:=HFS_Move(document; $theFullPath)
		$theFullPath:=$theFullPath+$theDocName
		$err:=HFS_Rename($theFullPath; [Item:4]itemNum:1+".html")
		myDoc:=Open document:C264($theFullPathDoc)
		CLOSE DOCUMENT:C267(myDoc)
		App_SetSuffix(".html")
	End if 
	KeyModifierCurrent
	If (OptKey=1)
		SET TEXT TO PASTEBOARD:C523($theText)
	End if 
	If ($doParameters)
		$k:=27
		ARRAY TEXT:C222($atextLabels; $k)
		ARRAY TEXT:C222(aText1; $k)
		$atextLabels{1}:="nc_itemNum"
		$atextLabels{2}:="nc_Title"
		$atextLabels{3}:="nc_BuyDisplay"
		$atextLabels{4}:="nc_Publisher"
		$atextLabels{5}:="nc_Publication"
		$atextLabels{6}:="nc_Section"
		$atextLabels{7}:="nc_ByLine"
		$atextLabels{8}:="nc_Title"
		$atextLabels{9}:="nc_Market"
		$atextLabels{10}:="nc_Date"
		$atextLabels{11}:="nc_publish"
		$atextLabels{12}:="nc_copyrightGen"
		$atextLabels{13}:="nc_itemType"
		$atextLabels{14}:="nc_PRContacts"
		$atextLabels{15}:="nc_Keywords"
		$atextLabels{16}:="nc_PriceTable"
		$atextLabels{17}:="nc_QandA"
		$atextLabels{18}:="nc_WebTemplate"
		$atextLabels{19}:="nc_PrintTemplate"
		$atextLabels{20}:="nc_URLArticle"
		$atextLabels{21}:="nc_URLOnLine"
		$atextLabels{22}:="nc_URLControl"
		$atextLabels{23}:="nc_URLAdminSales"
		$atextLabels{24}:="nc_URLStyle"
		$atextLabels{25}:="nc_URLOrigin"
		$atextLabels{26}:="nc_URLWebRes"
		$atextLabels{27}:="nc_URLHighRes"
		//
		C_LONGINT:C283($stream; $k; $pBegin; $pEnd; $len)  //add a feature to do 'class='
		C_TEXT:C284($begStr; $endStr)
		For ($i; 1; $k)
			$begStr:="<!--"+$atextLabels{$i}+"-->"
			$endStr:="<!--/"+$atextLabels{$i}+"-->"
			$pBegin:=Position:C15($begStr; $theText)
			$pEnd:=Position:C15($endStr; $theText)
			If (($pBegin>0) & ($pEnd>0))
				$pBegin:=$pBegin+Length:C16($begStr)
				aText1{$i}:=Substring:C12($theText; $pBegin; ($pEnd-$pBegin-1))
			End if 
		End for 
	End if 
End if 