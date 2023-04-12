//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/02/07, 01:00:50
// ----------------------------------------------------
// Method: OP_SelectOrder
// Description
// 
//
// Parameters
// ----------------------------------------------------
$goDirection:=0
$lastRec:=-1
ARRAY LONGINT:C221(aRayLines; 0)
//  CHOPPED$clickResult:=AL_GetSelect(eOpenOrds; aRayLines)
//  CHOPPED  AL_GetScroll(eOpenOrds; viVert; viHorz)
If (Count parameters:C259=1)
	C_LONGINT:C283($goDirection)
	$goDirection:=$1
	Case of 
		: ($goDirection=4)
			//selecting a list in the AL
		: ((Size of array:C274(aRayLines)=0) & (Size of array:C274(aOrdRecs)>0))
			ARRAY LONGINT:C221(aRayLines; 1)
			aRayLines{1}:=1
			$goDirection:=3
			aOrdRecs:=1
		: (Size of array:C274(aRayLines)=0)
			// drop out
		Else 
			If ($goDirection=1)  //up arrow
				If (aRayLines{1}>1)
					aRayLines{1}:=aRayLines{1}-1
				Else 
					aRayLines{1}:=Size of array:C274(aOrdRecs)
				End if 
			Else 
				If (aRayLines{1}<Size of array:C274(aOrdRecs))
					aRayLines{1}:=aRayLines{1}+1
				Else 
					aRayLines{1}:=1
				End if 
			End if 
			ARRAY LONGINT:C221(aRayLines; 1)
			aOrdRecs:=aRayLines{1}
	End case 
End if 
If ($goDirection=0)
	//$lastRec:=aOrdRecs{aRayLines{1}}  do not assign for clicked on
	aOrdRecs:=aRayLines{1}
End if 
//
If (Size of array:C274(aRayLines)>0)  //could be from a selection
	If ($goDirection#4)
		ARRAY LONGINT:C221(aRayLines; 1)  //select only the first element
	End if 
	GOTO RECORD:C242([Order:3]; aOrdRecs{aRayLines{1}})
	LOAD RECORD:C52([Order:3])
	If (Locked:C147([Order:3]))
		ALERT:C41("This order is locked by another user.  An invoice may not be created.")
		SET WINDOW TITLE:C213("LOCKED Order "+String:C10([Order:3]idNum:2; "0000-0000"))
	Else 
		SET WINDOW TITLE:C213("Selected Order "+String:C10([Order:3]idNum:2; "0000-0000"))
	End if 
	If ([Customer:2]customerID:1#[Order:3]customerID:1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
		C_REAL:C285($totalTest)
		$creditRisk:=((([Customer:2]balPastPeriod1:43+[Customer:2]balPastPeriod2:44+[Customer:2]balPastPeriod3:45)>25) | ([Customer:2]badCheck:34))
		If ($creditRisk)
			vCreditStat:="Risk"
			BEEP:C151  //PLAY("CreditCheck")
			OBJECT SET RGB COLORS:C628(*; "vCreditStat"; 15; 256*3)
		Else 
			vCreditStat:="Current"
			OBJECT SET RGB COLORS:C628(*; "vCreditStat"; 15; 256*0)
		End if 
	End if 
	
	Alert_OPiP
	
	OrdProssFillVar(1)
	QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
	OrdLnFillRays
	//  --  CHOPPED  AL_UpdateArrays(eOrdLines; -2)
	vi1:=[Order:3]idNum:2
	//  CHOPPED MM_SetDate(ePopDate; [Order]dateNeeded)
	If ($lastRec#aOrdRecs)
		//REDUCE SELECTION([POLine];0)
		//PoLnFillRays (0)
		QUERY:C277([POLine:40]; [POLine:40]idNumOrder:16=[Order:3]idNum:2)
		PoLnFillRays(Records in selection:C76([POLine:40]))
		//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
		//REDUCE SELECTION([PO];0)
		QUERY:C277([PO:39]; [PO:39]idNumOrder:18=[Order:3]idNum:2)
		PoArrayManage(-5)
		ServiceArrayInit(0)
		//  --  CHOPPED  AL_UpdateArrays(eService; -2)  //after clearing service records
		////  --  CHOPPED  AL_UpdateArrays (eOpenOrds;-2)  no change requiring this
		If (False:C215)
			If ($goDirection>0)
				// -- AL_SetSelect(eOpenOrds; aRayLines)
				
				viVert:=aRayLines{1}
				// -- AL_SetScroll(eOpenOrds; viVert; viHorz)
			End if 
		End if 
	End if 
End if 
HIGHLIGHT TEXT:C210(v8; 1; 25)