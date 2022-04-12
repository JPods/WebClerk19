//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 121109, 12:33:53
// ----------------------------------------------------
// Method: UtBubbleListsLoad
// Description
// 
//
// Parameters
// ----------------------------------------------------

//

myDocName:=""
C_LONGINT:C283($myOK)
CLOSE DOCUMENT:C267(myDoc)
//
myDoc:=Open document:C264("")  //tracy's replacement bubbles
If (OK=1)
	Repeat 
		RECEIVE PACKET:C104(myDoc; $theLine; "\r")
		If (OK=1)
			TextToArray($theLine; ->aText5; "\t"; False:C215)
			If (Size of array:C274(aText5)>1)
				$itemNum:=TxtStripLineFeed(aText5{1})
				//QUERY([KeyWord];[KeyWord]TableNum=4;*)
				
				$modelNum:=aText5{1}
				$itemNum:=aText5{2}
				$bubbleNum:=aText5{3}
				QUERY:C277([Word:99]; [Word:99]tableNum:2=4; *)
				QUERY:C277([Word:99];  & [Word:99]reference:6=$modelNum; *)
				QUERY:C277([Word:99];  & [Word:99]relatedAlpha:8=$itemNum; *)
				QUERY:C277([Word:99];  & [Word:99]wordOnly:3=$bubbleNum)
				If (Records in selection:C76([Word:99])=0)
					CREATE RECORD:C68([Word:99])
					
					[Word:99]tableNum:2:=4
					[Word:99]fieldNum:7:=1
					[Word:99]reference:6:=$modelNum
					[Word:99]relatedAlpha:8:=$itemNum
					[Word:99]wordOnly:3:=$bubbleNum
					[Word:99]wordCombined:5:=[Word:99]wordOnly:3+"_"+[Word:99]reference:6
					If (Size of array:C274(aText5)>3)
						[Word:99]comment:10:=aText5{4}
					End if 
					SAVE RECORD:C53([Word:99])
				End if 
			End if 
		End if 
	Until (OK=0)
	CLOSE DOCUMENT:C267(myDoc)
End if 





If (False:C215)  //alternate items
	myDocName:=""
	C_LONGINT:C283($myOK)
	CLOSE DOCUMENT:C267(myDoc)
	//
	myDoc:=Open document:C264("")
	If (OK=1)
		Repeat 
			RECEIVE PACKET:C104(myDoc; $theLine; "\r")
			If (OK=1)
				TextToArray($theLine; ->aText5; "\t"; False:C215)
				If (Size of array:C274(aText5)>1)
					$itemNum:=TxtStripLineFeed(aText5{1})
					//QUERY([KeyWord];[KeyWord]TableNum=4;*)
					QUERY:C277([Word:99]; [Word:99]relatedAlpha:8=$itemNum)
					$k:=Records in selection:C76([Word:99])
					If ($k>0)
						SELECTION TO ARRAY:C260([Word:99]; aTmpLong1; [Word:99]wordOnly:3; aQueryFieldNames; [Word:99]reference:6; aTmp40Str2; [Word:99]relatedAlpha:8; aTmp35Str1)
						For ($i; 1; $k)
							$modelNum:=aTmp40Str2{$i}
							$itemNumAlt:=aText5{2}
							$bubbleNum:=aQueryFieldNames{$i}
							QUERY:C277([Word:99]; [Word:99]tableNum:2=4; *)
							QUERY:C277([Word:99];  & [Word:99]reference:6=$modelNum; *)
							QUERY:C277([Word:99];  & [Word:99]relatedAlpha:8=$itemNumAlt; *)
							QUERY:C277([Word:99];  & [Word:99]wordOnly:3=$bubbleNum)
							If (Records in selection:C76([Word:99])=0)
								CREATE RECORD:C68([Word:99])
								
								[Word:99]tableNum:2:=4
								[Word:99]fieldNum:7:=1
								[Word:99]reference:6:=$modelNum
								[Word:99]relatedAlpha:8:=$itemNumAlt
								[Word:99]wordOnly:3:=$bubbleNum
								[Word:99]wordCombined:5:=[Word:99]wordOnly:3+"_"+[Word:99]reference:6
								If (Size of array:C274(aText5)>2)
									[Word:99]comment:10:=aText5{4}
								End if 
								[Word:99]typeID:11:=Num:C11(aText5{3})
								[Word:99]alternate:12:=aTmp35Str1{$i}
								SAVE RECORD:C53([Word:99])
							End if 
						End for 
					End if 
				End if 
			End if 
		Until (OK=0)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
	
	
	
	
End if 
//
//If (False)
//
//If (True)
//
//myDocName:=""
//C_Longint($myOK)
//myDoc:=Open document("")
//If (OK=1)
//C_TEXT($masterLine;$theLine)
//$theLine:=""
//Repeat 
//RECEIVE PACKET(myDoc;$theLine;"\r")
//If (OK=1)
//TextToArray ($theLine;->aText5;"\t";False)
//C_Longint($i;$k;$w;$incElements;$cntElements)
//$k:=Size of array(aText5)-1
//If ($k>1)
//$itemNum:=aText5{1}
//DELETE ELEMENT(aText5;1;1)
//QUERY([Item];[Item]ItemNum=$itemNum)
//If (Records in selection([Item])=0)
//$missing:="Missing Item"
//Else 
//$missing:=""
//End if 
//While (Size of array(aText5)>1)
//$bubbleNum:=aText5{1}
//$modelNum:=aText5{2}
//DELETE ELEMENT(aText5;1;2)//delete two elements          
//QUERY([KeyWord];[KeyWord]TableNum=4;*)
//QUERY([KeyWord];&[KeyWord]Reference=$modelNum;*)
//QUERY([KeyWord];&[KeyWord]FieldValueAlpha=$itemNum;*)
//QUERY([KeyWord];&[KeyWord]EnterValueAlpha=$bubbleNum)
//If (Records in selection([KeyWord])=0)
//CREATE RECORD([KeyWord])
//
//[KeyWord]TableNum:=4
//[KeyWord]FieldNum:=1
//[KeyWord]Reference:=$modelNum
//[KeyWord]FieldValueAlpha:=$itemNum
//[KeyWord]EnterValueAlpha:=$bubbleNum
//[KeyWord]KeywordCombined:=[KeyWord]EnterValueAlpha+
//[KeyWord]Reference
//[KeyWord]Comment:=$missing
//SAVE RECORD([KeyWord])
//End if 
//End while 
//End if 
//End if 
//Until (OK=0)
//UNLOAD RECORD([KeyWord])
//UNLOAD RECORD([Item])
//CLOSE DOCUMENT(myDoc)
//End if 
//
//Else 
//If (False)
////Method: UtBubbleListsLoad
////Date: 03/11/03
////Who: Bill
////Description: 
//End if 
//
//QUERY([KeyWord];[KeyWord]UniqueID=0)
//$k:=Records in selection([KeyWord])
//FIRST RECORD([KeyWord])
//For ($i;1;$k)
//
//SAVE RECORD([KeyWord])
//NEXT RECORD([KeyWord])
//End for 
//
//TRACE
//ARRAY TEXT(aText1;0)
//ARRAY TEXT(aText6;0)
//$tempFold:=GetFolderName ("Select folder for setting suffix.")
//If ($tempFold#"")
//$err:=HFSCatToArray ($tempFold;"aText1")
//$k:=Size of array(aText1)
//If ($k>0)
//myDocName:=""
//C_Longint($myOK)
//myDoc:=Open document($tempFold+"ImportList.txt")
//If (OK=1)
//C_TEXT($masterLine;$theLine)
//RECEIVE PACKET(myDoc;$masterLine;"\r")
//TextToArray ($masterLine;->aText7;"\t";True)
//RECEIVE PACKET(myDoc;$theLine;"\r")
//TextToArray ($theLine;->aText6;"\t";True)
//RECEIVE PACKET(myDoc;$theLine;"\r")
//TextToArray ($theLine;->aText5;"\t";True)
//CLOSE DOCUMENT(myDoc)
//C_Longint($i;$k;$w;$incElements;$cntElements)
//$k:=Size of array(aText1)
//$cntElements:=Size of array(aText7)
//For ($i;1;$k)
//If (aText1{$i}#"ImportList.txt")
//myDoc:=Open document($tempFold+aText1{$i})
//RECEIVE PACKET(myDoc;$theLine;"\r")
//If ((OK=1)&($theLine=$masterLine))
//Repeat 
//$theLine:=""
//RECEIVE PACKET(myDoc;$theLine;"\r")
//If (OK=0)
//RECEIVE PACKET(myDoc;$theLine;500)
//End if 
//If ((OK=1)&($theLine#""))
//TextToArray ($theLine;->aText2;"\t";True)
//QUERY([Item];[Item]ItemNum=aText2{2})
//If (Records in selection([Item])=0)
//CREATE RECORD([Item])
//[Item]ItemNum:=aText2{2}
//[Item]Description:=aText2{3}
//[Item]Publish:=1
//[Item]Profile1:=aText2{4}
//[Item]Profile4:="Unlisted"
//SAVE RECORD([Item])
//End if 
//QUERY([KeyWord];[KeyWord]TableNum=4;*)
//QUERY([KeyWord];&[KeyWord]Reference=aText2{5};*)
//QUERY([KeyWord];&[KeyWord]FieldValueAlpha
//=aText2{2};*)
//QUERY([KeyWord];&[KeyWord]EnterValueAlpha
//=aText2{1})
//If (Records in selection([KeyWord])=0)
//CREATE RECORD([KeyWord])
//
//[KeyWord]TableNum:=4
//[KeyWord]FieldNum:=1
//[KeyWord]Reference:=aText2{5}
//[KeyWord]FieldValueAlpha:=aText2{2}
//[KeyWord]EnterValueAlpha:=aText2{1}
//[KeyWord]KeywordCombined:=[KeyWord]EnterValueAlpha
//+[KeyWord]Reference
//SAVE RECORD([KeyWord])
//End if 
//End if 
//Until (OK=0)
//End if 
//End if 
//End for 
//UNLOAD RECORD([KeyWord])
//UNLOAD RECORD([Item])
//End if 
//End if 
//End if 
//
//End if 
//End if //
//