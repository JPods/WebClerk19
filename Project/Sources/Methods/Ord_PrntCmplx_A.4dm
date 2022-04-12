//%attributes = {"publishedWeb":true}
//Procedure: Ord_PrntCmplx
If (((vHere>1) & (ptCurTable=(->[Order:3]))) | ((ptCurTable=(->[UserReport:46])) & ([UserReport:46]tableNum:3=3)))
	C_LONGINT:C283($i; $k; $w; $incBOM; $cntBOM)
	ARRAY TEXT:C222($aItemNum; 0)
	ARRAY TEXT:C222($aitemDesc; 0)
	ARRAY REAL:C219($aitemQty; 0)
	ARRAY TEXT:C222($aitemCmt; 0)
	//acceptOrders 
	$k:=0
	QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)  //get the order lines
	$k:=Records in selection:C76([OrderLine:49])
	ORDER BY:C49([OrderLine:49]seq:30)
	SELECTION TO ARRAY:C260([OrderLine:49]; aTmpLong1)
	OrdLnFillRays
	ARRAY LONGINT:C221(aTmpLong2; $k)
	For ($i; 1; $k)
		aTmpLong2{$i}:=Table:C252(->[OrderLine:49])
		GOTO RECORD:C242([OrderLine:49]; aTmpLong1{$i})
		// SEARCH([BOM];[BOM]ItemNum=[OrdLine]ItemNum)//get the BOM items
		//  Bom_FillArray (Records in selection([BOM]))
		BOM_BuildExtend([OrderLine:49]itemNum:4)
		$cntBom:=Size of array:C274(aRptPartNum)
		For ($incBOM; 1; $cntBOM)
			$w:=Find in array:C230($aItemNum; aRptPartNum{$incBOM})
			If ($w=-1)
				$w:=Size of array:C274($aItemNum)+1
				INSERT IN ARRAY:C227($aItemNum; $w; 1)
				INSERT IN ARRAY:C227($aitemDesc; $w; 1)
				INSERT IN ARRAY:C227($aitemQty; $w; 1)
				INSERT IN ARRAY:C227($aitemCmt; $w; 1)
				$aItemNum{$w}:=aRptPartNum{$incBOM}
				$aitemDesc{$w}:=aRptPartDsc{$incBOM}
				$aitemCmt{$w}:=aBomCmt{$incBOM}
			End if 
			$aitemQty{$w}:=$aitemQty{$w}+(aQtyAct{$incBOM}*[OrderLine:49]qty:6)
		End for 
	End for 
	//SEARCH([ItemXRef];[ItemXRef]ItemNum=[Item]ItemNum)
	//vText1:=""
	//FIRST RECORD([ItemXRef])
	//For ($i;1;5)
	//vText1:=vText1+[ItemXRef]Site
	//NEXT RECORD([ItemXRef])
	//End for 
	REDUCE SELECTION:C351([ItemXRef:22]; 0)
	Bom_FillArray(0)
	COPY ARRAY:C226($aItemNum; aRptPartNum)
	COPY ARRAY:C226($aitemDesc; aRptPartDsc)
	COPY ARRAY:C226($aitemQty; aQtyAct)
	COPY ARRAY:C226($aitemCmt; aBomCmt)
	SORT ARRAY:C229(aRptPartNum; aRptPartDsc; aQtyAct; aBomCmt)
	$k:=Size of array:C274(aRptPartNum)
	ARRAY TEXT:C222(aBOMLoc; $k)
	//  ARRAY TEXT(aText1;$k)
	For ($i; $k; 1; -1)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=aRptPartNum{$i})
		$w:=Find in array:C230(aOItemNum; aRptPartNum{$i})
		If (($w=-1) & ([Item:4]profile2:36="Finish@"))
			$w:=Size of array:C274(aoLineAction)+1
			OrdLn_RaySize(1; $w; 1)
			aOItemNum{$w}:=[Item:4]itemNum:1
			aODescpt{$w}:=[Item:4]description:7
		End if 
		If ([Item:4]profile2:36="Finish@")
			DELETE FROM ARRAY:C228(aRptPartNum; $i; 1)
			DELETE FROM ARRAY:C228(aRptPartDsc; $i; 1)
			DELETE FROM ARRAY:C228(aQtyAct; $i; 1)
			DELETE FROM ARRAY:C228(aBomCmt; $i; 1)
			DELETE FROM ARRAY:C228(aBOMLoc; $i; 1)
		Else 
			C_LONGINT:C283($incXref; $cntXref)
			QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumMaster:1=aRptPartNum{$i})
			$cntXref:=Records in selection:C76([ItemXRef:22])
			FIRST RECORD:C50([ItemXRef:22])
			For ($incXref; 1; $cntXref)
				aBOMLoc{$i}:=aBOMLoc{$i}+[ItemXRef:22]siteID:11+","
				NEXT RECORD:C51([ItemXRef:22])
			End for 
		End if 
	End for 
	UNLOAD RECORD:C212([ItemSpec:31])
	UNLOAD RECORD:C212([ItemXRef:22])
	//
	//
	$k:=Size of array:C274(aOItemNum)
	C_TEXT:C284($qty; $itemNum; $itemDescp; $comment; $location)
	vText1:=""
	For ($i; 1; $k)
		$qty:=String:C10(aOQtyOrder{$i}; "##,###,###.###")
		$qty:=((11-Length:C16($qty))*".")+$qty+(5*" ")
		$itemNum:=aOItemNum{$i}+((37-Length:C16(aOItemNum{$i}))*" ")
		$itemDescp:=Substring:C12(aODescpt{$i}; 1; 70)  //Substring(aODescpt{$i}1;80)
		vText1:=vText1+$qty+$itemNum+$itemDescp+"\r"
	End for 
	vText1:=vText1+"\r"+"\r"+(80*"/")+"\r"+"\r"
	//
	$k:=Size of array:C274(aQtyAct)
	C_TEXT:C284($qty; $itemNum; $itemDescp; $comment; $location)
	vText2:=""
	$numSpace:=0
	For ($i; 1; $k)
		$qty:=String:C10(aQtyAct{$i}; "##,###,###.###")
		$qty:=((11-Length:C16($qty))*" ")+$qty+(3*" ")
		$numSpace:=37-Length:C16(aRptPartNum{$i})
		
		$itemNum:=aRptPartNum{$i}+((37-Length:C16(aRptPartNum{$i}))*".")
		//ALERT($itemNum+": "+String(Length($itemNum)))
		$itemDescp:=(5*".")+aRptPartDsc{$i}
		$comment:=(5*".")+Substring:C12(aBOMCmt{$i}; 1; 82)
		$location:=(5*".")+Substring:C12(aBomLoc{$i}; 1; 82)
		vText2:=vText2+$qty+$itemNum+"\r"+$itemDescp+"\r"+$comment+"\r"+$location+"\r"+"\r"
	End for 
	vText2:=vText2+"\r"+"\r"+(80*"/")+"\r"+"\r"
	SET TEXT TO PASTEBOARD:C523(vText2)
	//
	//
	QUERY:C277([Requisition:83]; [Requisition:83]idNumOrder:4=[Order:3]idNum:2; *)
	QUERY:C277([Requisition:83];  & [Requisition:83]status:47="Requisition")
	//SORT SELECTION([Requisition]DTNeeded;"<")
	Rq_FillArrays(Records in selection:C76([Requisition:83]))
	$k:=Size of array:C274(aRqItem)
	C_TEXT:C284($qty; $itemNum; $itemDescp; $nameID; $action)
	C_DATE:C307($theDate)
	vText3:=""
	TRACE:C157
	For ($i; 1; $k)
		$qty:=String:C10(aRqQty{$i}; "##,###,###.###")
		$qty:=((12-Length:C16($qty))*".")+$qty+(5*".")
		$itemNum:=aRqItem{$i}+((20-Length:C16(aRqItem{$i}))*".")
		$itemDescp:=aRqItemDesc{$i}
		$action:=Substring:C12(aRqAction{$i}; 1; 18)
		$action:=$action+((20-Length:C16($action))*".")
		$nameID:=Substring:C12(aRqNameID{$i}; 1; 18)
		$theDate:=([Requisition:83]dtNeeded:6\86400)+!1990-01-01!
		$nameID:=$nameID+((20-Length:C16($nameID))*".")+(".....")+String:C10(aRqNeed{$i}; 1)
		vText3:=vText3+$qty+$itemNum+$action+$nameID+"\r"+(5*".")+$itemDescp+"\r"+"\r"
	End for 
	vText3:=vText3+"\r"+"\r"+(80*"/")+"\r"+"\r"
	//
	TaskIDAssign(->[Order:3]idNumTask:85)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNumTask:22=[Order:3]idNumTask:85)  //get list of workorders
	ORDER BY:C49([WorkOrder:66]; [WorkOrder:66]codeID:25; [WorkOrder:66]seq:26)
	WO_FillArrays(Records in selection:C76([WorkOrder:66]))
	$k:=Size of array:C274(aWoRecNum)
	C_TEXT:C284($dateStr; $timeStr; $nameID; $activityID)
	vText4:=""
	For ($i; 1; $k)
		$codeID:=String:C10(aWoNature{$i})+(((10-Length:C16(String:C10(aWoNature{$i}; 1)))+2)*".")
		$dateStr:=String:C10(aWoDateNd{$i}; 1)+(((10-Length:C16(String:C10(aWoDateNd{$i}; 1)))+2)*".")
		$timeStr:=String:C10(Time:C179(Time string:C180(aWoTimeNd{$i})); 5)
		$timeStr:=$timeStr+((12-Length:C16($timeStr))*".")
		vText4:=vText4+$codeID+$dateStr+$timeStr+Uppercase:C13(aWoNameID{$i})+((28-Length:C16(aWoNameID{$i}))*".")+Uppercase:C13(aWoActivity{$i})+"\r"+"\r"+aWoDescrpt{$i}+"\r"+"\r"+(80*"*")+"\r"+"\r"
	End for 
	//
	vText10:="FINISHED GOODS:  "+"\r"+"\r"+vText1+"BOMS:"+"\r"+"\r"+vText2+vText2+"REQUISITIONS:"+"\r"+"\r"+vText3+"WORK ORDERS"+"\r"+"\r"+vText4
	//
	If (eOrdWos>0)
		//  --  CHOPPED  AL_UpdateArrays(eOrdWos; -2)
	End if 
Else 
	ALERT:C41("You must be in an order to print this report.")
End if 