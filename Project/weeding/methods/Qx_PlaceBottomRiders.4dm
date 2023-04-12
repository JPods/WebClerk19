//%attributes = {"publishedWeb":true}
//Method: Qx_PlaceBottomRiders
If (False:C215)
	//02/10/03.prf
	//removed plugin S7P
	//  TCStrong_prf_v144
	TCStrong_prf_v144_S7P
End if 

C_TEXT:C284($1; $theSource)
C_BOOLEAN:C305($doBasic)
//
If (Size of array:C274(aTmpReal3)=0)
	ALERT:C41("No Quantity to process.")
Else 
	//C_TEXT($thePath)
	
	C_REAL:C285($vWideShell; $vTallShell; $yShellOne; $yRiderOff)
	//TRACE
	$countLabels:=0
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
	$setAppleEvents:=False:C215
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
			C_LONGINT:C283($labelsInCol; $numCols)
			C_BOOLEAN:C305($setAppleEvents)
			$labelsInCol:=[TallyResult:73]longint1:7
			If ($labelsInCol=0)
				$labelsInCol:=6
			End if 
			// Modified by: Bill James (2022-12-09T06:00:00Z)
			// mush fix and adjust to data type and object
			
			//$numCols:=[TallyResult]report
			$setAppleEvents:=(([TallyResult:73]real11:47#0) & ([TallyResult:73]textBlk1:5#"") & (Is macOS:C1572))
			Case of 
				: (([TallyResult:73]real12:48#0) & ($setAppleEvents))
					TRACE:C157
				: ([TallyResult:73]real12:48#0)
					$numCols:=12
				: ($numCols=0)
					$numCols:=2
			End case 
			$byWhom:=[TallyResult:73]textBlk2:6
			$theAppleScript:=[TallyResult:73]textBlk1:5
			$maxWidth:=0
			$doBasic:=False:C215
			UNLOAD RECORD:C212([TallyResult:73])
		End if 
	Else 
		ALERT:C41("Using Defaults, no TallyResult record.")
	End if 
	
	C_REAL:C285($xMinPoint; $yMinPoint)
	//
	If ($doBasic)
		$labelOffSet:=0
		$xOffSet:=20
		$yOffSet:=20
		$xIncrement:=220
		$yIncrement:=34
		$pageWidth:=560
		$pageHeight:=710
		$maxWidth:=0
		$forceFrame:=0
		$theAppleScript:=""
		$byWhom:=""
		$labelsInCol:=6
		$numCols:=2
		//
		$vWideShell:=300
		$vTallShell:=200
		$xRiderOff:=20
		$yRiderOff:=20
	End if 
	ARRAY REAL:C219($aXShell; 0)
	ARRAY REAL:C219($aYShell; 0)
	ARRAY TEXT:C222($aShellBeg; 0)
	ARRAY TEXT:C222($aShellMess; 0)
	//TRACE
	If ($byWhom#"")  //define the riders
		$pT:=Position:C15("<&tbu2"; $byWhom)
		While ($pT>0)
			$vBaseStr:=""
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
			//
			$pBase:=Position:C15("jitBase="; $splitMess)
			If ($pBase>0)
				$vBaseStr:=Substring:C12($splitMess; $p+1)
				$p:=Position:C15(","; $vBaseStr)
				$vWideShell:=Num:C11(Substring:C12($vBaseStr; 1; $p-1))  //width of the horizonal piece
				$vBaseStr:=Substring:C12($vBaseStr; $p+1)
				$p:=Position:C15(","; $vBaseStr)
				$vTallShell:=Num:C11(Substring:C12($vBaseStr; 1; $p-1))  //height of the horizontal priece
				$pBase:=Position:C15("jitBase=Top"; $splitMess)
				$xRiderOff:=$vWideShell/2
				//TRACE
				If ($pBase>0)
					$yRiderOff:=$labelOffSet  //($vTallShell)//
				Else 
					$yRiderOff:=-$labelOffSet
				End if 
			End if 
			//
			$pT:=Position:C15("<&tbu2"; $byWhom)
		End while 
		$cntShell:=Size of array:C274($aXShell)
	End if   //end of rider definition
	C_REAL:C285($keyXPoint; $keyYPoint)
	$keyXPoint:=$xOffSet
	$keyYPoint:=$yOffSet
	C_LONGINT:C283($i; $textBlk; $picBlk; $intText)
	C_TEXT:C284($theOut)
	C_LONGINT:C283($numCols; $widthCol; $pT; $pP; $pEnd; $p)
	C_REAL:C285($xOffSet; $yOffSet)
	C_TEXT:C284($byWhom; $workingText; $thisPageData; $allPageData)
	$thisPageData:=""
	$xCounter:=0
	C_TEXT:C284($myDocName; $thisStamp)
	//
	//$myDocName:=Storage.folder.jitF+"QuarkPost\"+String(DateTime_DTTo)+".txt"
	//myDoc:=create document($myDocName;"")
	//
	//TRACE
	If (OK=1)
		$yCounter:=1
		$xCounter:=1
		
		//ArraySort(aTmpLong1;">";aTmpReal3;"<";aTmpReal1;"=";aTmpReal2;"=";aTmpReal4;"=")
		MULTI SORT ARRAY:C718(aTmpLong1; >; aTmpReal3; <; aTmpReal1; aTmpReal2; aTmpReal4)
		
		$maxX:=aTmpReal3{1}+$xIncrement
		$maxY:=aTmpReal4{1}
		$k:=Size of array:C274(aTmpLong1)
		$cntY:=$yOffSet
		C_LONGINT:C283($countLabels; $countCols)
		$countLabels:=0
		$countCols:=1
		For ($i; 1; $k)  //do each lable
			$countLabels:=$countLabels+1
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
						If ((($pT<$pP) & ($pP>0) & ($pT>0)) | (($pT>0) & ($pP=0)))
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
				If ($labelOffSet>0)
					
					
				End if 
				Case of 
					: ($countLabels>$labelsInCol)
						$countLabels:=0
						$countCols:=$countCols+1
						$keyXPoint:=$maxX+$xIncrement
						$maxX:=$keyXPoint+aTmpReal3{1}
						$keyYPoint:=$yOffSet  //+$yIncrement
						If (($countCols>$numCols) & ([TallyResult:73]real12:48=0))
							C_TEXT:C284($tempName)
							
							If ($setAppleEvents)
								
								ALERT:C41("AppleScript disabled - method Qx_PlaceBottomRiders")
								
								//02/10/03.prf
								
								If (False:C215)
									C_TEXT:C284($tempName; $thePageData)
									$thePageData:=$thisPageData
									SET TEXT TO PASTEBOARD:C523($thisPageData)
									$temName:="DoQuark"+Substring:C12([WorkOrder:66]itemNum:12; 1; 3)+Date_strYrMmDd(Current date:C33; 1)+".txt"
									sumDoc:=EI_UniqueDoc(Storage:C1525.folder.jitExportsF+$tempName)
									$countCols:=1
									SEND PACKET:C103(sumDoc; $thisPageData)
									CLOSE DOCUMENT:C267(sumDoc)
									vText9:=document
									vText8:=Txt_jitConvert($theAppleScript)
									//TRACE
									//vi2:=AppleScript (vText8;"")//02/10/03.prf
								End if 
								
							Else 
								$temName:="DoQuark"+Substring:C12([WorkOrder:66]itemNum:12; 1; 3)+Date_strYrMmDd(Current date:C33; 1)+".txt"
								sumDoc:=EI_UniqueDoc(Storage:C1525.folder.jitExportsF+$tempName)
								$countCols:=1
								SEND PACKET:C103(sumDoc; $thisPageData)
								CLOSE DOCUMENT:C267(sumDoc)
							End if 
							//$allPageData:=$allPageData+$thisPageData  //added at each stamp
							$thisPageData:=""
							$yCounter:=1
							$xCounter:=1
							$maxX:=aTmpReal3{1}+$xIncrement
							$maxY:=aTmpReal4{1}
							$cntY:=$yOffSet
							$countLabels:=0
							$countCols:=1
						End if 
				End case 
				//
				If ($cntShell>0)  //build up the shell for this stamp
					For ($incShell; 1; $cntShell)
						$XShellSet:=$keyXPoint+$aXShell{$incShell}
						$YShellSet:=$keyYPoint+$aYShell{$incShell}
						$thisStamp:=$thisStamp+$aShellBeg{$incShell}+String:C10($keyXPoint+$aXShell{$incShell})+","+String:C10($keyYPoint+$aYShell{$incShell})+","+$aShellMess{$incShell}
					End for 
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
					p_Phone:=Format_Phone([Customer:2]phone:13)
					QUERY:C277([Employee:19]; [Employee:19]nameID:1=[WorkOrder:66]actionBy:8)
					$thisStamp:=Txt_jitConvert($thisStamp)
				End if 
				//
				C_REAL:C285($xShellOne; $yShellOne)
				If (Size of array:C274($aXShell)=0)
					$xShellOne:=200  //should be half width of the widest
					$yShellOne:=0
				Else 
					$xShellOne:=0  //$aXShell{1}
					$yShellOne:=0  //$aYShell{1}-7
				End if 
				//$keyYPoint = Add to each piece to move down page
				//($aBoxY{$incRay}-aTmpReal4{$i}) = keep pieces aligned, order important below
				//($aBoxY{$incRay}-aTmpReal2{1}) = keep pieces aligned, order important above
				//+$vTallShell = thickness of the horizontal piece of label
				If ($labelOffSet>0)  //lable on top of stamp//$aXShell{$incRay}  changed from $xShellOne
					For ($incRay; 1; $cntRay)
						$aBoxX{$incRay}:=$keyXPoint+($vWideShell/2)-(aTmpReal3{$i}/2)+$aBoxX{$incRay}-aTmpReal1{$i}+$xShellOne+5
						$aBoxY{$incRay}:=$keyYPoint+($aBoxY{$incRay}-aTmpReal2{1})+$vTallShell+$labelOffSet
						$thisStamp:=$thisStamp+$aMessStart{$incRay}+String:C10($aBoxX{$incRay})+","+String:C10($aBoxY{$incRay})+","+String:C10($aBoxWidth{$incRay})+","+String:C10($aBoxHeight{$incRay})+","+$aMessPreBor{$incRay}+$aMessBorder{$incRay}+","+$aMessRest{$incRay}
					End for 
				Else 
					//TRACE
					//$yShellOne:=$aYShell{1}-7
					For ($incRay; 1; $cntRay)
						$aBoxX{$incRay}:=$keyXPoint+($vWideShell/2)-(aTmpReal3{$i}/2)+$aBoxX{$incRay}-aTmpReal1{$i}+$xShellOne+3
						//$aBoxY{$incRay}:=$YShellSet-aTmpReal4{$i}+($aBoxY{$incRay}
						//-$aBoxHeight{$incRay})+$labelOffSet//
						
						
						$aBoxY{$incRay}:=$YShellSet+$aBoxY{$incRay}-aTmpReal2{$i}-aTmpReal4{$i}+$labelOffSet
						
						//$aBoxY{$incRay}:=$YShellSet-$aBoxY{$incRay}
						//+$aBoxHeight{$incRay}-aTmpReal2{$i}+$labelOffSet
						
						//$aBoxY{$incRay}:=$YShellSet-($aBoxY{$incRay}-aTmpReal2{1})
						//+$labelOffSet
						
						$thisStamp:=$thisStamp+$aMessStart{$incRay}+String:C10($aBoxX{$incRay})+","+String:C10($aBoxY{$incRay})+","+String:C10($aBoxWidth{$incRay})+","+String:C10($aBoxHeight{$incRay})+","+$aMessPreBor{$incRay}+$aMessBorder{$incRay}+","+$aMessRest{$incRay}
					End for 
				End if 
				$thisStamp:=Qx_SetGroups($thisStamp)
				$keyYPoint:=$keyYPoint+((aTmpReal4{$i}\$yIncrement)*$yIncrement)+$yIncrement
				//If ($cntRay>0)
				//If (($forceFrame>0)&(Num($aMessBorder{1})=0))
				//$thisStamp:=$thisStamp+$aMessStart{$incRay}+String
				//($aBoxX{$incRay})+","+String($aBoxY{$incRay})+","+String
				//($aBoxWidth{$incRay})+","+String($aBoxHeight{$incRay})+","
				//+$aMessPreBor{$incRay}+$aMessBorder{$incRay}+","+$aMessRest{$incRay}
				//End if 
				//End if 
				//
				
			End if 
			$thisPageData:=$thisPageData+$thisStamp
			$allPageData:=$allPageData+$thisStamp
		End for 
		
		
		
		zzz:=0
		SET TEXT TO PASTEBOARD:C523($allPageData)
		
		If (vHere<2)
			UNLOAD RECORD:C212([WorkOrder:66])
			UNLOAD RECORD:C212([Customer:2])
		End if 
		//SEND PACKET(myDoc;$thisPageData)
		//CLOSE DOCUMENT(myDoc)
		//  
		
	End if 
End if 
UNLOAD RECORD:C212([Customer:2])
UNLOAD RECORD:C212([Employee:19])
