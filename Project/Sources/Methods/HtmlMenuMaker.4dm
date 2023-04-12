//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HtmlMenuMaker
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//
$lineMechanism:=0
Case of 
	: (Count parameters:C259=0)
		$doConfirm:=True:C214
	: (Count parameters:C259=1)
		$doConfirm:=($1=1)
		OK:=1
	Else 
		$doConfirm:=($1=1)
		OK:=1
		$lineMechanism:=$2
End case 
If ($doConfirm)
	CONFIRM:C162("Create menu html pages for "+String:C10(Records in selection:C76([Item:4]))+" Items?")
End if 
If (OK=1)
	ARRAY TEXT:C222($aBaseCat; 0)
	ARRAY LONGINT:C221($aSeqCat; 0)
	DISTINCT VALUES:C339([Item:4]type:26; $aBaseCat)
	C_TEXT:C284($description; $masterPage)
	$kCat:=Size of array:C274($aBaseCat)
	$headerText:=""
	$masterpage:=""
	
	$headerText:=HTMLPageHeadMake("MenuTemplate.txt")
	//If (HFS_Exists (Storage.folder.jitPrefPath+"MenuTemplate.txt")=1)
	//sumDoc:=Open document(Storage.folder.jitPrefPath+"MenuTemplate.txt")
	//If (OK=1)
	//RECEIVE PACKET(sumDoc;$headerText;<>vEoF)
	//CLOSE DOCUMENT(sumDoc)
	//End if 
	//Else 
	//$headerText:="<HTML>"+"\r"+"<HEAD>"+"\r"+"_jit_-3_standardHead.txtjj"
	//+"\r"+"</HEAD>"+"\r"+"<BODY class="+Txt_Quoted ("MenuBody")+">"+"\r"+"_jit_
	//-3_standardBody.txtjj"+"\r"
	//End if 
	$masterpage:=$headerText
	If (Position:C15("<Form"; $headerText)<1)
		If ($lineMechanism=1)
			$headerText:=$headerText+"<FORM action="+Txt_Quoted("/order_items2")+" method="+Txt_Quoted("Get")+">"+"\r"
			//declare page only if you want to see only the summary of an order
			//$headerText:=$headerText+"<input type="+Txt_Quoted ("hidden")+" NAME
			//="+Txt_Quoted ("jitPageOne")+" VALUE="+Txt_Quoted ("OrderByLine.html")+">"
			//+"\r"
		Else 
			$headerText:=$headerText+"<FORM action="+Txt_Quoted("/order_items")+" method="+Txt_Quoted("Get")+">"+"\r"
			//declare page only if you want to see only the summary of an order
			//$headerText:=$headerText+"<input type="+Txt_Quoted ("hidden")+" NAME
			//="+Txt_Quoted ("jitPageOne")+" VALUE="+Txt_Quoted ("Order.html")+">"+"\r"
		End if 
		$headerText:=$headerText+"<INPUT TYPE="+Txt_Quoted("hidden")+" NAME="+Txt_Quoted("beenHere")+" VALUE="+Txt_Quoted("_jit_0_vlBeenHerejj")+">"+"\r"
		$headerText:=$headerText+"<input type="+Txt_Quoted("hidden")+" NAME="+Txt_Quoted("jitSort")+" VALUE="+Txt_Quoted("4_7_1jj")+">"+"\r"
	End if 
	ARRAY TEXT:C222($aMasterList; $kCat)
	ARRAY LONGINT:C221($aMasterSeq; $kCat)
	//
	For ($catInc; 1; $kCat)
		MESSAGE:C88("Processing "+String:C10($catInc)+":  "+$aBaseCat{$catInc})
		C_LONGINT:C283($pageCnt; $0; $pageInc)
		$pageCnt:=$pageCnt+1
		//
		
		$theName:=Substring:C12($aBaseCat{$catInc}; 1; 20)
		$thisPage:=Replace string:C233($theName; " "; "")
		$thisPage:=Replace string:C233($thisPage; ":"; "")
		$thisPage:=Replace string:C233($thisPage; "\\"; "")
		$thisPage:=Replace string:C233($thisPage; "/"; "")
		$thisPage:=Replace string:C233($thisPage; ","; "")
		$thisPage:="ItMn"+$thisPage+".html"
		$thisPagePath:=Storage:C1525.wc.webFolder+$thisPage
		If (HFS_Exists($thisPagePath)=1)
			$err:=HFS_Delete($thisPagePath)
		End if 
		//OK:=1
		myDoc:=Create document:C266($thisPagePath)
		If (OK=1)
			QUERY:C277([Item:4]; [Item:4]type:26=$aBaseCat{$catInc}; *)
			QUERY:C277([Item:4];  & [Item:4]class:92="menu"; *)
			QUERY:C277([Item:4];  & [Item:4]publish:60>0; *)
			QUERY:C277([Item:4];  & [Item:4]retired:64=False:C215)
			//
			ORDER BY:C49([Item:4]; [Item:4]indicator1:95; [Item:4]indicator2:96)
			ARRAY TEXT:C222($aItemNum; 0)
			ARRAY TEXT:C222($atypeID; 0)
			ARRAY TEXT:C222($aItemDescript; 0)
			ARRAY TEXT:C222($aUoM; 0)
			ARRAY TEXT:C222($aMfgrNum; 0)
			ARRAY TEXT:C222($aliComment; 0)
			ARRAY TEXT:C222($aURL; 0)
			ARRAY REAL:C219($aAPrice; 0)
			ARRAY LONGINT:C221($aCatNum; 0)
			ARRAY LONGINT:C221($aSeqNum; 0)
			ARRAY LONGINT:C221($aRecNum; 0)
			SELECTION TO ARRAY:C260([Item:4]itemNum:1; $aItemNum; [Item:4]description:7; $aItemDescript; [Item:4]unitOfMeasure:11; $aUoM; [Item:4]path:61; $aURL; [Item:4]mfrItemNum:39; $aMfgrNum; [Item:4]descriptionDetail:66; $aliComment; [Item:4]priceA:2; $aAPrice; [Item:4]; $aRecNum; [Item:4]indicator1:95; $aCatNum; [Item:4]indicator2:96; $aCatSeq; [Item:4]type:26; $atypeID)
			//   
			MULTI SORT ARRAY:C718($aCatNum; >; $aCatSeq; >; $aItemNum; >; $aItemDescript; $aUoM; $aURL; $aMfgrNum; $aliComment; $aAPrice; $aRecNum)
			//
			C_LONGINT:C283($iRay; $kRay)
			C_TEXT:C284($thePage; $theQty)
			$kRay:=Size of array:C274($aItemNum)
			If ($kRay>0)
				
				$vt:=$headerText+"<CENTER><H2>"+$aBaseCat{$catInc}+"</H2>:  <INPUT TYPE="+Txt_Quoted("submit")+"NAME="+Txt_Quoted("name")+"VALUE="+Txt_Quoted("Submit")+">"+"\r"+"<Table class="+Txt_Quoted("menuTable")+">"+"\r"
				$iRay:=0
				While ($iRay<$kRay)
					$cntLineReps:=0
					ARRAY TEXT:C222($addQty; 0)
					ARRAY TEXT:C222($addPrice; 0)
					ARRAY TEXT:C222($addUoM; 0)
					ARRAY TEXT:C222($addDescription; 0)
					ARRAY TEXT:C222($addExtensions; 0)
					ARRAY TEXT:C222($addAdds; 0)
					Repeat 
						$iRay:=$iRay+1
						If ($iRay=1)  //build master list
							$aMasterList{$catInc}:="<a HREF="+Txt_Quoted("/"+$thisPage)+" target="+Txt_Quoted("Main_Frame")+">"+$atypeID{1}+"</a><BR>"+"\r"
							$aMasterSeq{$catInc}:=$aCatNum{1}
						End if 
						$cntLineReps:=$cntLineReps+1
						$wLineSize:=Size of array:C274($addQty)+1
						INSERT IN ARRAY:C227($addQty; $wLineSize; 1)
						INSERT IN ARRAY:C227($addPrice; $wLineSize; 1)
						INSERT IN ARRAY:C227($addUoM; $wLineSize; 1)
						INSERT IN ARRAY:C227($addDescription; $wLineSize; 1)
						INSERT IN ARRAY:C227($addExtensions; $wLineSize; 1)
						INSERT IN ARRAY:C227($addAdds; $wLineSize; 1)
						If ($lineMechanism=1)
							$vAddQty:="<INPUT TYPE="+Txt_Quoted("hidden")+" NAME="+Txt_Quoted("LineRecordNum")+" VALUE="+Txt_Quoted("-3")+">"
							$vAddQty:=$vAddQty+"<INPUT TYPE="+Txt_Quoted("hidden")+" NAME="+Txt_Quoted("ItemNum")+" VALUE="+Txt_Quoted($aItemNum{$iRay})+">"
							$vAddQty:=$vAddQty+"<INPUT TYPE="+Txt_Quoted("text")+" NAME="+Txt_Quoted("QtyOrdered")+" VALUE="+Txt_Quoted("")+" Length="+Txt_Quoted("5")+" Size="+Txt_Quoted("2")+">"
						Else 
							$vAddQty:="<INPUT TYPE="+Txt_Quoted("text")+" NAME="+Txt_Quoted("ItemNum"+$aItemNum{$iRay})+" VALUE="+Txt_Quoted("")+" Length="+Txt_Quoted("5")+" size="+Txt_Quoted("5")+">"
						End if 
						QUERY:C277([Item:4]; [Item:4]itemNum:1=$aItemNum{$iRay})
						$addQty{$wLineSize}:=$vAddQty
						$addUoM{$wLineSize}:=$aUoM{$iRay}
						$addPrice{$wLineSize}:=String:C10($aAPrice{$iRay}; "###,##0.00")
						If (([Item:4]mfrItemNum:39#"") & ([Item:4]descriptionDetail:66#""))
							$addDescription{$wLineSize}:=[Item:4]mfrItemNum:39+"<BR>"+[Item:4]descriptionDetail:66
						Else 
							$addDescription{$wLineSize}:=$aItemDescript{$iRay}
						End if 
						
						If (False:C215)
							$addExtensions{$wLineSize}:=""
						End if 
						If (False:C215)
							$addAdds{$wLineSize}:=""
						End if 
						
						If ($iRay<$kRay)
							$nextValue:=$aMfgrNum{$iRay+1}
						End if 
					Until (($nextValue#$aMfgrNum{$iRay}) | ($iRay=$kRay))
					
					
					$vtLine:="<TR><TD class="+Txt_Quoted("MenuLine")+">"+"\r"
					$vtLine:=$vtLine+"<Table class="+Txt_Quoted("menuLineTable")+">"+"\r"
					//
					For ($incLineReps; 1; $cntLineReps)
						$vtLine:=$vtLine+"<TR>"+"\r"+"<TD class="+Txt_Quoted("MenuQty")+">"+$addQty{$incLineReps}+"\r"+"</TD>"
						$vtLine:=$vtLine+"<TD class="+Txt_Quoted("MenuPrice")+">"+$addPrice{$incLineReps}+"\r"+"</TD>"
						$vtLine:=$vtLine+"<TD class="+Txt_Quoted("MenuUoM")+">"+$addUoM{$incLineReps}+"\r"+"</TD>"
						$vtLine:=$vtLine+"<TD class="+Txt_Quoted("MenuExtends")+">"+$addExtensions{$incLineReps}+"\r"+"</TD>"
						$vtLine:=$vtLine+"<TD class="+Txt_Quoted("MenuAdds")+">"+$addAdds{$incLineReps}+"\r"+"</TD>"
						Case of 
							: (($cntLineReps>1) & ($incLineReps=1))
								$vtLine:=$vtLine+"<TD class="+Txt_Quoted("MenuDescript")+" rowspan="+Txt_Quoted(String:C10($cntLineReps))+">"+$addDescription{1}+"\r"+"</TD>"
							: (($cntLineReps=1) & ($incLineReps=1))
								$vtLine:=$vtLine+"<TD class="+Txt_Quoted("MenuDescript")+">"+$addDescription{1}+"\r"+"</TD>"
						End case 
						$vtLine:=$vtLine+"\r"+"</TR>"+"\r"
					End for 
					
					$vtLine:=$vtLine+"</TABLE>"+"\r"+"</TD></TR>"+"\r"
					$vt:=$vt+$vtLine
				End while 
				$vt:=$vt+"</TABLE></CENTER>"+"\r"+"</BODY>"+"\r"+"</HTML>"
				//If (False)
				SEND PACKET:C103(myDoc; $vt)
				CLOSE DOCUMENT:C267(myDoc)
				//End if 
			End if 
		End if 
	End for 
	UNLOAD RECORD:C212([Item:4])
	$thisPagePath:=Storage:C1525.wc.webFolder+"ItMn111.html"
	If (HFS_Exists($thisPagePath)=1)
		$err:=HFS_Delete($thisPagePath)
	End if 
	SORT ARRAY:C229($aMasterSeq; $aMasterList)
	$masterpage:=$masterpage+"<span class="+Txt_Quoted("MenuNavBar")+">"+"\r"
	For ($catInc; 1; $kCat)
		$masterpage:=$masterpage+$aMasterList{$catInc}
	End for 
	$masterpage:=$masterpage+"\r"+"</span>"+"\r"
	$masterpage:=$masterpage+"\r"+"</BODY>"+"\r"+"</HTML>"
	myDoc:=Create document:C266($thisPagePath)
	SEND PACKET:C103(myDoc; $masterpage)
	CLOSE DOCUMENT:C267(myDoc)
End if 
REDRAW WINDOW:C456