//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HTTP_ItemKeyword
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//KeyModifierCurrent 
C_LONGINT:C283($w; $h; $t; $1)
C_TEXT:C284($cat; $ser; $val)
C_POINTER:C301($2)
C_DATE:C307($dateBeg; $dateEnd)
C_TEXT:C284(itemDiscounts)
itemDiscounts:=""
C_LONGINT:C283(viEndUserSecurityLevel)
C_TEXT:C284(pvBubbleID; pvDrawingID)
pvBubbleID:=WCapi_GetParameter("BubbleID"; "")
pvDrawingID:=WCapi_GetParameter("DrawingID"; "")
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
$jitSkip:=WCapi_GetParameter("jitSkip"; "")
//
vlBeenHere:=DateTime_DTTo
C_REAL:C285(vValueBonus)
//
//TRACE
vResponse:="No Match"
$thePage:="ErrorBubbles.html"
$testCnt:=0
C_LONGINT:C283($testCnt; $DTitem)
KeywordWebRelated(0)
If ((pvBubbleID#"") & (pvDrawingID#""))
	
	//  example of old method replaced by new
	
	QUERY BY FORMULA:C48([Item:4]; (([Item:4]itemNum:1=[Word:99]relatedAlpha:8) & ([Word:99]wordOnly:3=pvBubbleID) & ([Word:99]reference:6=pvDrawingID) & ([Item:4]retired:64=False:C215) & ([Item:4]publish:60<=viEndUserSecurityLevel-<>vlSecurityBump)))
	UNLOAD RECORD:C212([Word:99])
	
	If (False:C215)
		QUERY:C277([Word:99]; [Word:99]wordOnly:3=pvBubbleID; *)
		QUERY:C277([Word:99];  & [Word:99]reference:6=pvDrawingID)
		If (True:C214)
			QUERY BY FORMULA:C48([Item:4]; (([Item:4]itemNum:1=[Word:99]relatedAlpha:8) & ([Item:4]retired:64=False:C215) & ([Item:4]publish:60<=viEndUserSecurityLevel-<>vlSecurityBump)))
		Else 
			FIRST RECORD:C50([Word:99])
			If (Records in selection:C76([Word:99])>0)
				CREATE EMPTY SET:C140([Item:4]; "Current")
				$k:=Records in selection:C76([Word:99])
				For ($i; 1; $k)
					QUERY:C277([Item:4]; [Item:4]itemNum:1=[Word:99]relatedAlpha:8; *)
					QUERY:C277([Item:4];  & [Item:4]retired:64=False:C215; *)
					QUERY:C277([Item:4];  & [Item:4]publish:60<=viEndUserSecurityLevel-<>vlSecurityBump)
					If (Records in selection:C76([Item:4])=1)
						ADD TO SET:C119([Item:4]; "Current")
						KeywordWebRelated(Table:C252(->[Word:99]); Record number:C243([Word:99]); Record number:C243([Item:4]); [Word:99]reference:6+" ("+[Word:99]wordOnly:3+")")
					End if 
					NEXT RECORD:C51([Word:99])
				End for 
				USE SET:C118("Current")
				CLEAR SET:C117("Current")
				FIRST RECORD:C50([Word:99])
			End if 
		End if 
	End if 
End if 
$num:=Records in selection:C76([Item:4])
Case of 
	: ($num>1)
		$thePage:=WC_DoPage("ItemsList.html"; $jitPageList)
	: ($num=1)
		If ([Item:4]useQtyPriceBrks:6>0)
			Http_ItemPriceBreaks
		End if 
		ItemKeyPathVariables
		$thePage:=WC_DoPage("ItemsOne"+[Item:4]webPage:58+".html"; $jitPageOne)
	Else 
		C_TEXT:C284(pvBubbleID; pvDrawingID)
		$thePage:=WC_DoPage("ErrorBubbles.html"; "")
End case 
$err:=WC_PageSendWithTags($1; $thePage; 0)
pvBubbleID:=""
pvDrawingID:=""
