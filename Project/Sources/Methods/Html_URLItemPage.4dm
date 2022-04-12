//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Html_URLItemPage 
	//Date: 07/01/02
	//Who: Bill
	//Description: Make URLs for Item searches
End if 
TRACE:C157
If (curTableNum#4)
	ALERT:C41("This feature only works with Items Table selected.  ")
Else 
	CONFIRM:C162("Draft Item Catagory Page?")
	If (OK=1)
		TRACE:C157
		ARRAY TEXT:C222(aiLoText2; 1)
		//myDocName:=""
		//$myOK:=EI_CreateDoc (->myDocName;->myDoc;"")
		//If ($myOK=1)
		$makeSearch:="SkipSearch"
		$theFont:=""  //<FONT FACE="+"\""+"Arial"+"\""+" SIZE="+"\""+"1"+"\""+">"
		$endFont:=""  //</FONT>"
		C_LONGINT:C283($theBreaks)
		$theBreaks:=Num:C11(Request:C163("Enter number of columns."; "5"))
		//    
		C_LONGINT:C283($incRay; cntRay)
		cntRay:=Size of array:C274(aFieldLns)
		For ($incRay; 1; cntRay)
			If (theFldNum{aFieldLns{$incRay}}=53)
				QUERY:C277([Item:4]; [Item:4]publish:60>0)
				HTML_Distinct(->[Item:4]mfrID:53; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
				aiLoText2{1}:=$theFont+"mfrID"+Html_UrlFill(->aText1; "/item_List?mfgID="; $theBreaks)
			End if 
			//    
			If (theFldNum{aFieldLns{$incRay}}=45)
				QUERY:C277([Item:4]; [Item:4]publish:60>0)
				HTML_Distinct(->[Item:4]vendorID:45; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
				aiLoText2{1}:=$theFont+"Vendor ID"+Html_UrlFill(->aText1; "/item_List?VendorID="; $theBreaks)
			End if 
			//    
			If (theFldNum{aFieldLns{$incRay}}=26)
				QUERY:C277([Item:4]; [Item:4]publish:60>0)
				HTML_Distinct(->[Item:4]type:26; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
				aiLoText2{1}:=$theFont+"typeIDID"+Html_UrlFill(->aText1; "/item_List?typeID="; $theBreaks)
			End if 
			//
			If (theFldNum{aFieldLns{$incRay}}=35)
				$k:=Size of array:C274(<>aItemsType)
				For ($i; 1; $k)
					QUERY:C277([Item:4]; [Item:4]publish:60>0; *)
					QUERY:C277([Item:4];  & [Item:4]type:26=<>aItemsType{$i})
					If (Records in selection:C76([Item:4])>0)
						$w:=Size of array:C274(aiLoText2)+1
						INSERT IN ARRAY:C227(aiLoText2; $w; 1)
						HTML_Distinct(->[Item:4]profile1:35; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
						aiLoText2{$w}:=$theFont+"Profile 1 for: "+<>aItemsType{$i}+Html_UrlFill(->aText1; "/item_Narrow&typeID="+<>aItemsType{$i}+"&Profile1="; $theBreaks)
					End if 
				End for 
			End if 
			//
			If (theFldNum{aFieldLns{$incRay}}=36)
				$k:=Size of array:C274(<>aItemsType)
				For ($i; 1; $k)
					QUERY:C277([Item:4]; [Item:4]publish:60>0; *)
					QUERY:C277([Item:4];  & [Item:4]type:26=<>aItemsType{$i})
					If (Records in selection:C76([Item:4])>0)
						$w:=Size of array:C274(aiLoText2)+1
						INSERT IN ARRAY:C227(aiLoText2; $w; 1)
						HTML_Distinct(->[Item:4]profile2:36; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
						aiLoText2{$w}:=$theFont+"Profile 2 for: "+<>aItemsType{$i}+Html_UrlFill(->aText1; "/item_Narrow&typeID="+<>aItemsType{$i}+"&Profile2="; $theBreaks)
					End if 
				End for 
			End if 
			//
			If (theFldNum{aFieldLns{$incRay}}=37)
				$k:=Size of array:C274(<>aItemsType)
				For ($i; 1; $k)
					QUERY:C277([Item:4]; [Item:4]publish:60>0; *)
					QUERY:C277([Item:4];  & [Item:4]type:26=<>aItemsType{$i})
					If (Records in selection:C76([Item:4])>0)
						$w:=Size of array:C274(aiLoText2)+1
						INSERT IN ARRAY:C227(aiLoText2; $w; 1)
						HTML_Distinct(->[Item:4]profile3:37; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
						aiLoText2{$w}:=$theFont+"Profile 3 for: "+<>aItemsType{$i}+Html_UrlFill(->aText1; "/item_Narrow?typeID="+<>aItemsType{$i}+"&Profile3="; $theBreaks)
					End if 
				End for 
			End if 
			//
			If (theFldNum{aFieldLns{$incRay}}=38)
				$k:=Size of array:C274(<>aItemsType)
				For ($i; 1; $k)
					QUERY:C277([Item:4]; [Item:4]publish:60>0; *)
					QUERY:C277([Item:4];  & [Item:4]type:26=<>aItemsType{$i})
					If (Records in selection:C76([Item:4])>0)
						$w:=Size of array:C274(aiLoText2)+1
						INSERT IN ARRAY:C227(aiLoText2; $w; 1)
						HTML_Distinct(->[Item:4]profile4:38; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
						aiLoText2{$w}:=$theFont+"Profile 4 for: "+<>aItemsType{$i}+Html_UrlFill(->aText1; "/item_Narrow&typeID="+<>aItemsType{$i}+"&Profile4="; $theBreaks)
					End if 
				End for 
			End if 
		End for 
		//      
		
		//      
		$selectText:=""
		$k:=Size of array:C274(aiLoText2)
		For ($i; 1; $k)
			$selectText:=$selectText+aiLoText2{$i}+"\r"+"\r"+"<P>"+"\r"  // ### jwm ### 20151130_1200 check this
		End for 
		
		Case of 
			: (is4DWriteUser=3)
				//**WR INSERT TEXT (eLetterArea;$selectText)
			Else 
				vTextSummary:=$selectText+"\r"+"\r"+vTextSummary
				//SET TEXT TO CLIPBOARD($selectList)
		End case 
		
		
	End if 
End if 
ARRAY TEXT:C222(aiLoText2; 0)