//Script: pQtyShip
//October 6, 1995
C_TEXT:C284(pCalQty)

C_LONGINT:C283($i; $doChange; $addCnt; $k; $workingLineNum)
C_TEXT:C284($tempSrlNum)
If (Size of array:C274(aRayLines)>0)
	$k:=Size of array:C274(aRayLines)
	//TRACE
	For ($i; 1; $k)
		$workingLineNum:=aRayLines{$i}
		Case of 
			: (([Invoice:26]orderNum:1#1) & (((aiQtyRemain{$workingLineNum}<0) & (pQtyShip>0)) | ((aiQtyRemain{$workingLineNum}>0) & (pQtyShip<0))))
				If ((Size of array:C274(aRayLines)=1) | (Size of array:C274(aRayLines)=$i))
					pQtyShip:=aiQtyRemain{$workingLineNum}
					BEEP:C151
				End if 
				//no action, mixing signs
			: ((<>vbDoSrlNums) & ($workingLineNum>0) & (aiSerialRc{$workingLineNum}><>ciSRNotSerialized))
				aiQtyShip{$workingLineNum}:=Srl_IssueDialog($workingLineNum; ->pPartNum; ->aiSerialRc{$workingLineNum}; ->aiSerialNm{$workingLineNum}; pQtyShip)  //search for serials 
				pQtyShip:=aiQtyShip{$workingLineNum}
				$doChange:=1
			: ((aiPQDIR{$workingLineNum}>-1) & ([Invoice:26]orderNum:1=1) & (aiPricePt{$workingLineNum}#"*"))
				aiQtyShip{$workingLineNum}:=pQtyShip
				If (<>vbItemBundle)
					aiQtyShip{$workingLineNum}:=Item_BundleCheck(aiItemNum{$workingLineNum}; aiQtyShip{$workingLineNum})
				End if 
				pQtyOrd:=aiQtyShip{$workingLineNum}  //used in next procedure to calc discount
				QtyOrd_PriceQty($workingLineNum; ->aiPQDIR; ->aiQtyOpen; ->aiItemNum; ->aiUnitPrice; ->aiDiscnt; ->aiSalesRate; ->aiRepRate)
				$doChange:=1
			: ([Invoice:26]orderNum:1=1)
				aiQtyShip{$workingLineNum}:=pQtyShip
				If (<>vbItemBundle)
					aiQtyShip{$workingLineNum}:=Item_BundleCheck(aiItemNum{$workingLineNum}; aiQtyShip{$workingLineNum})
				End if 
				aiQtyOrder{$workingLineNum}:=aiQtyShip{$workingLineNum}
				$doChange:=1
			Else   //normal condition        
				//directily entered new line (POS or w/o order line
				aiQtyShip{$workingLineNum}:=pQtyShip
				If (<>vbItemBundle)
					aiQtyShip{$workingLineNum}:=Item_BundleCheck(aiItemNum{$workingLineNum}; aiQtyShip{$workingLineNum})
				End if 
				$doChange:=1
		End case 
		If (($doChange=1) | ($k>1))  //if running loop, else it is done in the during phase
			IvcLnExtend($workingLineNum)
		End if 
	End for 
	pQtyOrd:=aiQtyRemain{aRayLines{1}}  //-pQtyShip
	vLineMod:=True:C214
End if 