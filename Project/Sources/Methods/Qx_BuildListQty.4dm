//%attributes = {"publishedWeb":true}
//Method: Qx_BuildListQty

C_TEXT:C284($myDocName)
C_LONGINT:C283($1; $cntUnits)
//
C_TEXT:C284($theSource)
C_BOOLEAN:C305($doBasic)
$doBasic:=False:C215
$cntShell:=0
//TRACE


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

//$myDocName:=Storage.folder.jitF+"QuarkPost\"+String(DateTime_Enter)+".txt"
// myDoc:=create document($myDocName;"")
ARRAY REAL:C219(aTmpReal1; 0)  //Left
ARRAY REAL:C219(aTmpReal2; 0)  //Top
ARRAY REAL:C219(aTmpReal3; 0)  //Wide
ARRAY REAL:C219(aTmpReal4; 0)  //Tall
ARRAY REAL:C219(aTmpReal5; 0)  //CenterRight
ARRAY REAL:C219(aTmpReal6; 0)  //CenterTall
ARRAY REAL:C219(aTmpReal7; 0)  //MostRight
ARRAY REAL:C219(aTmpReal8; 0)  //MostLow
ARRAY LONGINT:C221(aTmpLong1; 0)  //RecNum
$k:=Records in selection:C76([WorkOrder:66])
ORDER BY:C49([WorkOrder:66]; [WorkOrder:66]woNum:29)
FIRST RECORD:C50([WorkOrder:66])
For ($i; 1; $k)
	If (Count parameters:C259>0)
		$cntUnits:=$1
	Else 
		$cntUnits:=[WorkOrder:66]qtyOrdered:13
	End if 
	If ($cntUnits>0)
		$pT:=Position:C15("<&tbu2"; [WorkOrder:66]description:3)
		$pP:=Position:C15("<&pbu2"; [WorkOrder:66]description:3)
		If (($pT>0) | ($pP>0))
			$sendText:=""
			$workingText:=[WorkOrder:66]description:3
			ARRAY TEXT:C222($aMessage; 0)
			ARRAY TEXT:C222($aMessPreBor; 0)
			ARRAY REAL:C219($aLeftX; 0)
			ARRAY REAL:C219($aLeftY; 0)
			ARRAY REAL:C219($aRightX; 0)
			ARRAY REAL:C219($aRightY; 0)
			$dropOut:=False:C215
			Repeat 
				$pT:=Position:C15("<&tbu2"; $workingText)
				$pP:=Position:C15("<&pbu2"; $workingText)
				If (($pT=0) & ($pP=0))
					$dropOut:=True:C214
				Else   // : (($pP>0)|($pT>0))//&($pP=0)))//
					$w:=Size of array:C274($aLeftX)+1
					INSERT IN ARRAY:C227($aMessage; $w)
					INSERT IN ARRAY:C227($aLeftX; $w)
					INSERT IN ARRAY:C227($aLeftY; $w)
					INSERT IN ARRAY:C227($aRightX; $w)
					INSERT IN ARRAY:C227($aRightY; $w)
					
					If ((($pT<$pP) & ($pP>0) & ($pT>0)) | (($pT>0) & ($pP=0)))
						$pEnd:=Position:C15("<&te>"; $workingText)
						$aMessage{$w}:=Substring:C12($workingText; $pT; $pEnd+4)
						$workingText:=Substring:C12($workingText; $pEnd+5)
					Else 
						//TRACE            
						$pEnd:=Position:C15(">"; $workingText)
						$aMessage{$w}:=Substring:C12($workingText; $pP; $pEnd)
						$workingText:=Substring:C12($workingText; $pEnd+1)
						$splitMess:=$aMessage{$w}
					End if 
					$splitMess:=$aMessage{$w}
					$p:=Position:C15("("; $splitMess)
					
					$splitMess:=Substring:C12($splitMess; $p+1)
					$p:=Position:C15(","; $splitMess)
					$aLeftX{$w}:=Num:C11(Substring:C12($splitMess; 1; $p-1))
					$splitMess:=Substring:C12($splitMess; $p+1)
					$p:=Position:C15(","; $splitMess)
					$aLeftY{$w}:=Num:C11(Substring:C12($splitMess; 1; $p-1))
					$splitMess:=Substring:C12($splitMess; $p+1)
					$p:=Position:C15(","; $splitMess)
					$aRightX{$w}:=Num:C11(Substring:C12($splitMess; 1; $p-1))+$aLeftX{$w}
					$splitMess:=Substring:C12($splitMess; $p+1)
					$p:=Position:C15(","; $splitMess)
					$aRightY{$w}:=Num:C11(Substring:C12($splitMess; 1; $p-1))+$aLeftY{$w}
				End if   //case 
			Until ($dropOut)
			$wRay:=Size of array:C274(aTmpReal1)+1
			INSERT IN ARRAY:C227(aTmpReal1; $wRay; 1)  //Left
			INSERT IN ARRAY:C227(aTmpReal2; $wRay; 1)  //Top
			INSERT IN ARRAY:C227(aTmpReal3; $wRay; 1)  //Wide
			INSERT IN ARRAY:C227(aTmpReal4; $wRay; 1)  //Tall
			INSERT IN ARRAY:C227(aTmpReal5; $wRay; 1)  //CenterRight
			INSERT IN ARRAY:C227(aTmpReal6; $wRay; 1)  //CenterTall
			INSERT IN ARRAY:C227(aTmpReal7; $wRay; 1)  //MostRight
			INSERT IN ARRAY:C227(aTmpReal8; $wRay; 1)  //MostLow
			INSERT IN ARRAY:C227(aTmpLong1; $wRay; 1)  //RecNum
			C_REAL:C285($mostLeft; $mostRight; $mostHigh; $mostLow)
			SORT ARRAY:C229($aLeftX)  //;$aLeftY;$aRightX;$aRightY)
			$mostLeft:=$aLeftX{1}  //Most Left Point
			SORT ARRAY:C229($aRightX)  //;$aLeftY;$aLeftX;$aRightY)
			$mostRight:=$aRightX{Size of array:C274($aRightX)}  //Most Right Point
			SORT ARRAY:C229($aLeftY)  //;$aRightX;$aLeftX;$aRightY)
			$mostTop:=$aLeftY{1}  //Most Top Point
			SORT ARRAY:C229($aRightY)  //;$aLeftY;$aRightX;$aLeftX)
			$mostLow:=$aRightY{Size of array:C274($aRightX)}  //Most Right Point
			//
			aTmpReal1{$wRay}:=$mostLeft
			aTmpReal2{$wRay}:=$mostTop
			aTmpReal3{$wRay}:=$mostRight-$mostLeft  //width
			aTmpReal4{$wRay}:=$mostLow-$mostTop  //height
			aTmpReal5{$wRay}:=($mostRight-$mostLeft)/2  //width
			aTmpReal6{$wRay}:=($mostLow-$mostTop)/2  //height
			aTmpReal7{$wRay}:=$mostRight
			aTmpReal8{$wRay}:=$mostLow
			aTmpLong1{$wRay}:=Record number:C243([WorkOrder:66])
		End if 
		If ($cntUnits>1)
			C_LONGINT:C283($incDup; $cntDup)
			$cntDup:=$cntUnits-1
			For ($incDup; 1; $cntDup)
				INSERT IN ARRAY:C227(aTmpReal1; $wRay; 1)  //Left
				INSERT IN ARRAY:C227(aTmpReal2; $wRay; 1)  //Top
				INSERT IN ARRAY:C227(aTmpReal3; $wRay; 1)  //Wide
				INSERT IN ARRAY:C227(aTmpReal4; $wRay; 1)  //Tall
				INSERT IN ARRAY:C227(aTmpReal5; $wRay; 1)  //CenterRight
				INSERT IN ARRAY:C227(aTmpReal6; $wRay; 1)  //CenterTall
				INSERT IN ARRAY:C227(aTmpReal7; $wRay; 1)  //MostRight
				INSERT IN ARRAY:C227(aTmpReal8; $wRay; 1)  //MostLow
				INSERT IN ARRAY:C227(aTmpLong1; $wRay; 1)  //RecNum
				aTmpReal1{$wRay}:=$mostLeft
				aTmpReal2{$wRay}:=$mostTop
				aTmpReal3{$wRay}:=$mostRight-$mostLeft  //width
				aTmpReal4{$wRay}:=$mostLow-$mostTop  //height
				aTmpReal5{$wRay}:=($mostRight-$mostLeft)/2  //width
				aTmpReal6{$wRay}:=($mostLow-$mostTop)/2  //height
				aTmpReal7{$wRay}:=$mostRight
				aTmpReal8{$wRay}:=$mostLow
				aTmpLong1{$wRay}:=Record number:C243([WorkOrder:66])
			End for 
		End if 
	End if 
	NEXT RECORD:C51([WorkOrder:66])
End for 
UNLOAD RECORD:C212([TallyResult:73])