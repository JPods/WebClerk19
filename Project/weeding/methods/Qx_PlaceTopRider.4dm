//%attributes = {"publishedWeb":true}
//Method: Qx_PlaceTopRider

C_TEXT:C284($1; $theSource)
C_BOOLEAN:C305($doBasic)
KeyModifierCurrent
TRACE:C157
If (Size of array:C274(aTmpReal3)=0)
	ALERT:C41("No Quantity to process.")
Else 
	$doBasic:=True:C214
	$cntShell:=0
	$cntY:=0
	vText2:=""
	OK:=1
	If (Count parameters:C259=0)
		$theSource:=Request:C163("Enter Document"; ".949 Labels 50s")
	Else 
		$theSource:=$1
	End if 
	If ($theSource#"")
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
			$labelOffSet:=[TallyResult:73]real8:44
			If ([TallyResult:73]textBlk2:6#"")
				
			End if 
			$byWhom:=[TallyResult:73]textBlk2:6
			$template:=[TallyResult:73]textBlk1:5
			$maxWidth:=0
			$numCol:=2
			$doBasic:=False:C215
			UNLOAD RECORD:C212([TallyResult:73])
		End if 
	End if 
	If ($doBasic)
		$xOffSet:=20
		$yOffSet:=20
		$xIncrement:=20
		$yIncrement:=5
		$pageWidth:=722
		$pageHeight:=576
		$maxWidth:=0
		$forceFrame:=0
		$template:=""
		$numCol:=2
		$byWhom:=""
	End if 
	If ($byWhom#"")
		TRACE:C157
		$pT:=Position:C15("<&tbu2"; $byWhom)
		ARRAY REAL:C219($aXShell; 0)
		ARRAY REAL:C219($aYShell; 0)
		ARRAY REAL:C219($aYShellWidth; 0)
		ARRAY TEXT:C222($aShellBeg; 0)
		ARRAY TEXT:C222($aShellMess; 0)
		TRACE:C157
		While ($pT>0)
			$vBaseStr:=""
			$pEnd:=Position:C15("<&te>"; $byWhom)
			$splitMess:=Substring:C12($byWhom; $pT; $pEnd+4)
			$byWhom:=Substring:C12($byWhom; $pEnd+5)
			INSERT IN ARRAY:C227($aShellBeg; 1)
			INSERT IN ARRAY:C227($aXShell; 1)
			INSERT IN ARRAY:C227($aYShell; 1)
			INSERT IN ARRAY:C227($aYShellWidth; 1)
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
			//
			$pBase:=Position:C15("jitBase="; $splitMess)
			If ($pBase>0)
				$vBaseStr:=Substring:C12($splitMess; $p+1)
				$p:=Position:C15(","; $vBaseStr)
				$vWideShell:=Num:C11(Substring:C12($vBaseStr; 1; $p-1))
				//
				$aYShellWidth{1}:=$vWideShell  //figuar standard width
				//
				$vBaseStr:=Substring:C12($vBaseStr; $p+1)
				$p:=Position:C15(","; $vBaseStr)
				$vTallShell:=Num:C11(Substring:C12($vBaseStr; 1; $p-1))
				$pBase:=Position:C15("jitBase=Top"; $splitMess)
				If ($pBase>0)
					$xRiderOff:=$vWideShell/2
					$yRiderOff:=($vTallShell)+2
				Else 
					//
				End if 
			End if 
			//
			
			$pT:=Position:C15("<&tbu2"; $byWhom)
		End while 
		$cntShell:=Size of array:C274($aXShell)
	End if 
	C_REAL:C285($keyXPoint; $keyYPoint)
	$keyXPoint:=$xOffSet
	$keyYPoint:=$yOffSet
	C_LONGINT:C283($i; $textBlk; $picBlk; $intText)
	C_TEXT:C284($theOut)
	C_LONGINT:C283($numCol; $widthCol; $pT; $pP; $pEnd; $p)
	C_REAL:C285($xOffSet; $yOffSet)
	C_TEXT:C284($byWhom; $workingText)
	vText1:=""
	$xCounter:=0
	C_TEXT:C284($myDocName; $thisStamp)
	//
	//$myDocName:=Storage.folder.jitF+"QuarkPost\"+String(DateTime_DTTo)+".txt"
	//myDoc:=create document($myDocName;"")
	//
	If (OK=1)
		$yCounter:=1
		$xCounter:=1
		//ArraySort(aTmpLong1;">";aTmpReal3;"<";aTmpReal1;"=";aTmpReal2;"=";aTmpReal4;"=")
		MULTI SORT ARRAY:C718(aTmpLong1; >; aTmpReal3; <; aTmpReal1; aTmpReal2; aTmpReal4)
		
		$maxX:=aTmpReal3{1}+$xIncrement
		$maxY:=aTmpReal4{1}
		$k:=Size of array:C274(aTmpLong1)
		$cntY:=$yOffSet
		For ($i; 1; $k)
			$thisStamp:=""
			GOTO RECORD:C242([WorkOrder:66]; aTmpLong1{$i})
			$pT:=Position:C15("<&tbu2"; [WorkOrder:66]description:3)
			$pP:=Position:C15("<&pbu2"; [WorkOrder:66]description:3)
			If (($pT>0) | ($pP>0))
				$sendText:=""
				$workingText:=[WorkOrder:66]description:3
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
							//INSERT ELEMENT($aChangeX;1)
							//INSERT ELEMENT($aChangeY;1)
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
						//INSERT ELEMENT($aChangeX;1)
						//INSERT ELEMENT($aChangeY;1)
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
				//
				C_LONGINT:C283($yCounter)
				$cntY:=$cntY+aTmpReal4{$i}
				//
				C_LONGINT:C283($incShell; $cntShell)
				C_LONGINT:C283($cntRay; $incRay)
				C_REAL:C285($XShellSet; $YShellSet)
				$cntRay:=Size of array:C274($aBoxX)
				C_TEXT:C284($grpCmd)
				
				If ($cntShell>0)
					For ($incShell; 1; $cntShell)
						$XShellSet:=$keyXPoint+$aXShell{$incShell}
						$YShellSet:=$keyYPoint+$aYShell{$incShell}
						$thisStamp:=$thisStamp+$aShellBeg{$incShell}+String:C10($keyXPoint+$aXShell{$incShell})+","+String:C10($keyYPoint+$aYShell{$incShell})+","+$aShellMess{$incShell}
					End for 
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
					pvPhone:=Format_Phone([Customer:2]phone:13)
					$thisStamp:=Txt_jitConvert($thisStamp)
				End if 
				//
				//zzzzzz:=10000//$aXShell{$incRay}  changed from $aXShell{1}
				For ($incRay; 1; $cntRay)
					$aBoxX{$incRay}:=$keyXPoint+$aXShell{1}+$aBoxX{$incRay}-aTmpReal1{$i}+$xRiderOff-(aTmpReal3{$i}/2)
					$aBoxY{$incRay}:=$keyYPoint+$aYShell{1}+$aBoxY{$incRay}-aTmpReal2{$i}+$yRiderOff
					$thisStamp:=$thisStamp+$aMessStart{$incRay}+String:C10($aBoxX{$incRay})+","+String:C10($aBoxY{$incRay})+","+String:C10($aBoxWidth{$incRay})+","+String:C10($aBoxHeight{$incRay})+","+$aMessPreBor{$incRay}+$aMessBorder{$incRay}+","+$aMessRest{$incRay}
				End for 
				//If ($cntRay>0)
				//If (($forceFrame>0)&(Num($aMessBorder{1})=0))
				//$aMessBorder{1}:=String($forceFrame)
				//End if 
				//End if 
				//
				$thisStamp:=Qx_SetGroups($thisStamp)
				$stampInc:=(((aTmpReal4{$i}\$yIncrement)+1)*$yIncrement)
				If ($keyYPoint+$stampInc>$pageHeight)
					TRACE:C157
					$keyXPoint:=$vWideShell+$xIncrement+$xOffSet
					$maxX:=$keyXPoint+aTmpReal3{$i}
					$keyYPoint:=$yOffSet
					$yCounter:=1
				Else 
					$keyYPoint:=$keyYPoint+$stampInc
					
				End if 
			End if 
			vText1:=vText1+$thisStamp
		End for 
		If (vHere<2)
			UNLOAD RECORD:C212([WorkOrder:66])
			UNLOAD RECORD:C212([Customer:2])
		End if 
		SET TEXT TO PASTEBOARD:C523(vText1)
		//SEND PACKET(myDoc;vText1)
		//CLOSE DOCUMENT(myDoc)
		//  
		//If ((Is macOS)&($template#""))
		vText9:=$myDocName
		vText8:=Txt_jitConvert([TallyResult:73]textBlk1:5)
		//TRACE
		// vi2:=AppleScript(vText8;"")
		If (OptKey=1)
			SET TEXT TO PASTEBOARD:C523(vText8)
		End if 
		//End if 
	End if 
End if 