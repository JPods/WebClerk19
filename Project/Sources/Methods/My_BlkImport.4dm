//%attributes = {"publishedWeb":true}
C_TEXT:C284($tempFold)
C_LONGINT:C283($myOK; $w; $k; $i)
C_TIME:C306(myErrDoc)
//
CLOSE DOCUMENT:C267(myErrDoc)
CLOSE DOCUMENT:C267(myDoc)
CLOSE DOCUMENT:C267(sumDoc)
//
myErrDoc:=EI_UniqueDoc("Error"+Date_strYrMmDd)
ON ERR CALL:C155("OEC_ConsoleDebug")
$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open Import Definition"; ""; Storage:C1525.folder.jitExportsF)  //;jitQRsF
TRACE:C157
If ($myOK=1)
	ARRAY TEXT:C222($aText1; 0)
	ARRAY TEXT:C222($aText2; 0)
	ARRAY TEXT:C222($aText3; 0)
	ARRAY TEXT:C222($aText4; 0)
	ARRAY TEXT:C222($aText5; 0)
	C_TEXT:C284($text1; $text2; $text3; $text4; $text5)
	Repeat 
		RECEIVE PACKET:C104(myDoc; $text1; "\t")
		RECEIVE PACKET:C104(myDoc; $text2; "\t")
		RECEIVE PACKET:C104(myDoc; $text3; "\t")
		RECEIVE PACKET:C104(myDoc; $text4; "\t")
		RECEIVE PACKET:C104(myDoc; $text5; "\r")
		If ((OK=1) & ($text4#""))
			$w:=Size of array:C274($aText1)+1
			INSERT IN ARRAY:C227($aText1; $w; 1)  //action
			INSERT IN ARRAY:C227($aText2; $w; 1)  //FileNum
			INSERT IN ARRAY:C227($aText3; $w; 1)  //Pattern file
			INSERT IN ARRAY:C227($aText4; $w; 1)  //Import file
			INSERT IN ARRAY:C227($aText5; $w; 1)  ////vSearchBy
			$aText1{$w}:=$text1
			$aText2{$w}:=$text2
			$aText3{$w}:=$text3
			$aText4{$w}:=$text4
			$aText5{$w}:=$text5
		End if 
	Until (OK=0)
	CLOSE DOCUMENT:C267(myDoc)
	$k:=Size of array:C274($aText1)
	For ($i; 1; $k)
		Case of 
			: ($aText1{$i}="Import")
				curTableNum:=Num:C11($aText2{$i})
				If (curTableNum>0)
					jsetDefaultFile(Table:C252(curTableNum))
					jExpImpLoad("Import Pattern"; "SYLK"; $aText3{$i})
					vCount:=0
					TRACE:C157
					ARRAY TEXT:C222(aImpFields; Size of array:C274(aMatchField))
					myDoc:=Open document:C264($aText4{$i})
					C_LONGINT:C283($indRay; $cntRay)
					READ WRITE:C146(Table:C252(curTableNum)->)
					If ($aText5{$w}="delete")
						ALL RECORDS:C47(Table:C252(curTableNum)->)
						DELETE SELECTION:C66(Table:C252(curTableNum)->)
						vSearchBy:=""
					Else 
						vSearchBy:=$aText5{$w}
					End if 
					Repeat 
						$cntRay:=Size of array:C274(aImpFields)
						For ($indRay; 1; $cntRay)
							aImpFields{$indRay}:=""
							RECEIVE PACKET:C104(myDoc; aImpFields{$indRay}; "\t")
						End for 
						RECEIVE PACKET:C104(myDoc; aImpFields{$cntRay}; "\r")
					Until (aMatchField{1}#aImpFields{1})
					jimpMultipleRec
					
					
				End if 
				CLOSE DOCUMENT:C267(myDoc)
			: ($aText1{$i}="Execute")
				If (Num:C11($aText2{$i})#0)
					jsetDefaultFile(Table:C252(Num:C11($aText2{$i})))
				End if 
				myDoc:=Open document:C264($aText4{$i})
				If (OK=1)
					<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
					RECEIVE PACKET:C104(myDoc; vtSearch; <>vEoF)
					If (OK=1)
						ExecuteText(0; vtSearch)
					End if 
					CLOSE DOCUMENT:C267(myDoc)
				End if 
		End case 
	End for 
End if 
ON ERR CALL:C155("")
CLOSE DOCUMENT:C267(myErrDoc)