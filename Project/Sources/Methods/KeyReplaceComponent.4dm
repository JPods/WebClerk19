//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 121109, 12:33:53
// ----------------------------------------------------
// Method: KeyReplaceComponent
// Description
// 
//
// Parameters
// ----------------------------------------------------

//CLOSE DOCUMENT(myDoc)
C_TEXT:C284($itemNum)
$myOK:=0
If (Count parameters:C259=1)
	myDocName:=$1
	$myOK:=1
Else 
	$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open File to Import"; ""; Storage:C1525.folder.jitExportsF)  //;jitQRsF  
	If ($myOK=0)
		myDocName:=""
	Else 
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 
//
TRACE:C157
If (mydocName#"")
	ARRAY TEXT:C222(aText1; 0)
	ARRAY TEXT:C222(aText2; 0)
	ARRAY TEXT:C222(aText3; 0)
	C_LONGINT:C283($myOK)
	myDoc:=Open document:C264(mydocName)
	If (OK=1)
		C_TEXT:C284($masterLine; $theLine)
		Repeat 
			RECEIVE PACKET:C104(myDoc; $masterLine; "\r")
			If (OK=1)
				TextToArray($masterLine; ->aText1; "\t"; True:C214)
				If (Size of array:C274(aText1)>4)
					QUERY:C277([Word:99]; [Word:99]reference:6=aText1{1}; *)
					QUERY:C277([Word:99];  & [Word:99]wordOnly:3=aText1{2}; *)
					QUERY:C277([Word:99];  & [Word:99]relatedAlpha:8=aText1{3})
					If (Records in selection:C76([Word:99])=0)
						CREATE RECORD:C68([Word:99])
						
						[Word:99]tableNum:2:=4
						[Word:99]fieldNum:7:=1
						[Word:99]typeID:11:=444
						[Word:99]reference:6:=aText1{1}
						[Word:99]wordOnly:3:=aText1{2}
						[Word:99]relatedAlpha:8:=aText1{3}
						[Word:99]wordCombined:5:=[Word:99]wordOnly:3+"_"+[Word:99]reference:6
						SAVE RECORD:C53([Word:99])
					End if 
					C_LONGINT:C283($i; $k)
					$k:=Records in selection:C76([Word:99])
					FIRST RECORD:C50([Word:99])
					For ($i; 1; $k)
						Case of 
							: (aText1{4}="Bubble")
								[Word:99]wordOnly:3:=aText1{5}
							: (aText1{4}="Model")
								[Word:99]reference:6:=aText1{5}
							: (aText1{4}="ItemNum")
								[Word:99]relatedAlpha:8:=aText1{5}
						End case 
						[Word:99]wordCombined:5:=[Word:99]wordOnly:3+"_"+[Word:99]reference:6
						SAVE RECORD:C53([Word:99])
						NEXT RECORD:C51([Word:99])
					End for 
				End if 
			End if 
		Until (OK=0)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 


