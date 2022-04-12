//%attributes = {"publishedWeb":true}
//Procedure: Ord_WFALCBExit
//January 2, 1996//TRACE
//called in AL Definitions
KeyModifierCurrent
C_BOOLEAN:C305($0)  //Entry Valid (True) or Entry Rejected (False)
C_LONGINT:C283($1)  //Area Name
C_LONGINT:C283($2)  //Action that Caused Entry Finished
$0:=True:C214
C_LONGINT:C283($col; $row)
C_BOOLEAN:C305(vbdTime; vbdMtls; vbdWos)
vbdTime:=False:C215
vbdMtls:=False:C215
vbdWos:=False:C215
C_LONGINT:C283(eWorkFlow; eOrdWos; eOrdTime; eOrdMtls; eCntWos)
Case of 
	: (($1=eWorkFlow) | ($1=eOrdWos) | ($1=eCntWos))
		//  CHOPPED  AL_GetCurrCell($1; $col; $row)
		READ WRITE:C146([WorkOrder:66])
		GOTO RECORD:C242([WorkOrder:66]; aWoRecNum{$row})
		WO_FillArrays(-4; $row)
		SAVE RECORD:C53([WorkOrder:66])
		UNLOAD RECORD:C212([WorkOrder:66])
		READ ONLY:C145([WorkOrder:66])
		//  --  CHOPPED  AL_UpdateArrays($1; -2)
		WOCalRefresh
		WO_ColorNameID
	: ($1=eOrdTime)
		//  CHOPPED  AL_GetCurrCell(eOrdTime; $col; $row)
		Case of 
			: (($col=7) | ($col=8))
				TC_TimeLapse(0; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
			: (($col=9) | ($col=10))
				TC_TimeLapse(1; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
			: ($col=11)
				TC_TimeLapse(2; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
		End case 
		GOTO RECORD:C242([Time:56]; aTCTimeRecs{$row})
		TC_FillArrays(-4; $row)
		SAVE RECORD:C53([Time:56])
		UNLOAD RECORD:C212([Time:56])
		//  --  CHOPPED  AL_UpdateArrays(eOrdTime; -2)
	: ($1=eOrdMtls)
		//  CHOPPED  AL_GetCurrCell(eOrdMtls; $col; $row)
		GOTO RECORD:C242([WODraw:68]; aWdRecNum{$row})
		MD_FillArrays(-4; $row)
		SAVE RECORD:C53([WODraw:68])
		UNLOAD RECORD:C212([WODraw:68])
		//  --  CHOPPED  AL_UpdateArrays(eOrdMtls; -2)
		//: ($1=eOrdWos)
		//If (OptKey=0)
		////  CHOPPED  AL_GetCurrCell (eOrdWos;$col;$row)
		//C_Longint($days)
		//$days:=0
		//Case of 
		//: ($col=4)
		////If (Size of array(aRayLines)>0)
		////If (Size of array(aoLineAction)>=aRayLines{1}))
		////$row:=$row+1
		////$sizeSelect:=Size of array(aWoStepLns)
		////For ($i;$row;$sizeSelect)
		////aWoLineRef{$i}:=aOLineNum{aRayLines{1}}
		////End for 
		////End if 
		////End if 
		//: (($col=9)|($col=10))
		//$sizeSelect:=Size of array(aWoSeq)
		//If ($col=9)
		//$row:=$row+1
		//End if 
		//For ($i;$row;$sizeSelect)
		//If ($i>1)
		//If (aWoLoad{$i}>10)
		//$days:=aWoLoad{$i}\10
		//End if 
		//aWoTimeNd{$i}:=aWoTimeNd{($i-1)}+(aWoLoad{$i}*3600)
		//If (aWoTimeNd{$i}>(24:00:00*1))
		//aWoTimeNd{$i}:=aWoTimeNd{$i}-24:00:00
		//$days:=$days+1
		//End if 
		//aWoDateNd{$i}:=aWoDateNd{$i}+$days
		//End if 
		//End for 
		//: ($col=8)
		//$sizeSelect:=Size of array(aWoSeq)
		//C_LONGINT($days)
		//C_DATE($theDate)
		//$theDate:=aWoDateNd{$row}
		//$row:=$row+1
		//For ($i;$row;$sizeSelect)
		//aWoDateNd{$i}:=$theDate
		//End for 
		//End case 
		//End if 
		////  --  CHOPPED  AL_UpdateArrays (eOrdWos;-2)
		// vbdWos:=True
		[Order:3]idNum:2:=[Order:3]idNum:2
End case 