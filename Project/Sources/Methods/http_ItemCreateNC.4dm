//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:=""
$mfgItemNum:=WCapi_GetParameter("nc_itemNum"; "")
$mfgID:=WCapi_GetParameter("nc_Publisher"; "")
$nc_URLArticle:=WCapi_GetParameter("nc_URLArticle"; "")
//
$jitPageList:=WCapi_GetParameter("nc_PageList"; "")
$jitPageOne:=WCapi_GetParameter("nc_PageOne"; "")
$jitSkip:=WCapi_GetParameter("jitSkip"; "")
//
If ($jitPageOne="")
	$jitPageOne:="NC_OrderItem.html"
End if 

QUERY:C277([Item:4]; [Item:4]mfrID:53=$mfgID; *)
QUERY:C277([Item:4];  & [Item:4]mfrItemNum:39=$mfgItemNum)
If (Records in selection:C76([Item:4])=0)
	CREATE RECORD:C68([Item:4])
	[Item:4]itemNum:1:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Item:4]))
	QtySaleDefault:=1
	TRACE:C157
	If ($itemDesc#"")
		[Item:4]description:7:=$itemDesc
	Else 
		[Item:4]description:7:=$nc_URL
	End if 
End if 
If ($nc_URLArticle#"")
	
	http_NC_GetArticle($nc_URLArticle; $2)
End if 
//TRACE
ARRAY TEXT:C222(aText1; 0)
//
If (Is new record:C668([Item:4]))
	
	TRACE:C157
	//only do this on new entries
	$itemDesc:=WCapi_GetParameter("nc_Title"; "")
	$nc_Publication:=WCapi_GetParameter("nc_Publication"; "")
	$ItemsProfile1:=WCapi_GetParameter("nc_Section"; "")
	$nc_ByLine:=WCapi_GetParameter("nc_ByLine"; "")
	$nc_Title:=WCapi_GetParameter("nc_Title"; "")
	$nc_Market:=WCapi_GetParameter("nc_Market"; "")
	$nc_Date:=WCapi_GetParameter("nc_Date"; "")
	$publevel:=WCapi_GetParameter("nc_publish"; "")
	$nc_copyrightGen:=WCapi_GetParameter("nc_copyrightGen"; "")
	$itemType:=WCapi_GetParameter("nc_itemType"; "")
	$nc_PR_Contacts:=WCapi_GetParameter("nc_PRContacts"; "")
	$nc_Keywords:=WCapi_GetParameter("nc_Keywords"; "")
	$nc_PriceTable:=WCapi_GetParameter("nc_PriceTable"; "")
	$nc_QandA:=WCapi_GetParameter("nc_QandA"; "")
	$ItemsProfile4:=WCapi_GetParameter("nc_WebTemplate"; "")
	$ItemsProfile3:=WCapi_GetParameter("nc_PrintTemplate"; "")
	$nc_URLOnLine:=WCapi_GetParameter("nc_URLOnLine"; "")
	$publevel:=WCapi_GetParameter("nc_URLControl"; "")
	$nc_URLAdminSales:=WCapi_GetParameter("nc_URLAdminSales"; "")
	$nc_URLStyle:=WCapi_GetParameter("nc_URLStyle"; "")
	$nc_URLOrigin:=WCapi_GetParameter("nc_URLOrigin"; "")
	$nc_URLDisplay:=WCapi_GetParameter("nc_URLWebRes"; "")
	$nc_URLHighRes:=WCapi_GetParameter("nc_URLHighRes"; "")
	//
	
	If ($jitPageOne#"")
		[Item:4]webPage:58:=$jitPageOne
		//$jitPageOne:="Item"+[Item]WebPageNum+"One.html"
	End if 
	[Item:4]tallyByType:19:=True:C214
	[Item:4]unitOfMeasure:11:="NC_Copyright"
	[Item:4]commissionA:29:=100
	[Item:4]commissionB:30:=100
	[Item:4]commissionC:31:=100
	[Item:4]commissionD:32:=100
	[Item:4]discountable:28:=True:C214
	[Item:4]taxID:17:="Print"
	[Item:4]salesGlAccount:21:="1"
	[Item:4]costGLAccount:22:="2"
	[Item:4]inventoryGlAccount:23:="3"
	[Item:4]mfrID:53:=$mfgID
	[Item:4]mfrItemNum:39:=$mfgItemNum
	[Item:4]path:61:=theDocumentURL
	[Item:4]type:26:=$itemType
	[Item:4]profile1:35:=$ItemsProfile1
	[Item:4]profile2:36:=$ItemsProfile2
	[Item:4]profile3:37:=$ItemsProfile3
	[Item:4]profile4:38:=$ItemsProfile4
	[Item:4]priceA:2:=0.5
	[Item:4]priceB:3:=0.4
	[Item:4]priceC:4:=0.3
	[Item:4]priceD:5:=0.2
	[Item:4]liComment:66:="URL_Local:  "+theDocumentURL+"\r"+"URL_Publisher: "+$nc_URL
	If ($publevel="")
		[Item:4]publish:60:=1
	Else 
		[Item:4]publish:60:=Num:C11($publevel)
	End if 
	SAVE RECORD:C53([Item:4])
End if 

$err:=WC_PageSendWithTags($1; WC_DoPage($jitPageOne; ""); 0)
vText1:=""
ARRAY TEXT:C222(aText1; 0)
theDocumentURL:=""
WC_SiteInsert:=""
