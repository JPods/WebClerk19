//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 121109, 12:33:53
// ----------------------------------------------------
// Method: UTFileNameLength
// Description
// 
//
// Parameters
// ----------------------------------------------------


ARRAY TEXT:C222(aText1; 0)
ARRAY TEXT:C222(aText6; 0)
$tempFold:=Get_FolderName("Select folder for setting suffix.")
If ($tempFold#"")
	$err:=HFS_CatToArray($tempFold; "aText1")
	$k:=Size of array:C274(aText1)
	If ($k>0)
		C_LONGINT:C283($i; $k; $w; $incElements; $cntElements)
		For ($i; 1; $k)
			If (aText1{$i}="ImportList.txt")
				myDoc:=Open document:C264($tempFold+aText1{$i})
				RECEIVE PACKET:C104(myDoc; $theLine; "\r")
				If ((OK=1) & ($theLine=$masterLine))
					Repeat 
						$theLine:=""
						RECEIVE PACKET:C104(myDoc; $theLine; "\r")
						If (OK=0)
							RECEIVE PACKET:C104(myDoc; $theLine; 500)
						End if 
						If ((OK=1) & ($theLine#""))
							TextToArray($theLine; ->aText2; "\t"; True:C214)
							QUERY:C277([Item:4]; [Item:4]itemNum:1=aText2{2})
							If (Records in selection:C76([Item:4])=0)
								CREATE RECORD:C68([Item:4])
								[Item:4]itemNum:1:=aText2{2}
								[Item:4]description:7:=aText2{3}
								[Item:4]publish:60:=1
								[Item:4]profile1:35:=aText2{4}
								[Item:4]profile4:38:="Unlisted"
								SAVE RECORD:C53([Item:4])
							End if 
							QUERY:C277([Word:99]; [Word:99]tableNum:2=4; *)
							QUERY:C277([Word:99];  & [Word:99]reference:6=aText2{5}; *)
							QUERY:C277([Word:99];  & [Word:99]relatedAlpha:8=aText2{2}; *)
							QUERY:C277([Word:99];  & [Word:99]wordOnly:3=aText2{1})
							If (Records in selection:C76([Word:99])=0)
								CREATE RECORD:C68([Word:99])
								
								[Word:99]tableNum:2:=4
								[Word:99]fieldNum:7:=1
								[Word:99]reference:6:=aText2{5}
								[Word:99]relatedAlpha:8:=aText2{2}
								[Word:99]wordOnly:3:=aText2{1}
								[Word:99]wordCombined:5:=[Word:99]wordOnly:3+"_"+[Word:99]reference:6
								SAVE RECORD:C53([Word:99])
							End if 
						End if 
					Until (OK=0)
				End if 
			End if 
		End for 
		UNLOAD RECORD:C212([Word:99])
		UNLOAD RECORD:C212([Item:4])
	End if 
End if 
