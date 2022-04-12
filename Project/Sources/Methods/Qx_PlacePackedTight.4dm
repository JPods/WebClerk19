//%attributes = {"publishedWeb":true}
//Method: Qx_PlacePackedTight

C_TEXT:C284($1; $theSource)
C_BOOLEAN:C305($doBasic)
If (Size of array:C274(aTmpReal3)=0)
	ALERT:C41("No Quantity to process.")
Else 
	$doBasic:=True:C214
	$cntShell:=0
	$cntY:=0
	vText2:=""
	
	$vBorderEnd:=",0,0,,i,1,(K,n),(100,100),"+Char:C90(34)+"Solid"+Char:C90(34)+",n,100,(1,1,1,1),1,0,1,0,,c,0,"+Char:C90(34)+"jitBorder"+Char:C90(34)+")><&te>"
	
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
			$byWhom:=""
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
		$forceFrame:=1
		$template:=""
		$numCol:=2
		$byWhom:=""
	End if 
	C_REAL:C285($minXPoint; $minYPoint)
	C_REAL:C285($vWideStamp; $vTallStamp)
	$minXPoint:=0
	$minYPoint:=0
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
	C_TEXT:C284($myDocName)
	//
	//$myDocName:=Storage.folder.jitF+"QuarkPost\"+String(DateTime_Enter)+".txt"
	//myDoc:=create document($myDocName;"")
	//
	If (OK=1)
		$yCounter:=1
		$xCounter:=1
		//ArraySort(aTmpReal3;"<";aTmpLong1;">";aTmpReal1;"=";aTmpReal2;"=";aTmpReal4;"=")
		MULTI SORT ARRAY:C718(aTmpReal3; <; aTmpLong1; >; aTmpReal1; aTmpReal2; aTmpReal4)
		$maxX:=aTmpReal3{1}+$xIncrement
		$maxY:=aTmpReal4{1}
		$k:=Size of array:C274(aTmpLong1)
		$cntY:=$yOffSet
		For ($i; 1; $k)
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
							//TRACE
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
				
				If ($keyYPoint+aTmpReal4{$i}>$pageHeight)
					$keyXPoint:=$maxX+$xIncrement
					$maxX:=$keyXPoint+aTmpReal3{$i}
					$keyYPoint:=$yOffSet
					$yCounter:=1
				Else 
					
				End if 
				//TRACE
				$grpCmd:=""
				For ($incRay; 1; $cntRay)
					$aBoxX{$incRay}:=$keyXPoint+$aBoxX{$incRay}-aTmpReal1{$i}
					$aBoxY{$incRay}:=$keyYPoint+$aBoxY{$incRay}-aTmpReal2{$i}
					$grpCmd:=$grpCmd+$aMessStart{$incRay}+String:C10($aBoxX{$incRay})+","+String:C10($aBoxY{$incRay})+","+String:C10($aBoxWidth{$incRay})+","+String:C10($aBoxHeight{$incRay})+","+$aMessPreBor{$incRay}+$aMessBorder{$incRay}+","+$aMessRest{$incRay}
					//If ($cntRay>1)
					//$grpCmd:=($grpCmd+","+String($incRay))*Num($cntRay>1)
					If (CmdKey=1)
						vText2:=vText2+String:C10($aBoxX{$incRay})+"\t"+String:C10($aBoxY{$incRay})
					End if 
				End for 
				If ($forceFrame>0)
					$grpCmd:="<&tbu2("+String:C10($keyXPoint-1)+","+String:C10($keyYPoint-1)+","+String:C10(aTmpReal3{$i}+2)+","+String:C10(aTmpReal4{$i}+2)+$vBorderEnd+$grpCmd
				End if 
				If (($cntRay>1) | ($forceFrame>0))  //group if more than one block
					$grpCmd:=Qx_SetGroups($grpCmd)
				End if 
				vText1:=vText1+$grpCmd
				$keyYPoint:=$keyYPoint+aTmpReal4{$i}+$yIncrement
			End if 
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
		//vText9:=$myDocName
		//vText8:=Txt_jitConvert ([TallyResult]TextBlk1)
		//TRACE
		//// vi2:=AppleScript (vText8;"")
		//If (OptKey=1)
		//SET TEXT TO CLIPBOARD(vText8)
		//End if 
		//End if 
	End if 
End if 