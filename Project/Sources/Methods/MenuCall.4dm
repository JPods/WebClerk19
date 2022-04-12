//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/28/11, 12:50:45
// ----------------------------------------------------
// Method: MenuCall
// Description
// 
//
// Parameters


//WC Parameters
//MenuCommand:    builds and return a menu in the variable: menuList
//RecordID
//RootType
// ----------------------------------------------------

C_LONGINT:C283($1)
C_POINTER:C301($2)
ARRAY TEXT:C222($aMainCmds; 0)
ARRAY TEXT:C222($aMainTargets; 0)
ARRAY TEXT:C222($aMainStyles; 0)
ARRAY LONGINT:C221($aMainUIDs; 0)
ARRAY LONGINT:C221($aMainRecordNum; 0)

C_TEXT:C284($jitPageOne; $format)
//
$menuCommand:=WCapi_GetParameter("MenuCommand"; "")  // is not currently used
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
$rootType:=WCapi_GetParameter("RootType"; "")  // adds am additional search parameter, such as "Home" and "Gift"
$format:=WCapi_GetParameter("MenuFormat"; "")


$doMenu:=True:C214
//TRACE
// should this be erased each time?  150117
menuList:=""
C_LONGINT:C283($recordNum; $securityLevel)
//$securityLevel:=MaxValueReturn (viEndUserSecurityLevel;
C_BOOLEAN:C305($createBaseMenu)
$createBaseMenu:=False:C215
If (Count parameters:C259=0)
	$createBaseMenu:=True:C214
	$doMenu:=True:C214
	QUERY:C277([Menu:107]; [Menu:107]parentid:4=0)
	If (Records in selection:C76([Menu:107])>0)
		
		
		SELECTION TO ARRAY:C260([Menu:107]; $aMainRecordNum; [Menu:107]idNum:1; $aMainUIDs; [Menu:107]command:2; $aMainCmds; [Menu:107]target:7; $aMainTargets; [Menu:107]style:8; $aMainStyles)
		SORT ARRAY:C229($aMainCmds; $aMainUIDs; $aMainTargets; $aMainStyles)
		//      
		While ($myParentID>0)
			QUERY:C277([Menu:107]; [Menu:107]idNum:1=$myParentID)
			INSERT IN ARRAY:C227($aPathCmds; 1; 1)
			INSERT IN ARRAY:C227($aPathTargets; 1; 1)
			INSERT IN ARRAY:C227($aPathStyles; 1; 1)
			INSERT IN ARRAY:C227($aPathUIDs; 1; 1)
			INSERT IN ARRAY:C227($aPathRecordNum; 1; 1)
			$aPathStyles{1}:=[Menu:107]style:8
			$aPathTargets{1}:=[Menu:107]target:7
			$aPathCmds{1}:=Uppercase:C13([Menu:107]command:2)
			$aPathUIDs{1}:=[Menu:107]idNum:1
			$aPathRecordNum{1}:=Record number:C243([Menu:107])
			$myParentID:=[Menu:107]parentid:4
		End while 
		//    
		$cntHeaders:=Size of array:C274($aPathCmds)  //insert parents into display
		$menuSpace:=$cntHeaders+1
		$k:=Size of array:C274($aMainCmds)
		For ($i; 1; $k)
			$aMainCmds{$i}:=Lowercase:C14($aMainCmds{$i})
		End for 
		
	End if 
Else 
	If ($recordID=0)  //if no command is given, find the primary set of [Menu]
		QUERY:C277([Menu:107]; [Menu:107]parentid:4=0; *)
		If ($rootType#"")
			QUERY:C277([Menu:107];  & [Menu:107]rootType:9=$rootType; *)  //if no command is given, find the primary set of [Menu]
		End if 
		QUERY:C277([Menu:107])
		SELECTION TO ARRAY:C260([Menu:107]; $aMainRecordNum; [Menu:107]idNum:1; $aMainUIDs; [Menu:107]command:2; $aMainCmds; [Menu:107]target:7; $aMainTargets; [Menu:107]style:8; $aMainStyles)
		SORT ARRAY:C229($aMainCmds; $aMainRecordNum; $aMainUIDs; $aMainTargets; $aMainStyles)
		//$k:=Size of array($aMainStyles)
		//For ($i;1;$k)
		//If ($aMainStyles{$i}="")
		//$aMainStyles{$i}:=Uppercase($aMainStyles{$i})
		//End if 
		//End for 
	Else 
		QUERY:C277([Menu:107]; [Menu:107]idNum:1=$recordID)
		If (Records in selection:C76([Menu:107])=1)  //Set baseline
			ARRAY TEXT:C222($aPathCmds; 1)
			ARRAY TEXT:C222($aPathTargets; 1)
			ARRAY TEXT:C222($aPathStyles; 1)
			ARRAY LONGINT:C221($aPathUIDs; 1)
			ARRAY LONGINT:C221($aPathRecordNum; 1)
			$aPathStyles{1}:=[Menu:107]style:8
			$aPathTargets{1}:=[Menu:107]target:7
			$aPathCmds{1}:=Uppercase:C13([Menu:107]command:2)
			$aPathUIDs{1}:=[Menu:107]idNum:1
			$aPathRecordNum{1}:=Record number:C243([Menu:107])
			$findChildUID:=[Menu:107]idNum:1
			$myParentID:=[Menu:107]parentid:4
			$scriptText:=[Menu:107]script:19
			//
			//TRACE
			
			// CodeDefect by: William James (2014-06-03T00:00:00 Subrecord eliminated)
			
			
			QUERY:C277([Menu:107]; [Menu:107]parentid:4=$findChildUID)  //branch to child menus or items
			If (Records in selection:C76([Menu:107])=0)  //="Item")
				
				QUERY:C277([Word:99]; [Word:99]wordCombined:5=String:C10($findChildUID)+"MenuRef"; *)
				QUERY:C277([Word:99];  & [Word:99]tableNum:2=Table:C252(->[Item:4]))
				If (Records in selection:C76([Word:99])>0)
					ARRAY TEXT:C222($relatedItems; 0)
					SELECTION TO ARRAY:C260([Word:99]relatedAlpha:8; $relatedItems)
					QUERY WITH ARRAY:C644([Item:4]itemNum:1; $relatedItems)
					QUERY SELECTION:C341([Item:4]; [Item:4]publish:60>0)
					QUERY SELECTION:C341([Item:4]; [Item:4]publish:60<=viEndUserSecurityLevel)
					ORDER BY:C49([Item:4]; [Item:4]itemNum:1; >)
					$doMenu:=False:C215
				End if 
			Else 
				SELECTION TO ARRAY:C260([Menu:107]; $aMainRecordNum; [Menu:107]idNum:1; $aMainUIDs; [Menu:107]command:2; $aMainCmds; [Menu:107]target:7; $aMainTargets; [Menu:107]style:8; $aMainStyles)
				SORT ARRAY:C229($aMainCmds; $aMainUIDs; $aMainTargets; $aMainStyles)
				//      
				While ($myParentID>0)
					QUERY:C277([Menu:107]; [Menu:107]idNum:1=$myParentID)
					INSERT IN ARRAY:C227($aPathCmds; 1; 1)
					INSERT IN ARRAY:C227($aPathTargets; 1; 1)
					INSERT IN ARRAY:C227($aPathStyles; 1; 1)
					INSERT IN ARRAY:C227($aPathUIDs; 1; 1)
					INSERT IN ARRAY:C227($aPathRecordNum; 1; 1)
					$aPathStyles{1}:=[Menu:107]style:8
					$aPathTargets{1}:=[Menu:107]target:7
					$aPathCmds{1}:=Uppercase:C13([Menu:107]command:2)
					$aPathUIDs{1}:=[Menu:107]idNum:1
					$aPathRecordNum{1}:=Record number:C243([Menu:107])
					$myParentID:=[Menu:107]parentid:4
				End while 
				//    
				$cntHeaders:=Size of array:C274($aPathCmds)  //insert parents into display
				$menuSpace:=$cntHeaders+1
				$k:=Size of array:C274($aMainCmds)
				For ($i; 1; $k)
					$aMainCmds{$i}:=Lowercase:C14($aMainCmds{$i})
				End for 
				//      
				
				For ($i; $cntHeaders; 1; -1)
					$w:=1
					INSERT IN ARRAY:C227($aMainCmds; $w; 1)
					INSERT IN ARRAY:C227($aMainTargets; $w; 1)
					INSERT IN ARRAY:C227($aMainStyles; $w; 1)
					INSERT IN ARRAY:C227($aMainUIDs; $w; 1)
					INSERT IN ARRAY:C227($aMainRecordNum; $w; 1)
					//
					$aMainCmds{$w}:=($i*"-")+$aPathCmds{$i}
					$aMainTargets{$w}:=$aPathTargets{$i}
					$aMainStyles{$w}:=$aPathStyles{$i}
					$aMainUIDs{$w}:=$aPathUIDs{$i}
					$aMainRecordNum{$w}:=$aPathRecordNum{$i}
				End for 
			End if 
		End if 
	End if 
End if 
If ($doMenu)
	
	If ($scriptText#"")
		ExecuteText(0; [Menu:107]script:19)
		$pageDo:="send text"
	Else 
		
		Case of 
			: ($format="table")
				menuList:="<Table style="+Txt_Quoted([Menu:107]style:8)+">"+"\r"  //put this on page to control values
				$k:=Size of array:C274($aMainCmds)
				//TRACE
				For ($i; 1; $k)
					$class:="<TR><TD "+$aMainStyles{$i}
					$reference:="><a href="+Txt_Quoted("/Item_Menu?MenuCommand="+$aMainCmds{$i}+"&RecordID="+String:C10($aMainUIDs{$i}))
					$target:=(" target="+Txt_Quoted($aMainTargets{$i})+">")*Num:C11($aMainTargets{$i}#"")
					$theEnd:="</a></TD></TR>"+"\r"
					menuList:=menuList+$class+$reference+$target+$aMainCmds{$i}+$theEnd
				End for 
				menuList:=menuList+"</Table>"  //put this on page to control values
			Else 
				menuList:="<ul class="+Txt_Quoted([Menu:107]style:8)+">"+"\r"  //put this on page to control values
				$k:=Size of array:C274($aMainCmds)
				//TRACE
				For ($i; 1; $k)
					$class:="<li class="+$aMainStyles{$i}
					$reference:="><a href="+Txt_Quoted("/Item_Menu?MenuCommand="+$aMainCmds{$i}+"&RecordID="+String:C10($aMainUIDs{$i}))
					$target:=(" target="+Txt_Quoted($aMainTargets{$i})+">")*Num:C11($aMainTargets{$i}#"")
					$theEnd:="</a></li>"+"\r"
					menuList:=menuList+$class+$reference+$target+$aMainCmds{$i}+$theEnd
				End for 
				menuList:=menuList+"</ul>"  //put this on page to control values
		End case 
		
		
		
		Case of 
			: ($createBaseMenu)
				// fill variable "menuList" to be displayed on the page
			: ([Menu:107]target:7#"")
				$jitPagOne:=WCapi_GetParameter("$jitPagOne"; "")
				$pageDo:=WC_DoPage("MenuList.html"; $jitPageOne)
			Else 
				$pageDo:="send text"  // send as ajax
		End case 
	End if 
Else 
	$k:=Records in selection:C76([Item:4])
	Case of 
		: ($k>150)
			REDUCE SELECTION:C351([Item:4]; 60)
		: ($k=0)
			$jitPageList:="Error.html"
			vResponse:="No Records matching menu: "+String:C10($findChildUID)+"MenuRef"
		Else 
			// TRACE
			$jitPageList:=WCapi_GetParameter("jitPageOne"; "")
	End case 
	$pageDo:=WC_DoPage("ItemsList.html"; $jitPageList)
End if 

Case of 
	: ($createBaseMenu)
		// fill variable "menuList" to be displayed on the page
	: ($pageDo="send text")
		C_BLOB:C604($blobPageOut)
		SET BLOB SIZE:C606($blobPageOut; 0)
		TEXT TO BLOB:C554(menuList; $blobPageOut; UTF8 text without length:K22:17; *)
		Http_SendWWWHd($1; "text/html"; BLOB size:C605($blobPageOut))
		$err:=TCP Send Blob($1; $blobPageOut)
	Else 
		$err:=WC_PageSendWithTags($1; $pageDo; 0)
End case 