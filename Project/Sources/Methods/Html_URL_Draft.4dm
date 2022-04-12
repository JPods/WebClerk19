//%attributes = {"publishedWeb":true}
//Method: Html_URL_Draft
C_LONGINT:C283($myNum; $myField)
C_TEXT:C284($theTableStr; $makeSearch)
C_TEXT:C284($myText; $myName; $selectList)
C_POINTER:C301($myPt)
$selectList:=""
$found:=True:C214
If (Size of array:C274(aFieldLns)>0)
	$myField:=theFldNum{aFieldLns{1}}
Else 
	$myField:=0
End if 
KeyModifierCurrent
If (OptKey=1)
	Srch_FullDia(Table:C252(curTableNum))
	$makeSearch:="SkipSearch"
Else 
	$makeSearch:=""
End if 
$theBreaks:=Num:C11(Request:C163("Enter number of columns."; "5"))
If ($theBreaks<1)
	$theBreaks:=5
End if 
TRACE:C157
Case of 
	: ($myField=0)
		BEEP:C151
		BEEP:C151
	: (curTableNum=23)
		$myName:=Request:C163("Enter Array Name"; "")
		If (($myName="") | (OK=0))
		Else 
			Case of 
				: (($myName="<>aItemsType") | ($myName="typeID"))  //!<!--P0_Sport--></TD>
					$selectList:=Html_UrlFill(-><>aItemsType; "/item_List?typeID="; $theBreaks)
				: (($myName="<>aItemsProfile1") | ($myName="Profile1"))  //!<!--P1_Season--></TD>
					$selectList:=Html_UrlFill(-><>aItemsProfile1; "/item_List?Profile1="; $theBreaks)
				: (($myName="<>aItemsProfile2") | ($myName="Profile2"))  //!<!--P2_Item Profile--></TD>
					$selectList:=Html_UrlFill(-><>aItemsProfile2; "/item_List?Profile2="; $theBreaks)
				: (($myName="<>aItemsProfile3") | ($myName="Profile3"))  //!<!--P3_Item Profile--></TD>
					$selectList:=Html_UrlFill(-><>aItemsProfile3; "/item_List?Profile3="; $theBreaks)
				: (($myName="<>aItemsProfile4") | ($myName="Profile4"))  //!<!--P4_Item Profile--></TD>            
					$selectList:=Html_UrlFill(-><>aItemsProfile4; "/item_List?Profile4="; $theBreaks)
				Else 
					ALERT:C41("Only ProfileX or typeID are supported.")
					$found:=False:C215
			End case 
		End if 
	: (curTableNum=4)  //Items
		Case of 
			: ($myField=26)
				HTML_Distinct(->[Item:4]type:26; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/item_List?typeID="; $theBreaks)
			: ($myField=35)
				HTML_Distinct(->[Item:4]profile1:35; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/item_List?Profile1="; $theBreaks)
			: ($myField=36)
				HTML_Distinct(->[Item:4]profile2:36; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/item_List?Profile2="; $theBreaks)
			: ($myField=37)
				HTML_Distinct(->[Item:4]profile3:37; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/item_List?Profile3="; $theBreaks)
			: ($myField=38)
				HTML_Distinct(->[Item:4]profile4:38; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/item_List?Profile4="; $theBreaks)
			: ($myField=53)
				HTML_Distinct(->[Item:4]mfrID:53; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/item_List?mfgID="; $theBreaks)
			: ($myField=45)
				HTML_Distinct(->[Item:4]vendorID:45; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/item_List?VendorID="; $theBreaks)
			Else 
				$found:=False:C215
		End case 
	: (curTableNum=58)  //TechNote
		Case of 
			: ($myField=2)
				HTML_Distinct(->[TechNote:58]name:2; -3; ->[TechNote:58]publish:11; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/Tech_List?Title="; $theBreaks)
			: ($myField=6)
				HTML_Distinct(->[TechNote:58]subject:6; -3; ->[TechNote:58]publish:11; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/Tech_List?subject="; $theBreaks)
			: ($myField=10)
				HTML_Distinct(->[TechNote:58]author:10; -3; ->[TechNote:58]publish:11; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/Tech_List?author="; $theBreaks)
			Else 
				$found:=False:C215
		End case 
	: (curTableNum=80)  //Forum
		Case of 
			: ($myField=1)
				HTML_Distinct(->[Forum:80]subject:1; -3; ->[Forum:80]publish:7; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/Forum_List?subject="; $theBreaks)
			: ($myField=2)
				HTML_Distinct(->[Forum:80]topic:2; -3; ->[Forum:80]publish:7; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/Forum_List?topic="; $theBreaks)
			: ($myField=11)
				HTML_Distinct(->[Forum:80]purpose:11; -3; ->[Forum:80]publish:7; $makeSearch; ->aText1)
				$selectList:=Html_UrlFill(->aText1; "/Forum_List?purpose="; $theBreaks)
			Else 
				$found:=False:C215
		End case 
	: (curTableNum=73)  //TallyResults
		C_TEXT:C284($strFile; $strField; $quoteChar)
		$strFile:=Request:C163("FAQ, WebClerk1, WebClerk2; other"; "FAQ")
		$strField:=Request:C163("Who, Topic, Subject"; "Subject")
		Case of 
			: ($strFile="FAQ")  //FAQ
				Case of 
					: ($strField="who")
						HTML_Distinct(->[TallyResult:73]profile1:17; -3; ->[TallyResult:73]publish:36; "FAQ"; ->aText1)  //who
						$selectList:=Html_UrlFill(->aText1; "/FAQ_List?who="; $theBreaks)
					: ($strField="topic")
						HTML_Distinct(->[TallyResult:73]profile2:18; -3; ->[TallyResult:73]publish:36; "FAQ"; ->aText1)  //topic
						$selectList:=Html_UrlFill(->aText1; "/FAQ_List?topic="; $theBreaks)
					: ($strField="subject")
						HTML_Distinct(->[TallyResult:73]profile3:19; -3; ->[TallyResult:73]publish:36; "FAQ"; ->aText1)  //subject
						$selectList:=Html_UrlFill(->aText1; "/FAQ_List?subject="; $theBreaks)
					Else 
						$found:=False:C215
				End case 
			: ($strFile="Webclerk1")  //Lib 1
				Case of 
					: ($strField="who")
						HTML_Distinct(->[TallyResult:73]profile1:17; -3; ->[TallyResult:73]publish:36; "Webclerk1"; ->aText1)
						$selectList:=Html_UrlFill(->aText1; "/webClerk1?who="; $theBreaks)
					: ($strField="topic")
						HTML_Distinct(->[TallyResult:73]profile2:18; -3; ->[TallyResult:73]publish:36; "Webclerk1"; ->aText1)
						$selectList:=Html_UrlFill(->aText1; "/webClerk1?topic="; $theBreaks)
					: ($strField="subject")
						HTML_Distinct(->[TallyResult:73]profile3:19; -3; ->[TallyResult:73]publish:36; "Webclerk1"; ->aText1)
						$selectList:=Html_UrlFill(->aText1; "/webClerk1?subject="; $theBreaks)
					Else 
						$found:=False:C215
				End case 
			: ($strFile="Webclerk2")  //Lib 2
				Case of 
					: ($strField="who")
						HTML_Distinct(->[TallyResult:73]profile1:17; -3; ->[TallyResult:73]publish:36; "Webclerk2"; ->aText1)
						$selectList:=Html_UrlFill(->aText1; "/webClerk2?who="; $theBreaks)
					: ($strField="topic")
						HTML_Distinct(->[TallyResult:73]profile2:18; -3; ->[TallyResult:73]publish:36; "Webclerk2"; ->aText1)
						$selectList:=Html_UrlFill(->aText1; "/webClerk2?topic="; $theBreaks)
					: ($strField="subject")
						HTML_Distinct(->[TallyResult:73]profile3:19; -3; ->[TallyResult:73]publish:36; "Webclerk2"; ->aText1)
						$selectList:=Html_UrlFill(->aText1; "/webClerk2?subject="; $theBreaks)
					Else 
						$found:=False:C215
				End case 
			Else 
				Case of 
					: ($strField="who")
						HTML_Distinct(->[TallyResult:73]profile1:17; -3; ->[TallyResult:73]publish:36; $strFile; ->aText1)
						$selectList:=Html_UrlFill(->aText1; "/Library?purpose="+$strFile+"?who="; $theBreaks)
					: ($strField="topic")
						HTML_Distinct(->[TallyResult:73]profile2:18; -3; ->[TallyResult:73]publish:36; $strFile; ->aText1)
						$selectList:=Html_UrlFill(->aText1; "/Library?purpose="+$strFile+"?who="; $theBreaks)
					: ($strField="subject")
						HTML_Distinct(->[TallyResult:73]profile3:19; -3; ->[TallyResult:73]publish:36; $strFile; ->aText1)
						$selectList:=Html_UrlFill(->aText1; "/Library?purpose="+$strFile+"?who="; $theBreaks)
					Else 
						$found:=False:C215
				End case 
		End case 
	Else 
		$found:=False:C215
End case 
If ($found)
	If ($selectList="")
		$selectList:="No Record or Action Match"
	Else 
		////**WR INSERT TEXT (eLetterArea;$selectList)
	End if 
Else 
	$selectList:="No Record Match"
End if 

Case of 
	: (is4DWriteUser=3)
		//**WR INSERT TEXT (eLetterArea;$selectList)
	Else 
		vTextSummary:=$selectList+"\r"+"\r"+vTextSummary
		//SET TEXT TO CLIPBOARD($selectList)
End case 


