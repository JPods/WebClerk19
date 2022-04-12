//%attributes = {"publishedWeb":true}
//Procedure: Qx_Place
C_TEXT:C284($1; $theSource)
C_BOOLEAN:C305($doBasic)
KeyModifierCurrent
$doBasic:=False:C215
$cntShell:=0
OK:=1
If (Count parameters:C259=0)
	$theSource:=Request:C163("Enter Document"; ".949 Labels 50s")
Else 
	$theSource:=$1
End if 
If ($theSource#"")
	TRACE:C157
	QUERY:C277([TallyResult:73]; [TallyResult:73]name:1=$theSource; *)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="Quark")
	If (Records in selection:C76([TallyResult:73])=1)
		$xOffSet:=[TallyResult:73]real1:13
		$yOffSet:=[TallyResult:73]real2:14
		$xIncrement:=[TallyResult:73]real3:15
		$yIncrement:=[TallyResult:73]real4:16
		$pageWidth:=[TallyResult:73]real5:32
		$pageHeight:=[TallyResult:73]real6:42
		$forceFrame:=[TallyResult:73]real7:43
		$byWhom:=[TallyResult:73]textBlk2:6
		If ($byWhom#"")
			$pT:=Position:C15("<&tbu2"; $byWhom)
			ARRAY REAL:C219($aXShell; 0)
			ARRAY REAL:C219($aYShell; 0)
			ARRAY TEXT:C222($aShellBeg; 0)
			ARRAY TEXT:C222($aShellMess; 0)
			While ($pT>0)
				$pEnd:=Position:C15("<&te>"; $byWhom)
				$splitMess:=Substring:C12($byWhom; $pT; $pEnd+4)
				$byWhom:=Substring:C12($byWhom; $pEnd+5)
				INSERT IN ARRAY:C227($aShellBeg; 1)
				INSERT IN ARRAY:C227($aXShell; 1)
				INSERT IN ARRAY:C227($aYShell; 1)
				INSERT IN ARRAY:C227($aShellMess; 1)
				$p:=Position:C15("("; $splitMess)
				$aShellBeg{1}:=Substring:C12($splitMess; 1; $p)
				$splitMess:=Substring:C12($splitMess; $p+1)
				$p:=Position:C15(","; $splitMess)
				$aXShell{1}:=Num:C11(Substring:C12($splitMess; 1; $p-1))
				$splitMess:=Substring:C12($splitMess; $p+1)
				$p:=Position:C15(","; $splitMess)
				$aYShell{1}:=Num:C11(Substring:C12($splitMess; 1; $p-1))
				$aShellMess{1}:=Substring:C12($splitMess; $p+1)
				$pT:=Position:C15("<&tbu2"; $byWhom)
			End while 
			$cntShell:=Size of array:C274($aXShell)
		End if 
		$template:=[TallyResult:73]textBlk1:5
		$maxWidth:=0
		$numCol:=2
	Else 
		$doBasic:=True:C214
	End if 
End if 
If (OK=1)
	If ($doBasic)
		$xOffSet:=20
		$yOffSet:=20
		$xIncrement:=288
		$yIncrement:=68.328
		$pageWidth:=612
		$pageHeight:=792
		$maxWidth:=0
		$forceFrame:=0
		$template:=""
		$numCol:=2
		$byWhom:=""
	End if 
	C_LONGINT:C283($i; $textBlk; $picBlk; $intText)
	C_TEXT:C284($theOut)
	C_LONGINT:C283($numCol; $widthCol; $pT; $pP; $pEnd; $p)
	C_REAL:C285($xOffSet; $yOffSet)
	C_TEXT:C284($byWhom; $workingText)
	vText1:=""
	$xCounter:=0
	$yCounter:=0
	$littleX:=0
	$littleY:=0
	$Start:=0
	C_TEXT:C284($myDocName)
	$myDocName:=Storage:C1525.folder.jitF+"QuarkPost:"+String:C10(DateTime_Enter)+".txt"
	myDoc:=Create document:C266($myDocName; "")
	OK:=1
	If (OK=1)
		$k:=Records in selection:C76([WorkOrder:66])
		FIRST RECORD:C50([WorkOrder:66])
		For ($i; 1; $k)
			$pT:=Position:C15("<&tbu2"; [WorkOrder:66]description:3)
			$pP:=Position:C15("<&pbu2"; [WorkOrder:66]description:3)
			If (($pT>0) | ($pP>0))
				$sendText:=""
				$workingText:=[WorkOrder:66]description:3
				If ($byWhom#"")
					$workingText:=$workingText
				End if 
				ARRAY TEXT:C222($aMessage; 0)
				ARRAY TEXT:C222($aMessPreBor; 0)
				ARRAY REAL:C219($aBoxX; 0)
				ARRAY REAL:C219($aBoxY; 0)
				ARRAY REAL:C219($aChangeX; 0)
				ARRAY REAL:C219($aChangeY; 0)
				ARRAY REAL:C219($aBoxWidth; 0)
				ARRAY REAL:C219($aBoxHeight; 0)
				ARRAY TEXT:C222($aMessStart; 0)
				ARRAY TEXT:C222($aMessBorder; 0)
				ARRAY TEXT:C222($aMessRest; 0)
				$dropOut:=False:C215
				Repeat 
					$pT:=Position:C15("<&tbu2"; $workingText)
					$pP:=Position:C15("<&pbu2"; $workingText)
					If (($pT=0) & ($pP=0))
						If (Size of array:C274($aMessRest)>0)
							$aMessRest{1}:=$aMessRest{1}+$workingText
						Else 
							INSERT IN ARRAY:C227($aBoxX; 1)
							INSERT IN ARRAY:C227($aBoxY; 1)
							INSERT IN ARRAY:C227($aChangeX; 1)
							INSERT IN ARRAY:C227($aChangeY; 1)
							INSERT IN ARRAY:C227($aBoxWidth; 1)
							INSERT IN ARRAY:C227($aBoxHeight; 1)
							INSERT IN ARRAY:C227($aMessStart; 1)
							INSERT IN ARRAY:C227($aMessPreBor; 1)
							INSERT IN ARRAY:C227($aMessBorder; 1)
							INSERT IN ARRAY:C227($aMessRest; 1)
							$aMessStart{1}:=$workingText
						End if 
						$dropOut:=True:C214
					Else   // : (($pP>0)|($pT>0))//&($pP=0)))//
						INSERT IN ARRAY:C227($aMessage; 1)
						INSERT IN ARRAY:C227($aBoxX; 1)
						INSERT IN ARRAY:C227($aBoxY; 1)
						INSERT IN ARRAY:C227($aChangeX; 1)
						INSERT IN ARRAY:C227($aChangeY; 1)
						INSERT IN ARRAY:C227($aBoxWidth; 1)
						INSERT IN ARRAY:C227($aBoxHeight; 1)
						INSERT IN ARRAY:C227($aMessStart; 1)
						INSERT IN ARRAY:C227($aMessPreBor; 1)
						INSERT IN ARRAY:C227($aMessBorder; 1)
						INSERT IN ARRAY:C227($aMessRest; 1)
						//TRACE
						If ((($pT<$pP) & ($pP>0)) | (($pT>0) & ($pP=0)))
							$pEnd:=Position:C15("<&te>"; $workingText)
							$aMessage{1}:=Substring:C12($workingText; $pT; $pEnd+4)
							$workingText:=Substring:C12($workingText; $pEnd+5)
						Else 
							$pEnd:=Position:C15(">"; $workingText)
							$aMessage{1}:=Substring:C12($workingText; $pP; $pEnd)
							$workingText:=Substring:C12($workingText; $pEnd+1)
							$splitMess:=$aMessage{1}
						End if 
						$splitMess:=$aMessage{1}
						$p:=Position:C15("("; $splitMess)
						$aMessStart{1}:=Substring:C12($splitMess; 1; $p)
						$splitMess:=Substring:C12($splitMess; $p+1)
						$p:=Position:C15(","; $splitMess)
						$aBoxX{1}:=Num:C11(Substring:C12($splitMess; 1; $p-1))
						$splitMess:=Substring:C12($splitMess; $p+1)
						$p:=Position:C15(","; $splitMess)
						$aBoxY{1}:=Num:C11(Substring:C12($splitMess; 1; $p-1))
						$splitMess:=Substring:C12($splitMess; $p+1)
						$p:=Position:C15(","; $splitMess)
						$aBoxWidth{1}:=Num:C11(Substring:C12($splitMess; 1; $p-1))
						$splitMess:=Substring:C12($splitMess; $p+1)
						$p:=Position:C15(","; $splitMess)
						$aBoxHeight{1}:=Num:C11(Substring:C12($splitMess; 1; $p-1))
						$splitMess:=Substring:C12($splitMess; $p+1)
						For ($incBorder; 1; 4)
							$p:=Position:C15(","; $splitMess)
							$aMessPreBor{1}:=$aMessPreBor{1}+Substring:C12($splitMess; 1; $p-1)+","
							$splitMess:=Substring:C12($splitMess; $p+1)
						End for 
						$p:=Position:C15(","; $splitMess)
						$aMessBorder{1}:=Substring:C12($splitMess; 1; $p-1)
						$aMessRest{1}:=Substring:C12($splitMess; $p+1)
					End if   //case 
				Until ($dropOut)
				SORT ARRAY:C229($aBoxX; $aBoxY; $aMessPreBor; $aChangeX; $aChangeY; $aBoxWidth; $aBoxHeight; $aMessPreBor; $aMessBorder; $aMessStart; $aMessRest)
				$setXPoint:=$aBoxX{1}
				$setYPoint:=$aBoxY{1}
				//    
				$keyXPoint:=($xCounter*$xIncrement)+$xOffSet
				$keyYPoint:=($yCounter*$yIncrement)+$yOffSet
				//increment for next box
				If ($xCounter>=($numCol-1))
					$xCounter:=0
					$yCounter:=$yCounter+Round:C94(($aBoxHeight{1}/$yIncrement)+0.5; 0)
				Else 
					$xCounter:=$xCounter+1  //Round(($aBoxWidth{1}/$xIncrement)+0.5;0)
				End if 
				//
				C_LONGINT:C283($incShell; $cntShell)
				C_LONGINT:C283($cntRay; $incRay)
				C_REAL:C285($XShellSet; $YShellSet)
				$cntRay:=Size of array:C274($aBoxX)
				//TRACE
				If ($cntRay>0)
					If (($forceFrame>0) & (Num:C11($aMessBorder{1})=0))
						$aMessBorder{1}:=String:C10($forceFrame)
					End if 
				End if 
				For ($incRay; 1; $cntRay)
					$aBoxX{$incRay}:=$keyXPoint+$aBoxX{$incRay}-$setXPoint
					$aBoxY{$incRay}:=$keyYPoint+$aBoxY{$incRay}-$setYPoint
					vText1:=vText1+$aMessStart{$incRay}+String:C10($aBoxX{$incRay})+","+String:C10($aBoxY{$incRay})+","+String:C10($aBoxWidth{$incRay})+","+String:C10($aBoxHeight{$incRay})+","+$aMessPreBor{$incRay}+$aMessBorder{$incRay}+","+$aMessRest{$incRay}
				End for 
				If ($cntShell>0)
					
					For ($incShell; 1; $cntShell)
						$XShellSet:=$keyXPoint+$aXShell{$incShell}
						$YShellSet:=$keyYPoint+$aYShell{$incShell}
						vText1:=vText1+$aShellBeg{$incShell}+String:C10($keyXPoint+$aXShell{$incShell})+","+String:C10($keyYPoint+$aYShell{$incShell})+","+$aShellMess{$incShell}
					End for 
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
					pvPhone:=Format_Phone([Customer:2]phone:13)
					vText1:=Txt_jitConvert(vText1)
				End if 
			End if 
			NEXT RECORD:C51([WorkOrder:66])
		End for 
		If (vHere<2)
			UNLOAD RECORD:C212([WorkOrder:66])
			UNLOAD RECORD:C212([Customer:2])
		End if 
		SET TEXT TO PASTEBOARD:C523(vText1)
		SEND PACKET:C103(myDoc; vText1)
		CLOSE DOCUMENT:C267(myDoc)
		//  
		//If ((Is macOS)&($template#""))
		//vText9:=$myDocName
		//vText8:=Txt_jitConvert ([TallyResult]TextBlk1)
		//TRACE
		//vi2:=AppleScript (vText8;"")
		//If (OptKey=1)
		//SET TEXT TO CLIPBOARD(vText8)
		//End if 
		//End if 
	End if 
End if 
UNLOAD RECORD:C212([TallyResult:73])