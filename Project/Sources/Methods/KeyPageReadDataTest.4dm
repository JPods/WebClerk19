//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: KeyPageReadDataTest
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($1)
C_POINTER:C301($2)
//TRACE
myDoc:=Open document:C264($1)
If (OK=1)
	$textEnd:=Char:C90(34)
	RECEIVE PACKET:C104(myDoc; vText1; 2000000000)
	CLOSE DOCUMENT:C267(myDoc)
	$theDocument:=document
	$shortDocument:=HFS_ShortName(document)
	ARRAY TEXT:C222(aText1; 0)
	ARRAY TEXT:C222(aText2; 0)
	ARRAY TEXT:C222(aText3; 0)
	ARRAY TEXT:C222(aText4; 0)
	ARRAY TEXT:C222(aText5; 0)
	ARRAY TEXT:C222(aText6; 0)
	ARRAY TEXT:C222(aText7; 0)
	ARRAY TEXT:C222(aText8; 0)
	ARRAY TEXT:C222(aText9; 0)
	While (Length:C16(vText1)>0)
		$p:=Position:C15("<area"; vText1)
		If ($p<1)
			vText1:=""
		Else 
			$w:=Size of array:C274(aText1)+1
			INSERT IN ARRAY:C227(aText1; $w; 1)  //all
			INSERT IN ARRAY:C227(aText2; $w; 1)  //model
			INSERT IN ARRAY:C227(aText3; $w; 1)  //bubble
			INSERT IN ARRAY:C227(aText4; $w; 1)  //recordCnt
			INSERT IN ARRAY:C227(aText5; $w; 1)  //ItemNum in keyword
			INSERT IN ARRAY:C227(aText6; $w; 1)  //ItemNum found in Item Table
			INSERT IN ARRAY:C227(aText7; $w; 1)  //WebPage and Path
			INSERT IN ARRAY:C227(aText8; $w; 1)  //unique ids
			INSERT IN ARRAY:C227(aText9; $w; 1)  //shortname document
			vText1:=Substring:C12(vText1; $p-1)
			$p:=Position:C15(">"; vText1)
			If ($p<1)
				vText1:=""
			Else 
				aText9{$w}:=$shortDocument
				aText7{$w}:=$theDocument
				aText1{$w}:=Substring:C12(vText1; 1; $p)
				vText1:=Substring:C12(vText1; $p+1)
				//        
				aText2{$w}:=Txt_TweenReturn(aText1{$w}; "_jit_-3_"; ".txtjj=")
				aText3{$w}:=Txt_TweenReturn(aText1{$w}; ".txtjj="; $textEnd)
				
				QUERY:C277([Word:99]; [Word:99]reference:6=aText2{$w}; *)
				QUERY:C277([Word:99];  & [Word:99]wordOnly:3=aText3{$w})
				$cntKeys:=Records in selection:C76([Word:99])
				aText4{$w}:=String:C10($cntKeys)
				If ($cntKeys>0)
					FIRST RECORD:C50([Word:99])
					aText8{$w}:=String:C10([Word:99]idNum:1)
					aText5{$w}:=[Word:99]relatedAlpha:8
					QUERY:C277([Item:4]; [Item:4]itemNum:1=[Word:99]relatedAlpha:8)
					If (Records in selection:C76([Item:4])=1)
						aText6{$w}:="Found Item"
					Else 
						aText6{$w}:="Missing Item"
					End if 
					If ($cntKeys>1)
						C_LONGINT:C283($cntkeys)
						For ($incKeys; 2; $cntKeys)
							NEXT RECORD:C51([Word:99])
							aText8{$w}:=aText8{$w}+", "+String:C10([Word:99]idNum:1)
						End for 
					End if 
				Else 
					aText6{$w}:="missing keyword"
				End if 
			End if 
		End if 
	End while 
	//
	$k:=Size of array:C274(aText2)
	If (OK=1)
		SEND PACKET:C103($2->; "\r"+$theDocument+"\t"+String:C10(Current date:C33)+"\r")
		For ($i; 1; $k)
			SEND PACKET:C103($2->; aText8{$i}+"\t"+aText2{$i}+"\t"+aText3{$i}+"\t"+aText4{$i}+"\t"+aText5{$i}+"\t"+aText6{$i}+"\t"+aText9{$i}+"\t"+aText7{$i}+"\r")
		End for 
	End if 
End if 
//





























//TRACE
//QUERY([KeyWord];[KeyWord]Reference="AOU18C1@")
//vi2:=Records in selection([KeyWord])
//SELECTION TO ARRAY([KeyWord];aTmpLong1)
//For (vi1;1;vi2)
//GOTO RECORD([KeyWord];aTmpLong1{vi1})
//vText1:=[KeyWord]Reference
//vText2:=[KeyWord]EnterValueAlpha
//QUERY([KeyWord];[KeyWord]Reference=vText1+"@";*)
//QUERY([KeyWord];&[KeyWord]EnterValueAlpha=vText2)
//If (Records in selection([KeyWord])=1)
//[KeyWord]typeID:=1
//SAVE RECORD([KeyWord])
//DUPLICATE RECORD([KeyWord])
//[KeyWord]Reference:=vText1+"T00"
//
//[KeyWord]KeywordCombined:=[KeyWord]EnterValueAlpha+"_"+[KeyWords
//]Reference
//[KeyWord]typeID:=5
//SAVE RECORD([KeyWord])
//DUPLICATE RECORD([KeyWord])
//[KeyWord]Reference:=vText1+"T80"
//
//[KeyWord]KeywordCombined:=[KeyWord]EnterValueAlpha+"_"+[KeyWords
//]Reference
//[KeyWord]typeID:=8
//SAVE RECORD([KeyWord])
//End if 
//End for 